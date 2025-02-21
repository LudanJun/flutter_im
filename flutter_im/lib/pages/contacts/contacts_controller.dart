import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_im/mixin/appbar_mixin.dart';
import 'package:flutter_im/models/contacts.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ContactsController extends GetxController
    with AppbarMixin, StateMixin, GetSingleTickerProviderStateMixin {
  ///联系人列表
  ///是一个可选的命名参数，它表示这个列表是否是可增长的。
  ///当 growable 为 true 时，意味着这个列表可以动态地添加或移除元素；
  ///如果设置为 false，则列表是不可变的，一旦创建就不能再改变其长度。
  List<Contacts> contacts = List.empty(growable: true);

  @override
  void onInit() {
    super.onInit(); //  调用父类的onInit方法
    fadeController = AnimationController(
      //  创建一个AnimationController对象，用于控制动画的执行
      vsync: this,
      //  设置动画的执行时间
      duration: Duration(milliseconds: 300),
    );
    //  创建一个Tween对象，用于定义动画的起始值和结束值
    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(fadeController!);

    _loadData();
  }

  /// 初始化数据
  _loadData() async {
    // 模拟延迟
    await Future.delayed(Durations.medium4);
    // 增加测试数据
    contacts.add(Contacts()
      ..name = "Dream.Machine"
      ..portrait = "images/avatar/1.jpg");
    contacts.add(Contacts()
      ..name = "Fudio X"
      ..portrait = "images/avatar/7.jpg");
    contacts.add(Contacts()
      ..name = "❤️ Ruben Dias ❤️"
      ..portrait = "images/avatar/8.jpg");
    contacts.add(Contacts()
      ..name = "Livia Herwitz"
      ..portrait = "images/avatar/6.jpg");
    contacts.add(Contacts()
      ..name = "Emerson Herwitz"
      ..portrait = "images/avatar/9.jpg");
    contacts.add(Contacts()
      ..name = "Giana Torff"
      ..portrait = "images/avatar/5.jpg");
    contacts.add(Contacts()
      ..name = "Dulce Bator"
      ..portrait = "images/avatar/4.jpg");
    contacts.add(Contacts()
      ..name = "Aspen Last"
      ..portrait = "images/avatar/10.jpg");
    contacts.add(Contacts()
      ..name = "Emerson Herwitz"
      ..portrait = "images/avatar/3.jpg");
    contacts.add(Contacts()
      ..name = "Spoony"
      ..portrait = "images/avatar/2.jpg");

    change(GetStatus.success(contacts));
  }
}
