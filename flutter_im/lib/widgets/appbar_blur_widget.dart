import 'package:flutter/material.dart';
import 'package:flutter_im/widgets/blur_widget.dart';
import 'package:flutter_styled/size_extension.dart';

//获取半透明的Appbar
PreferredSizeWidget blurAppBarEx({
  Widget? leading,
  Widget? title,
  double? appHeight,
  List<Widget>? actions,
  double? titleSpacing,
  bool centerTitle = false,
  required BuildContext context,
  required Animation<double> fadeAnimation,
  required ScrollController scrollController,
}) {
  if (actions != null) { // 如果actions不为空，则添加一个水平间距
    actions.add(10.horizontalSpace);
  }
  return PreferredSize(
    preferredSize: Size.fromHeight(appHeight ?? kToolbarHeight),
    child: AnimatedBuilder(
      animation: scrollController, //  监听scrollController的变化
      child: AppBar( //  子组件
        leading: leading, //  导航栏左侧组件
        title: title, //  导航栏标题
        actions: actions, //  导航栏右侧组件
        elevation: 0, //  导航栏阴影
        scrolledUnderElevation: 0, //  导航栏展开时的阴影
        titleSpacing: titleSpacing ?? (leading != null ? 0 : null), //  标题间距
        centerTitle: centerTitle, //  标题是否居中
      ),
      builder: (context, child) { //  构建器
        return BlurWidgetEx( //  返回一个BlurWidgetEx组件
          enabled: scrollController.hasClients && scrollController.offset > 0, //  是否启用模糊效果
          child: child, //  子组件
        );
      },
    ),
  );
}

PreferredSizeWidget blurAppBarFade({ //  定义一个带有模糊效果的AppBar，并带有淡入淡出效果
  String? title, //  标题
  Widget? leading, //  导航按钮
  double? appHeight, //  AppBar高度
  List<Widget>? actions, //  右侧操作按钮
  double? titleSpacing, //  标题间距
  bool centerTitle = false, //  标题是否居中
  required BuildContext context, //  上下文
  required Animation<double> fadeAnimation, //  淡入淡出动画
  required ScrollController scrollController, //  滚动控制器
}) {
  if (actions != null) { //  如果有右侧操作按钮，则添加一个水平间距
    actions.add(10.horizontalSpace);
  }
  return PreferredSize( //  返回一个PreferredSize，设置preferredSize为AppBar高度
    preferredSize: Size.fromHeight(appHeight ?? kToolbarHeight),
    child: AnimatedBuilder( //  使用AnimatedBuilder，监听滚动控制器
      animation: scrollController,
      child: AppBar( //  子组件为AppBar
        leading: leading, //  设置导航按钮
        title: FadeTransition( //  设置标题
          opacity: fadeAnimation,
          child: Text( //  设置标题的透明度
            title ?? "",
            style: Theme.of(context).textTheme.labelLarge!, //  如果标题为空，则显示空字符串
          ), //  设置标题的样式
        ),
        actions: actions, //  设置标题栏的子组件
        elevation: 0, //  设置标题栏的右侧操作按钮
        scrolledUnderElevation: 0, //  设置标题栏的阴影高度
        titleSpacing: titleSpacing ?? (leading != null ? 0 : null), //  设置标题栏在滚动时的阴影高度
        centerTitle: centerTitle, //  设置标题栏的标题与左侧组件之间的间距
      ), //  设置标题栏的标题是否居中
      builder: (context, child) { //  设置标题栏的构造器
        return BlurWidgetEx(
          enabled: scrollController.hasClients && scrollController.offset > 0, //  设置模糊效果
          child: child, //  如果滚动控制器有客户端并且滚动偏移量大于0，则启用模糊效果
        );
      },
    ),
  );
}
