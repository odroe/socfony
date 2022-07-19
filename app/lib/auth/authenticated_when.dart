import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../socfony_service.dart';
import '../user/user_providers.dart';
import 'auth_provider.dart';

class AuthenticatedWhen extends ConsumerStatefulWidget {
  const AuthenticatedWhen({
    super.key,
    required this.authenticated,
    required this.notAuthenticated,
    this.refresh = false,
  });

  /// The widget to display when the user is authenticated.
  final WidgetBuilder authenticated;

  /// The widget to display when the user is not authenticated.
  final WidgetBuilder notAuthenticated;

  /// Is refresh.
  final bool refresh;

  @override
  ConsumerState<AuthenticatedWhen> createState() => _AuthenticatedWhenState();
}

/// Create authenticated user future provider.
FutureProvider<User?> _createAuthenticatedUserFutureProvider(bool refresh) {
  return FutureProvider((Ref ref) async {
    // Read access token.
    final AccessToken? accessToken = await readAccessToken();

    // If access token is null, return null.
    if (accessToken == null) {
      return null;
    }

    // If find user in user's provider, return it.
    final User? findInProvider =
        UserExtension.find(ref.read, accessToken.userId);
    if (findInProvider != null && !refresh) {
      return findInProvider;
    }

    // Fetch remite user, And then save it.
    final User remote = await socfonyService
        .findUser(StringValue()..value = accessToken.userId);

    return remote..save(ref.read);
  });
}

class _AuthenticatedWhenState extends ConsumerState<AuthenticatedWhen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Create authenticated user future provider.
    final FutureProvider<User?> provider =
        _createAuthenticatedUserFutureProvider(widget.refresh);

    // Reader for widget refresh.
    final Reader reader = widget.refresh ? ref.refresh : ref.watch;

    return reader(provider).when(
      data: (User? user) => user != null
          ? widget.authenticated(context)
          : widget.notAuthenticated(context),
      error: (_, __) => widget.notAuthenticated(context),
      loading: () => widget.notAuthenticated(context),
    );
  }
}
