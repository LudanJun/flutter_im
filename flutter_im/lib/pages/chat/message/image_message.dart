import 'package:flutter/material.dart';
import 'package:flutter_im/models/message.dart';
import 'package:flutter_im/values/sizes.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ImageMessage extends StatelessWidget {
  const ImageMessage(
      {super.key, required this.message}); //  构造函数，接收一个key和一个message参数

  final Message message; //  message参数

  @override //  重写build方法
  Widget build(BuildContext context) {
    AssetEntity asset = message.content; //  获取message的content属性
    return ClipRRect(
      //  返回一个ClipRRect组件，设置圆角半径为Sizes.borderRadiusSmall
      borderRadius: Sizes.borderRadiusSmall,
      child: Image(
          image: AssetEntityImageProvider(asset,
              isOriginal: true)), //  在ClipRRect组件中添加一个Image组件，设置图片为asset，并设置为原图
    );
  }
}
