import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../auth/login_dialog.dart';
import '../user/user_profile_screen.dart';

class HomeUserButton extends ConsumerWidget {
  const HomeUserButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () => _onPressed(context, ref.read),
      icon: const Icon(Icons.person),
    );
  }

  /// Passed callback.
  void _onPressed(BuildContext context, Reader reader) =>
      canAuthenticated<void>(
        context: context,
        reader: reader,
        onAuthenticated: (User? user) => _onAuthenticated(context, user),
      );

  /// Authenticated callback.
  void _onAuthenticated(BuildContext context, User? user) {
    // If user is authenticated, jump to publish page.
    if (user != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => UserProfileScreen(user.id),
      ));
    }
  }
}
