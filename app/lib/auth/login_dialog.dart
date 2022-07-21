import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../socfony_service.dart';
import '../user/user_providers.dart';
import 'auth_provider.dart';
import 'login_agrements_widget.dart';
import 'login_in_progress_provider.dart';
import 'login_next_button.dart';
import 'login_phone_text_field.dart';

FutureOr<T> canAuthenticated<T>({
  required BuildContext context,
  required Reader reader,
  required FutureOr<T> Function(User?) onAuthenticated,
}) async {
  // If access token is null, show login dialog.
  if (!authenticatedProvider.has(reader)) {
    return await onAuthenticated(await showDialog<User>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const _LoginDialog(),
    ));
  }

  // If find user in user's provider, return it.
  final User? user = authenticatedProvider.user(reader);
  if (user != null) {
    return onAuthenticated(user);
  }

  // Fetch remote user.
  final User remote = await socfonyService
      .findUser(StringValue()..value = authenticatedProvider.of(reader)!);
  remote.save(reader);

  return onAuthenticated(remote);
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
