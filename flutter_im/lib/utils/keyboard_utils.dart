import 'package:flutter/material.dart';

/// 键盘工具
class KeyboardUtils {
  static void hide() => FocusManager.instance.primaryFocus?.unfocus(); //隐藏键盘
}
