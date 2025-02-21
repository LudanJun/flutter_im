import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';

/// Appbar标题透明度控制
/// 滚动列表监听
mixin AppbarMixin on GetxController {
  /// 控制器Appbar标题透明度的控制器
  AnimationController? fadeController;

  /// 透明度动画参数
  late Animation<double> fadeAnimation;

  /// 滚动列表的控制器
  late ScrollController scrollController = ScrollController()
    ..addListener(
      () {
        if (scrollController.offset >= 50) {
          //  如果滚动距离大于等于50，则开始动画
          fadeController!.forward();
        } else {
          if (fadeAnimation.value != 0 && scrollController.offset > 0) {
            //  如果动画的值不等于0且滚动距离大于0，则根据滚动距离调整动画的值
            var fade = scrollController.offset / 50;
            fadeController?.animateTo(fade); //  使用fadeController来动画到fade值
          } else {
            fadeController?.reverse(); //  否则，将动画的值重置为0
          }
        }
      },
    );

  @override
  void onClose() {
    fadeController?.dispose(); //  在关闭时，释放动画和滚动控制器的资源
    scrollController.dispose();
    super.onClose();
  }
}
