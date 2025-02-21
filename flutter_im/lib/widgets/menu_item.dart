import 'package:flutter/material.dart';

/// 菜单列表 - 子项
class MenuItem extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const MenuItem({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }
}
