import 'package:flutter/material.dart';
import 'package:flutter_im/mixin/appbar_mixin.dart';
import 'package:flutter_im/models/chat.dart';
import 'package:flutter_im/models/message.dart';
import 'package:flutter_im/models/message_type.dart';
import 'package:flutter_im/utils/keyboard_utils.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_switch_panel/flutter_switch_panel_controller.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class ChatController extends GetxController
    with AppbarMixin, GetSingleTickerProviderStateMixin {
  /// 会话对象
  late Chat? chat;

  /// 显示发送按钮
  RxBool showSend = false.obs;

  /// 是否在线
  bool get online => chat?.online == true;

  // 底部控制器
  late FlutterSwitchPanelController switchPanelController;

  /// 消息列表
  RxList<Message> message = RxList.empty(growable: true);

  /// 输入控制器
  late TextEditingController inputController;

  @override
  void onInit() {
    switchPanelController =
        FlutterSwitchPanelController(); //  初始化FlutterSwitchPanelController
    super.onInit();
    fadeController = AnimationController(
      //  初始化AnimationController，设置动画时长为300毫秒
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    fadeAnimation = Tween<double>(begin: 0, end: 1)
        .animate(fadeController!); //  初始化Tween，设置动画开始值为0，结束值为1
    inputController = TextEditingController(); //  初始化TextEditingController
    chat = Get.arguments; //  获取Get.arguments
  }

  @override
  void onClose() {
    inputController.dispose();
    switchPanelController.dispose();
    super.onClose();
  }

  /// 发送文本
  void sendText() {
    String text = inputController.text.trim();
    if (text.isNotEmpty) {
      message.add(Message(MessageType.text, content: text, send: true));
    }
    inputController.clear();
    showSend.value = false;
  }

  void sendEmoji(int id) {
    message.add(Message(MessageType.emoji,
        content: SvgPicture.asset('images/emoji/emoji-$id.svg'), send: true));
  }

  /// 点击相册
  ontapAlbum() async {
    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      Get.context!,
      pickerConfig: const AssetPickerConfig(requestType: RequestType.image),
    );

    if (result?.isNotEmpty == true) {
      // 发送图片消息
      for (AssetEntity entity in result!) {
        message.add(Message(MessageType.image, content: entity, send: true));
      }
    }
    KeyboardUtils.hide();
  }

  /// 拍照
  ontapPhoto() async {
    final AssetEntity? entity = await CameraPicker.pickFromCamera(
      Get.context!,
      pickerConfig: const CameraPickerConfig(),
    );

    if (entity != null) {
      // 发送图片消息
      message.add(Message(MessageType.image, content: entity, send: true));
    }
    KeyboardUtils.hide();
  }
}
