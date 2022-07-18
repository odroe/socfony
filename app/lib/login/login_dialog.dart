import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socfonyapis/socfonyapis.dart';

import 'login_agrements_widget.dart';
import 'login_in_progress_provider.dart';
import 'login_next_button.dart';
import 'login_phone_text_field.dart';

Future<User?> showLoginDialog(BuildContext context) {
  return showDialog<User>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => const _LoginDialog(),
  );
}

class _LoginDialog extends StatelessWidget {
  const _LoginDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Row(
        children: const [
          Expanded(child: Text('🎉加入 Socfony 💞')),
          _CloseButton(),
        ],
      ),
      children: const [
        LoginPhoneTextField(),
        LoginAgrementsWidget(),
        LoginNextButton(),
      ],
    );
  }
}

/// Close dialog button
class _CloseButton extends ConsumerWidget {
  const _CloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Create a button on pressed callback.
    VoidCallback? onPressed;

    // If login in progress status is false, create a button on pressed callback.
    if (!ref.watch(loginInProgressProvider)) {
      onPressed = () => Navigator.pop(context);
    }

    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: onPressed,
    );
  }
}
