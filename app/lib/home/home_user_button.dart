import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../auth/login_dialog.dart';

class HomeUserButton extends ConsumerWidget {
  const HomeUserButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () => canAuthenticated(
        context: context,
        reader: ref.read,
        onAuthenticated: (User? user) {
          // TODO: show user profile.
        },
      ),
      icon: const Icon(Icons.person),
    );
  }
}
