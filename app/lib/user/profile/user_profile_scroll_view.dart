import 'package:flutter/material.dart';

import 'user_profile_app_bar.dart';

class UserProfileScrollView extends StatelessWidget {
  const UserProfileScrollView(this.userId, {super.key});

  /// Current displayed user.
  final String userId;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        UserProfileAppBar(userId),
      ],
    );
  }
}
