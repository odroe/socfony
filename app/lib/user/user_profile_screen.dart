import 'package:flutter/material.dart';
import 'package:socfonyapis/socfonyapis.dart';

import 'profile/user_profile_scroll_view.dart';
import 'user_when.dart';

/// User profile screen.
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen(this.id, {super.key});

  /// profile of user id.
  final String id;

  @override
  Widget build(BuildContext context) {
    return UserWhen(
      id: id,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasError &&
            snapshot.connectionState == ConnectionState.done) {
          return _errorBuilder(context, snapshot.error);
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return _dataBuilder(context, snapshot.data!);
        }

        return _loadingBuilder(context);
      },
    );
  }

  /// Error builder.
  Widget _errorBuilder(BuildContext context, Object? error) {
    return Scaffold(
      body: Center(
        child: Text(
          error?.toString() ?? '发生了一点小错误',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back),
      ),
    );
  }

  /// Loading builder.
  Widget _loadingBuilder(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// Data builder.
  Widget _dataBuilder(BuildContext context, User user) {
    return Scaffold(body: UserProfileScrollView(user.id));
  }
}
