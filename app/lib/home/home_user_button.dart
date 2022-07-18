import 'package:flutter/material.dart';

import '../login/login_dialog.dart';

class HomeUserButton extends StatelessWidget {
  const HomeUserButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showLoginDialog(context);
      },
      icon: const Icon(Icons.person),
    );
  }
}
