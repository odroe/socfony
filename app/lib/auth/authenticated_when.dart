import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../user/user_when.dart';
import 'auth_provider.dart';

class AuthenticatedWhen extends ConsumerWidget {
  const AuthenticatedWhen({super.key, required this.builder});

  /// child widget build
  final AsyncWidgetBuilder<User> builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch authenticated user ID.
    final String? userId = authenticatedProvider.of(ref.watch);

    // If user id found, return [UserWhen]
    if (userId != null) {
      return UserWhen(
        id: userId,
        builder: builder,
      );
    }

    // If user id not found, return error shapshot.
    return builder(
      context,
      const AsyncSnapshot.withError(
        ConnectionState.done,
        'AuthenticatedWhen: userId is null',
      ),
    );
  }
}
