import 'package:flutter/material.dart';
import 'package:flutter_im/pages/settings/settings_controller.dart';
import 'package:flutter_im/widgets/appbar_blur_widget.dart';
import 'package:flutter_im/widgets/body_title.dart';
import 'package:flutter_im/widgets/menu_item.dart';
import 'package:flutter_styled/size_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

/// 设置页面
class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
    return Scaffold(
      appBar: blurAppBarFade(
        context: context,
        fadeAnimation: controller.fadeAnimation,
        scrollController: controller.scrollController,
        title: "设置",
        actions: [
          IconButton(
            onPressed: controller.logout,
            icon: SvgPicture.asset("images/logout.svg"),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        controller: controller.scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BodyTitle(title: "设置"),
                  20.verticalSpace,
                  MenuItem(
                    title: "保存的媒体",
                    onTap: () {},
                  ),
                  MenuItem(
                    title: "通知",
                    onTap: () {},
                  ),
                  MenuItem(
                    title: "隐私和安全",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
