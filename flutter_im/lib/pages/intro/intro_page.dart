import 'package:flutter/material.dart';
import 'package:flutter_im/pages/login/login_page.dart';
import 'package:flutter_im/styles/theme.dart';
import 'package:flutter_styled/size_extension.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

//显示主页图片页面
class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: InkWell(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Image.asset("images/intro_bg.jpg"),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 20,
                  bottom: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, //使子组件在水平方向上拉伸
                  children: [
                    Text(
                      "Almaren\nMessager",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    10.verticalSpace,
                    Text(
                      "Powered by Dream.Machine",
                      style: Theme.of(context)
                          .extension<AppTheme>()!
                          .hintMedium, //使用extension来获取自定义的AppTheme
                    ),
                    20.verticalSpace,
                    ElevatedButton(
                      onPressed: () {
                        Get.to(
                          () => const LoginPage(),
                        );
                      },
                      child: const Text(
                        "Continue with phone",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
