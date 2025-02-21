import 'package:flutter/material.dart';

/// 头像组件
class AvatarWidget extends StatelessWidget {
  final String? avatar;
  final double size;
  const AvatarWidget({
    super.key,
    this.avatar,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    if (avatar == null) {
      return SizedBox(
        width: size,
        height: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
        ),
      );
    } else {
      Widget image;
      if (avatar!.startsWith('http')) {
        //网络图片
      }
      image = Image.asset(
        avatar!,
        fit: BoxFit.cover,
        width: size,
        height: size,
        cacheWidth: size.toInt() * 3,
      );
      return image;
    }
  }
}
