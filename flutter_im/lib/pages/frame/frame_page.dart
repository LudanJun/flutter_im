import 'package:flutter/material.dart';
import 'package:flutter_im/pages/chats/chats_page.dart';
import 'package:flutter_im/pages/contacts/contacts_page.dart';
import 'package:flutter_im/pages/settings/settings_page.dart';
import 'package:flutter_im/widgets/blur_widget.dart';
import 'package:flutter_svg/svg.dart';

class FramePage extends StatefulWidget {
  const FramePage({super.key});

  @override
  State<FramePage> createState() => _FramePageState();
}

class _FramePageState extends State<FramePage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BackdropGroup(
      //背景层
      child: Scaffold(
        //内容层
        extendBody: true, //内容层延伸到状态栏
        body: IndexedStack(
          index: pageIndex,
          children: const [
            ChatsPage(),
            ContactsPage(),
            SettingsPage(),
          ],
        ),
        bottomNavigationBar: BlurWidgetEx(
          child: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                pageIndex = value;
              });
            },
            currentIndex: pageIndex, //当前选中的索引
            showSelectedLabels: false, //是否显示选中的标签
            showUnselectedLabels: false, //是否显示未选中的标签
            items: [
              BottomNavigationBarItem(
                activeIcon:
                    SvgPicture.asset("images/frame/frame_chat_active.svg"),
                icon: SvgPicture.asset("images/frame/frame_chat.svg"),
                label: "CHAT",
              ),
              BottomNavigationBarItem(
                activeIcon:
                    SvgPicture.asset("images/frame/frame_contacts_active.svg"),
                icon: SvgPicture.asset("images/frame/frame_contacts.svg"),
                label: "Contacts",
              ),
              BottomNavigationBarItem(
                activeIcon:
                    SvgPicture.asset("images/frame/frame_settings_active.svg"),
                icon: SvgPicture.asset("images/frame/frame_settings.svg"),
                label: "SETTING",
              )
            ],
          ),
        ),
      ),
    );
  }
}
