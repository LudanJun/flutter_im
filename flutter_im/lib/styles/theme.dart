import 'package:flutter/material.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  //  定义一个AppTheme类，继承自ThemeExtension<AppTheme>
  const AppTheme({
    //  构造函数，传入一个TextStyle类型的hintMedium参数
    required this.hintMedium,
  });

  /// 默认提示文本
  final TextStyle hintMedium;

  @override //  重写copyWith方法
  ThemeExtension<AppTheme> copyWith() {
    return this;
  }

  @override //  重写lerp方法
  ThemeExtension<AppTheme> lerp(
    covariant ThemeExtension<AppTheme>? other,
    double t,
  ) {
    return this;
  }
}
