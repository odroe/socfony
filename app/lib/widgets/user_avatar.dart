import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double? size;

  const UserAvatar({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.primary;
    final Color onColor = Theme.of(context).colorScheme.onPrimary;
    final double? radius = size != null ? size! / 2 : null;

    return CircleAvatar(
      backgroundColor: color,
      radius: radius,
      child: Icon(Icons.person, size: radius, color: onColor),
    );
  }
}
