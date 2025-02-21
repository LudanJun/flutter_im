import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_im/values/colors.dart';

/// 模糊组件 ，用于实现模糊效果
class BlurWidget extends StatelessWidget {
  const BlurWidget({
    super.key,
    this.child,
    this.sigmaX = 15,
    this.sigmaY = 15,
    this.radius = BorderRadius.zero,
  });

  /// 模糊组件
  final Widget? child;

  /// 水平方向模糊程度
  final double sigmaX;

  /// 垂直方向模糊程度
  final double sigmaY;

  /// 边框圆角
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      //  返回一个裁剪圆角的组件
      // 裁剪圆角
      borderRadius: radius,
      child: BackdropFilter.grouped(
        //  使用BackdropFilter组件进行模糊处理
        filter: ImageFilter.blur(
            sigmaX: sigmaX, sigmaY: sigmaY), //ImageFilter可以实现高斯模糊,指定x,y轴的模糊因子
        child: child,
      ),
    );
  }
}

/// 模糊组件
class BlurWidgetEx extends StatelessWidget {
  const BlurWidgetEx({
    super.key,
    this.child,
    this.sigmaX = 12, //水平方向模糊程度
    this.sigmaY = 12, //垂直方向模糊程度
    this.blurRadius = 0, //模糊半径
    this.hasTopBorder = false, //是否显示顶部边框
    this.hasBottomBorder = false, //是否显示底部边框
    this.radius = BorderRadius.zero, //边框圆角
    this.enabled = true, //是否启用
  });

  final double sigmaX;

  final double sigmaY;

  final Widget? child; // / 模糊半径

  final double blurRadius;

  final BorderRadius radius; // / 边框圆角

  final bool hasTopBorder; // / 是否有顶部边框

  final bool hasBottomBorder; // / 是否有底部边框

  /// 是否启用背景模糊
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      // 裁剪圆角
      decoration: BoxDecoration(
        borderRadius: radius, //边框圆角
        boxShadow: blurRadius != 0 //模糊半径
            ? [
                BoxShadow(
                  color: const Color.fromRGBO(60, 60, 60, 0.15),
                  blurRadius: blurRadius,
                  blurStyle: BlurStyle.outer,
                ),
              ]
            : null,
      ),
      child: ClipRRect( //  子组件
        borderRadius: radius, //  圆角半径
        child: BackdropFilter.grouped( //  背景滤镜
          enabled: enabled, //  是否启用
          filter: ImageFilter.blur( //  滤镜
            sigmaX: sigmaX, //  水平方向模糊程度
            sigmaY: sigmaY, //  垂直方向模糊程度
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border(
                top: hasTopBorder //  如果有上边框，则设置上边框颜色为半透明的白色
                    ? const BorderSide(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                      )
                    : BorderSide.none,
                bottom: hasBottomBorder //  如果有下边框，则设置下边框颜色为半透明的白色
                    ? const BorderSide(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                      )
                    : BorderSide.none,
              ),
              color: ThemeColors.glassColor, //  设置背景颜色为玻璃色
            ),
            child: child, //  设置子组件
          ),
        ),
      ),
    );
  }
}
