import 'package:flutter/widgets.dart';
import 'package:flutter_im/pages/frame/frame_page.dart';
import 'package:flutter_im/utils/keyboard_utils.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginLogic extends GetxController {
  var inputSuccess = false.obs; //输入框是否输入成功

  late TextEditingController phoneController; //手机号输入框

  bool isCheckPhone = false; //是否验证手机号

  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
    phoneController.addListener(() {
      inputSuccess.value = phoneController.text.isNotEmpty;
    });
  }

  //检查手机号码 正确的话 进入 验证页面
  void checkPhone() async {
    KeyboardUtils.hide();

    if (!isCheckPhone) {
      isCheckPhone = true;
      String phone = phoneController.text;
      if (phone.isNotEmpty) {
        //手机号为空
        SmartDialog.showLoading(msg: '等待中...'); //显示loading
        await Future.delayed(const Duration(seconds: 2)); //等待2秒
        SmartDialog.dismiss(); //关闭loading
        var shared = await SharedPreferences.getInstance(); //获取本地存储
        shared.setString("userId", phone); //保存用户id
        Get.offAll(() => const FramePage()); //进入主页面
      }
      inputSuccess.value = isCheckPhone = false; //重置输入框状态
    }
  }
}
