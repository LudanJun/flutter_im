import 'package:flutter/material.dart';
import 'package:flutter_im/values/colors.dart';

/// 在线盒子
class OnlineBoxWidget extends StatelessWidget {
  final bool online; // / 是否在线
  final Widget child; // / 子组件
  const OnlineBoxWidget({
    super.key,
    required this.online,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ImageFiltered( //  返回一个ImageFiltered组件
      imageFilter: const ColorFilter.mode( //  设置颜色滤镜
        Colors.grey,
        BlendMode.color,
      ),
      enabled: !online, //  如果不在线，则启用滤镜
      child: Stack(
        children: [
          child,
          Positioned(
            right: 2,
            bottom: 2,
            child: Container(
              width: 10, //  容器宽度
              height: 10, //  容器高度
              decoration: BoxDecoration( //  容器装饰
                borderRadius: BorderRadius.circular(10), //  圆角半径
                color: ThemeColors.greenColor, //  背景颜色
              ),
            ),
          ),
        ],
      ),
    );
  }
}
