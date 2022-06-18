import 'package:flutter/material.dart';

class Unfocus extends StatelessWidget {
  const Unfocus({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
