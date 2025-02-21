import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_im/models/message.dart';
import 'package:flutter_im/models/message_type.dart';
import 'package:flutter_im/pages/chat/chat_controller.dart';
import 'package:flutter_im/pages/chat/message/emoji_message.dart';
import 'package:flutter_im/pages/chat/message/image_message.dart';
import 'package:flutter_im/pages/chat/message/text_message.dart';
import 'package:flutter_im/utils/keyboard_utils.dart';
import 'package:flutter_im/values/colors.dart';
import 'package:flutter_im/values/sizes.dart';
import 'package:flutter_im/widgets/appbar_blur_widget.dart';
import 'package:flutter_im/widgets/avatar_widget.dart';
import 'package:flutter_im/widgets/blur_widget.dart';
import 'package:flutter_im/widgets/online_box_widget.dart';
import 'package:flutter_styled/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_switch_panel/flutter_switch_panel.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatController()); //  将ChatController实例放入Get中
    final keyBoardHeight = MediaQuery.of(context).viewInsets.bottom; //  获取键盘高度
    controller.switchPanelController
        .setKeyBoardHeight(keyBoardHeight); //  设置键盘高度

    return Scaffold(
      appBar: blurAppBarEx(
        context: context,
        fadeAnimation: controller.fadeAnimation, //  设置模糊效果
        scrollController: controller.scrollController, //  设置滚动控制器
        title: Row(
          //  设置标题
          children: [
            ClipRRect(
              //  设置头像
              borderRadius: Sizes.borderRadiusSmall,
              child: OnlineBoxWidget(
                online: controller.online,
                child: AvatarWidget(
                  size: 40,
                  avatar: controller.chat?.portrait,
                ),
              ),
            ),
            16.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.chat?.name ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                2.verticalSpace, //  添加垂直间距
                Text(
                  //  显示在线状态
                  controller.online ? "Online" : "",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: controller.online
                            ? ThemeColors.greenColor
                            : ThemeColors.greyColor,
                      ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          //  添加操作按钮
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("images/camera.svg"),
          ),
        ],
      ),
      extendBody: true, //  扩展主体
      extendBodyBehindAppBar: true, //  扩展主体在应用栏后面
      resizeToAvoidBottomInset: false, //  避免底部插入
      body: _buildView(), //  构建视图
      bottomNavigationBar: _buildInputView(context), //  构建输入视图
    );
  }

  // 主视图
  Widget _buildView() {
    //  构建视图
    return GestureDetector(
      //  返回一个GestureDetector，用于处理点击事件
      behavior:
          HitTestBehavior.opaque, //  设置HitTestBehavior为opaque，表示该组件可以接收点击事件
      onTap: () {
        //  点击事件处理函数
        KeyboardUtils.hide(); //  隐藏键盘
        controller.switchPanelController.hide(); //  隐藏面板控制器
      },
      child: LayoutBuilder(
        //  子组件
        builder: (context, constraints) {
          //  构建布局
          return CustomScrollView(
            //  返回一个CustomScrollView，用于滚动
            cacheExtent: 2000, //  缓存范围
            controller: controller.scrollController, //  滚动控制器
            slivers: [
              //  slivers列表
              SliverSafeArea(
                //  安全区域
                sliver: SliverPadding(
                  //  sliver组件
                  padding: EdgeInsets.symmetric(vertical: 20), //  内边距
                  sliver: _buildList(constraints), //  sliver组件
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildList(BoxConstraints constraints) {
    /// 计算图片的缓存宽度 1.5倍超采样
    //int cacheWidth = (MediaQuery.sizeOf(context).width * 1.5).toInt();

    //  返回一个SliverList，用于显示列表
    return Obx(
      () => SliverList.separated(
        itemCount: controller.message.length,//  //  列表长度
        itemBuilder: (context, index) {
          Message message = controller.message[index];
          return _buildItem(message, constraints);
        },
        separatorBuilder: (BuildContext context, int index) {
          return 20.verticalSpace;
        },
      ),
    );
  }

  Widget _buildItem(Message message, BoxConstraints constraints) {
    List<Widget> children = List.empty(growable: true);
    // 内容组件
    Widget content;
    // 根绝类型渲染对应组件
    switch (message.type) {
      case MessageType.text:
        content = TextMessage(message: message);
        break;
      case MessageType.image:
        content = ImageMessage(message: message);
        break;
      case MessageType.emoji:
        content = EmojiMessage(message: message);
      default:
        content = SizedBox();
        break;
    }

    ConstrainedBox render = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: constraints.maxWidth / 2),
      child: content,
    );

    /// 头像组件
    Widget avatar = ClipRRect(
      borderRadius: Sizes.borderRadiusSmall,
      child: AvatarWidget(size: 40, avatar: controller.chat?.portrait),
    );
    if (message.send) {
      //发出消息
      children.add(
        Expanded(child: Align(alignment: Alignment.centerRight, child: render)),
      );
      children.add(
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 20),
          child: avatar,
        ),
      );
    } else {
      //收到消息
      children.add(
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: avatar,
        ),
      );
      children.add(
        Expanded(child: Align(alignment: Alignment.centerLeft, child: render)),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  // 输入框
  Widget _buildInputView(BuildContext context) {
    return BlurWidgetEx(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
                bottom: 10,
              ),
              child: DefaultTextHeightBehavior(
                textHeightBehavior: TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                  //applyHeightToLastDescent: false,
                  //leadingDistribution: TextLeadingDistribution.proportional,
                ),
                child: TextField(
                  controller: controller.inputController,
                  onChanged: (value) {
                    controller.showSend.value = value.isNotEmpty;
                  },
                  onTap: () async {
                    controller.switchPanelController.show();
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0x40FEFEFE),
                    hintText: "say something.",
                    prefixIcon: IconButton(
                      onPressed: () async {
                        KeyboardUtils.hide();
                        controller.switchPanelController.show(index: 0);
                      },
                      icon: SvgPicture.asset("images/emoji.svg"),
                    ),
                    suffixIcon: Obx(
                      () => controller.showSend.value
                          ? IconButton(
                              onPressed: controller.sendText,
                              icon: SvgPicture.asset(
                                "images/send.svg",
                                width: 20,
                                height: 20,
                              ),
                            )
                          : IconButton(
                              onPressed: () async {
                                KeyboardUtils.hide();
                                controller.switchPanelController.show(
                                  index: 1,
                                );
                              },
                              icon: SvgPicture.asset("images/plus.svg"),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            _buildBottom(),
          ],
        ),
      ),
    );
  }

  // 底部区域
  Widget _buildBottom() {
    return FlutterSwitchPanel(
      panelHeight: 160,
      controller: controller.switchPanelController,
      children: [_buildEmojiPickerPanel(), _buildToolPanel()],
    );
  }

  // 底部表情选择容器
  Widget _buildEmojiPickerPanel() {
    return GridView.builder(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      itemCount: 100,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 32,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemBuilder: (BuildContext context, int index) {
        //'assets/emoji/emoji-1.svg'
        int id = index + 1;
        return InkWell(
          onTap: () {
            controller.sendEmoji(id);
          },
          child: SvgPicture.asset('images/emoji/emoji-$id.svg'),
        );
      },
    );
  }

  // 工具箱容器
  Widget _buildToolPanel() {
    return GridView(
      padding: const EdgeInsets.only(top: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 20,
        mainAxisExtent: 60,
      ),
      children: [
        _buildToolItem(
          name: "相册", //"Album", //"相册"
          icon: "images/tools/chatAlbum.webp",
          onTap: controller.ontapAlbum,
        ),
        _buildToolItem(
          name: "拍摄", //"Photo", //"拍摄"
          icon: "images/tools/chatCamera.webp",
          onTap: controller.ontapPhoto,
        ),
        _buildToolItem(
          name: "音视频通话", //"Call", //"音视频通话"
          icon: "images/tools/chatCall.webp",
        ),
        _buildToolItem(
          name: "文件", //"File", //"文件"
          icon: "images/tools/chatFile.webp",
        ),
        _buildToolItem(
          name: "红包", // "Wallet", //"红包"
          icon: "images/tools/chatHongbao.webp",
        ),
        _buildToolItem(
          name: "转账", //"Transfer", //"转账"
          icon: "images/tools/chatTransfer.webp",
        ),
        _buildToolItem(
          name: "收藏", // "Collect", //收藏
          icon: "images/tools/chatCollect.webp",
        ),
      ],
    );
  }

  // 工具箱单项
  Widget _buildToolItem({
    required String name,
    required String icon,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon, width: 24, height: 24),
          6.verticalSpace,
          Text(
            name,
            style: const TextStyle(fontSize: 15, color: Color(0xFF333333)),
          ),
        ],
      ),
    );
  }
}
