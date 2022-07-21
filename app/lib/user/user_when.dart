import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socfonyapis/socfonyapis.dart';

import 'user_providers.dart';

class UserWhen extends ConsumerWidget {
  const UserWhen({
    super.key,
    required this.id,
    required this.builder,
  });

  /// User id
  final String id;

  /// Child widget builder
  final AsyncWidgetBuilder<User> builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read user from provider.
    final User? user = UserExtension.find(ref.read, id);

    // If user is found, return child widget.
    if (user != null) {
      return builder(
        context,
        AsyncSnapshot<User>.withData(ConnectionState.done, user),
      );
    }

    // Read user from remote.
    return UserExtension.remote(ref.watch, id).when<Widget>(
      data: (User user) => builder(
        context,
        AsyncSnapshot<User>.withData(ConnectionState.done, user),
      ),
      error: (Object error, StackTrace? stack) => builder(
        context,
        AsyncSnapshot<User>.withError(
            ConnectionState.done, error, stack ?? StackTrace.empty),
      ),
      loading: () => builder(
        context,
        const AsyncSnapshot<User>.waiting(),
      ),
    );
  }
}
