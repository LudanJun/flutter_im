import 'package:flutter/material.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  const AppTheme({required this.hintMedium});

  /// 默认提示文本
  final TextStyle hintMedium;

  @override
  ThemeExtension<AppTheme> copyWith() {
    //重写copyWith方法
    return this;
  }

  @override
  ThemeExtension<AppTheme> lerp(
    //重写lerp方法
    covariant ThemeExtension<AppTheme>? other,
    double t,
  ) {
    return this;
  }
}
