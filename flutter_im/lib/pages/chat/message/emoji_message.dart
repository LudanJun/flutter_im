import 'package:flutter/material.dart';
import 'package:flutter_im/models/message.dart';
import 'package:flutter_svg/svg.dart';

class EmojiMessage extends StatelessWidget {
  final Message message;

  const EmojiMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return message.content;
  }
}
