import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_im/pages/frame/frame_page.dart';
import 'package:flutter_im/pages/intro/intro_page.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 启动屏幕 - 显示一个居中的logo
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initData() async {
    // TODO: 初始化数据
    EasyRefresh.defaultHeaderBuilder =
        () => const ClassicHeader(
          safeArea: true, // 是否安全区域
          position: IndicatorPosition.locator, //指示器位置
        );
    EasyRefresh.defaultFooterBuilder =
        () => const ClassicFooter(
          safeArea: true, // 是否安全区域
          position: IndicatorPosition.locator, //指示器位置
        );
    await Future.delayed(const Duration(milliseconds: 1500)); //延时3秒
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("userId") != null) {
      loginCallback(); //已登录
    } else {
      introCallback(); //未登录
    }
  }

  //登录成功回调
  loginCallback() {
    Get.off(() => const FramePage()); //已登录
  }

  //初始化回调
  introCallback() {
    //未登录
    precacheImage(
      const AssetImage("images/intro_bg.jpg"),
      Get.context!,
    ); //预加载图片
    Get.off(() => const IntroPage(), transition: Transition.fadeIn); //未登录
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Center(
        child: Text(
          "奥玛伦岛",
          style: TextStyle(fontSize: 65, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
