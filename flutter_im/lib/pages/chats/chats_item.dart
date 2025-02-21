import 'package:flutter/material.dart';
import 'package:flutter_im/models/chat.dart';
import 'package:flutter_im/styles/theme.dart';
import 'package:flutter_im/values/sizes.dart';
import 'package:flutter_im/widgets/avatar_widget.dart';
import 'package:flutter_im/widgets/count_box_widget.dart';
import 'package:flutter_im/widgets/online_box_widget.dart';
import 'package:flutter_styled/size_extension.dart';

/// 会话列表 - 子项
class ChatsItem extends StatelessWidget {
  final Chat chat;
  final Function() onTap;
  const ChatsItem({
    super.key,
    required this.chat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            ///头像
            ClipRRect(
              borderRadius: Sizes.borderRadiusSmall,
              child: OnlineBoxWidget(
                online: chat.online,
                child: AvatarWidget(
                  avatar: chat.portrait,
                ),
              ),
            ),
            16.horizontalSpace,

            //昵称和消息内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(chat.name),
                  2.verticalSpace,
                  Text(
                    chat.msg ?? "",
                    maxLines: 1,
                    style: Theme.of(context).extension<AppTheme>()!.hintMedium,
                  ),
                ],
              ),
            ),

            ///时间和未读消息数量
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat.timestamp ?? "",
                ),
                2.verticalSpace,
                if (chat.unread != 0) ...{
                  CountBoxWidget(
                    count: chat.unread,
                  )
                }
              ],
            )
          ],
        ),
      ),
    );
  }
}
