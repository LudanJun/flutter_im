import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: InkWell(
        child: SafeArea(
          child: Column(
            children: [Expanded(child: Image.asset("images/intro_bg.jpg"))],
          ),
        ),
      ),
    );
  }
}
