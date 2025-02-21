import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_im/models/chat.dart';
import 'package:flutter_im/pages/chats/chats_controller.dart';
import 'package:flutter_im/pages/chats/chats_item.dart';
import 'package:flutter_im/widgets/appbar_blur_widget.dart';
import 'package:flutter_im/widgets/body_title.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

/// 会话页面
class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  //找到对应控制器
  ChatsController controller = Get.put<ChatsController>(ChatsController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatsController>(
      init: ChatsController(),
      builder: (controller) => Scaffold(
        appBar: blurAppBarFade(
          context: context,
          fadeAnimation: controller.fadeAnimation,
          scrollController: controller.scrollController,
          leading: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("images/search.svg"),
          ),
          title: "聊天",
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("images/plus.svg"),
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: controller.obx(
          (state) => EasyRefresh(
            header: ClassicHeader(
              position: IndicatorPosition.locator,
            ),
            onRefresh: () async {
              await controller.onRefresh();
              return IndicatorResult.success;
            },
            child: _buildList(context),
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return CustomScrollView(
      controller: controller.scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        //  创建一个SliverSafeArea，用于在Sliver列表的顶部和底部添加安全区域
        SliverSafeArea(
          bottom: false, //  设置底部安全区域为false，即不添加底部安全区域
          sliver: HeaderLocator
              .sliver(), //  设置sliver为HeaderLocator.sliver()，即使用HeaderLocator.sliver()作为sliver
        ),
        SliverToBoxAdapter(
          child: BodyTitle(title: "聊天"),
        ),
        //  创建一个SliverSafeArea，用于包裹SliverList
        SliverSafeArea(
          top: false, //  设置顶部安全区域为false，即不显示顶部安全区域
          sliver: SliverList.builder(
            //  设置SliverList
            itemCount: controller
                .chats.length, //  设置SliverList的itemCount为controller.chats的长度
            itemBuilder: (context, index) {
              //  设置SliverList的itemBuilder
              Chat chat = controller.chats[index]; //  获取当前索引对应的Chat对象
              //  返回ChatsItem组件，并传入chat和onTap回调函数
              return ChatsItem(
                chat: chat,
                onTap: () {
                  controller
                      .showChat(chat); //  点击时调用controller的showChat方法，传入chat对象
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

/// 会话页面 Getx的两种用法
// class ChatsPage extends GetView<ChatsController> {
//   const ChatsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.put(ChatsController());
//     return Scaffold(
//       appBar: blurAppBarFade(
//         context: context,
//         fadeAnimation: controller.fadeAnimation,
//         scrollController: controller.scrollController,
//         leading: IconButton(
//           onPressed: () {},
//           icon: SvgPicture.asset("images/search.svg"),
//         ),
//         title: "Chats",
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: SvgPicture.asset("images/plus.svg"),
//           ),
//         ],
//       ),
//       extendBodyBehindAppBar: true,
//       body: controller.obx(
//         (state) => EasyRefresh(
//           header: ClassicHeader(
//             position: IndicatorPosition.locator,
//           ),
//           onRefresh: () async {
//             await controller.onRefresh();
//             return IndicatorResult.success;
//           },
//           child: _buildList(context),
//         ),
//       ),
//     );
//   }

//   Widget _buildList(BuildContext context) {
//     return CustomScrollView(
//       controller: controller.scrollController,
//       physics: AlwaysScrollableScrollPhysics(),
//       slivers: [
//         //  创建一个SliverSafeArea，用于在Sliver列表的顶部和底部添加安全区域
//         SliverSafeArea(
//           bottom: false, //  设置底部安全区域为false，即不添加底部安全区域
//           sliver: HeaderLocator
//               .sliver(), //  设置sliver为HeaderLocator.sliver()，即使用HeaderLocator.sliver()作为sliver
//         ),
//         SliverToBoxAdapter(
//           child: BodyTitle(title: "Chats"),
//         ),
//         //  创建一个SliverSafeArea，用于包裹SliverList
//         SliverSafeArea(
//           top: false, //  设置顶部安全区域为false，即不显示顶部安全区域
//           sliver: SliverList.builder(
//             //  设置SliverList
//             itemCount: controller
//                 .chats.length, //  设置SliverList的itemCount为controller.chats的长度
//             itemBuilder: (context, index) {
//               //  设置SliverList的itemBuilder
//               Chat chat = controller.chats[index]; //  获取当前索引对应的Chat对象
//               //  返回ChatsItem组件，并传入chat和onTap回调函数
//               return ChatsItem(
//                 chat: chat,
//                 onTap: () {
//                   controller
//                       .showChat(chat); //  点击时调用controller的showChat方法，传入chat对象
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
