import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../auth/login_dialog.dart';

class HomeLeadingPublishButton extends ConsumerWidget {
  const HomeLeadingPublishButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () => _onPressed(context, ref.read),
    );
  }

  /// Pressed callback.
  void _onPressed(BuildContext context, Reader reader) =>
      canAuthenticated<void>(
        context: context,
        reader: reader,
        onAuthenticated: (User? user) =>
            _onAuthenticated(context, user != null),
      );

  /// Authenticated callback.
  void _onAuthenticated(BuildContext context, bool isAuthenticated) {
    // If user is authenticated, jump to publish page.
    if (isAuthenticated) {
      // Navigator.pushNamed(context, '/publish');
      // TODO: jump to publish page.
    }
  }
}
