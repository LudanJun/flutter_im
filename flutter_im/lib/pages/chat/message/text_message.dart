import 'package:flutter/material.dart';
import 'package:flutter_im/models/message.dart';
import 'package:flutter_im/values/sizes.dart';

class TextMessage extends StatelessWidget {
  const TextMessage(
      {super.key, required this.message}); //  构造函数，接收一个key和一个message参数

  final Message message; //  定义一个Message类型的变量

  @override //  重写build方法
  Widget build(BuildContext context) {
    return DecoratedBox(
      //  返回一个装饰的盒子
      decoration: BoxDecoration(
        //  设置装饰的样式
        color: Color(0xFFE9ECEF), //  设置背景颜色
        borderRadius: Sizes.borderRadiusSmall, //  设置圆角
      ),
      child: Padding(
        //  设置内边距
        padding: const EdgeInsets.all(10.0),
        //  显示message的内容
        child: Text(message.content),
      ),
    );
  }
}
