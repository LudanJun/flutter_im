import 'package:flutter/material.dart';
import 'package:flutter_im/pages/login/login_logic.dart';
import 'package:flutter_styled/size_extension.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/utils.dart';

///登录页面
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginLogic(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('登录'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Enter your phone number",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                30.verticalSpace,
                TextField(
                  controller: controller.phoneController,
                  decoration: InputDecoration(hintText: "Phone number"),
                ),
                Spacer(), //自动填充 剩余空间 点击文本框弹出键盘,自动调整位置
                Obx(
                  () => ElevatedButton(
                    onPressed: controller.inputSuccess.value
                        ? controller.checkPhone
                        : null,
                    child: const Text("Continue"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*
class LoginPage extends GetView<LoginLogic> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    //绑定视图控制器
    Get.put(LoginLogic()); //初始化
    return Scaffold(
      appBar: AppBar(
        title: const Text('登录'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Enter your phone number",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              30.verticalSpace,
              TextField(
                controller: controller.phoneController,
                decoration: InputDecoration(hintText: "Phone number"),
              ),
              Spacer(), //自动填充 剩余空间 点击文本框弹出键盘,自动调整位置
              Obx(
                () => ElevatedButton(
                  onPressed: controller.inputSuccess.value
                      ? controller.checkPhone
                      : null,
                  child: const Text("Continue"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
