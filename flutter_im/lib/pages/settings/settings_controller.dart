import 'package:flutter/cupertino.dart';
import 'package:flutter_im/dialogs/dialogs.dart';
import 'package:flutter_im/mixin/appbar_mixin.dart';
import 'package:flutter_im/pages/splash/splash_page.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController
    with AppbarMixin, GetSingleTickerProviderStateMixin {
  @override
  void onInit() {
    super.onInit();
    fadeController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(fadeController!);
  }

  /// 注销登录的账号
  void logout() async {
    bool? result = await Dialogs.showAsk(
        "Log Out", "Do you want to log out of the current account?");
    if (result == true) {
      print("确定");
      var shared = await SharedPreferences.getInstance();
      shared.clear();
      Get.offAll(
        () => SplashPage(),
        transition: Transition.downToUp,
      );
    } else {
      print("取消");
    }
  }
}
