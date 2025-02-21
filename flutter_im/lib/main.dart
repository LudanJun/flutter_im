import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_im/pages/splash/splash_page.dart';
import 'package:flutter_im/styles/theme.dart';
import 'package:flutter_im/values/colors.dart';
import 'package:flutter_im/values/sizes.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Almaren", //应用名称
      defaultTransition: Transition.rightToLeft, //默认从右向左切换
      theme: ThemeData(
        useMaterial3: true, //使用Material3
        fontFamily: "Poppins", // 字体
        scaffoldBackgroundColor: Colors.white, //页面背景颜色
        splashFactory: NoSplash.splashFactory, //去除水波纹效果
        //AppBar主题
        appBarTheme: AppBarTheme(
          elevation: 0, //去除阴影
          scrolledUnderElevation: 0, //去除滚动时的阴影
          foregroundColor: Colors.black, //标题颜色 返回按钮颜色
          backgroundColor: Colors.transparent, //导航栏背景颜色
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent, // 状态栏颜色
            statusBarBrightness: Brightness.light, //状态亮度
            statusBarIconBrightness: Brightness.dark, //状态栏图标亮度
            systemNavigationBarColor: Colors.transparent, //导航栏颜色
            systemNavigationBarIconBrightness: Brightness.dark, //导航栏图标亮度
            systemNavigationBarContrastEnforced: false, //导航栏对比度
          ),
        ),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF212529), //按钮文字颜色 进度条
          surface: Color(0xFF212529), //表面颜色，可以设置按钮背景 等颜色
          // onSurface: Colors.white, //表面颜色，按钮 等颜色
          // onPrimary: Colors.white, //按钮文字颜色 进度条
          // onSecondary: Colors.white, //背景颜色
          // onError: Colors.red, //错误颜色
          // onSurfaceVariant: Colors.white, //按钮文字颜色 进度条
          // secondary: Color(0xFF212529), //背景颜色
          // error: Colors.red, //错误颜色
        ),
        textTheme: TextTheme(
          /// 最大的显示样式 ，作为屏幕上最大的文本 重要的文字或数字。
          displayLarge: TextStyle(),
          displayMedium: TextStyle(fontSize: 35),
          displaySmall: TextStyle(),

          //标题样式(小于display)
          headlineLarge: TextStyle(fontSize: 30),
          headlineMedium: TextStyle(fontSize: 25),
          headlineSmall: TextStyle(),

          //标题样式(小于headline)
          titleLarge: TextStyle(fontSize: 20),
          titleMedium: TextStyle(),
          titleSmall: TextStyle(),

          //正文样式(小于body)
          bodyLarge: TextStyle(fontSize: 20),
          bodyMedium: TextStyle(fontSize: 16),
          bodySmall: TextStyle(),
          labelLarge: TextStyle(fontSize: 20),
          labelMedium: TextStyle(),
          labelSmall: TextStyle(),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          elevation: 0, //底部导航栏阴影
          color: Colors.transparent, //底部导航栏颜色
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          //底部导航栏主题
          elevation: 0,
          backgroundColor: Colors.transparent, //底部导航栏颜色
        ),
        //按钮主题
        elevatedButtonTheme: ElevatedButtonThemeData(
          // style: ElevatedButton.styleFrom(
          //   backgroundColor: Colors.blue, //按钮颜色
          //   foregroundColor: Colors.white, //文字颜色
          //   elevation: 0, //去除阴影
          // ),
          style: ButtonStyle(
            minimumSize: WidgetStatePropertyAll(
              Size.fromHeight(56), //按钮高度
            ),
            foregroundColor: const WidgetStatePropertyAll(
              Colors.white, //按钮文字颜色
            ),
            elevation: WidgetStatePropertyAll(0), //去除阴影
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), //按钮圆角
              ),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          //文本按钮主题
          // 按钮样式
          style: ButtonStyle(
            // 按钮样式
            minimumSize: WidgetStatePropertyAll(Size.fromHeight(56)), // 按钮高度
            shape: WidgetStatePropertyAll(
              // 按钮形状
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ), // 圆角
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          // 输入框主题
          //输入框样式
          filled: true, //是否填充
          fillColor: ThemeColors.bgColor, //填充色
          hintStyle: TextStyle(color: ThemeColors.hintColor), //提示文字样式
          border: OutlineInputBorder(
            //边框样式
            borderSide: BorderSide.none, //边框颜色
            borderRadius: Sizes.borderRadius, //圆角
          ),
          focusedBorder: OutlineInputBorder(
            //获取焦点时的边框样式
            borderSide: BorderSide.none, //边框颜色
            borderRadius: Sizes.borderRadius, //圆角
          ),
        ),
        extensions: <ThemeExtension<dynamic>>[
          const AppTheme(
            hintMedium: TextStyle(color: ThemeColors.hintColor),
          ), //提示文字样式
        ],
      ), //主题
      darkTheme: ThemeData(
        useMaterial3: true, //使用Material3
        fontFamily: "Poppins", //字体
        scaffoldBackgroundColor: Colors.black, //背景色
        splashFactory: NoSplash.splashFactory, //去除水波纹效果
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0, //去除阴影
          backgroundColor: Colors.transparent, //背景色
        ),
      ),

      themeMode: ThemeMode.light, //主题模式
      debugShowCheckedModeBanner: false, //去除debug标签
      builder: FlutterSmartDialog.init(), //初始化弹窗
      home: const SplashPage(), //首页
    );
  }
}
