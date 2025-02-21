import 'package:flutter/material.dart';

class BodyTitle extends StatelessWidget {
  final String title;
  const BodyTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Text(
        title,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
