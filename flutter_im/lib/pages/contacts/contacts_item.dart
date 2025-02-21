import 'package:flutter/material.dart';
import 'package:flutter_im/models/contacts.dart';
import 'package:flutter_im/values/sizes.dart';
import 'package:flutter_im/widgets/avatar_widget.dart';
import 'package:flutter_styled/size_extension.dart';

/// 联系人列表 - 子项
class ContactsItem extends StatelessWidget {
  final Contacts contacts; // 联系人信息
  final Function() onTap; // 点击事件
  const ContactsItem({super.key, required this.contacts, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: Sizes.borderRadiusSmall,
              child: AvatarWidget(avatar: contacts.portrait),
            ),
            16.horizontalSpace,

            /// 昵称 和消息内容
            Expanded(
              child: Text(contacts.name),
            ),
          ],
        ),
      ),
    );
  }
}
