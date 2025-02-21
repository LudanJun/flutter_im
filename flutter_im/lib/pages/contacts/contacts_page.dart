import 'package:flutter/material.dart';
import 'package:flutter_im/models/contacts.dart';
import 'package:flutter_im/pages/contacts/contacts_controller.dart';
import 'package:flutter_im/pages/contacts/contacts_item.dart';
import 'package:flutter_im/widgets/appbar_blur_widget.dart';
import 'package:flutter_im/widgets/body_title.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

/// 联系人列表
class ContactsPage extends GetView<ContactsController> {
  const ContactsPage({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(ContactsController());

    return Scaffold(
      appBar: blurAppBarFade(
        context: context,
        fadeAnimation: controller.fadeAnimation,
        scrollController: controller.scrollController,
        title: '联系人',
      ),
      extendBodyBehindAppBar: true, // 让appBar在body之上
      body: controller.obx(
        (state) => _buildList(context),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return CustomScrollView(
      controller: controller.scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverSafeArea(
          bottom: false,
          sliver: SliverToBoxAdapter(
            child: BodyTitle(title: "联系人"),
          ),
        ),
        SliverSafeArea(
          top: false,
          sliver: SliverList.builder(
            itemCount: controller.contacts.length,
            itemBuilder: (context, index) {
              Contacts contacts = controller.contacts[index];
              return ContactsItem(
                contacts: contacts,
                onTap: () {
                  print("点击了第$index个");
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
