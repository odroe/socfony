import 'package:app/grpc.dart';
import 'package:app/framework.dart';
import 'package:app/modules/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStore {
  static const String key = 'Authorization';

  const AuthStore(this.accessToken);

  final AccessTokenEntity accessToken;

  String get token => accessToken.token;

  String get userId => accessToken.userId;

  DateTime get expiredAt => accessToken.expiredAt.toDateTime();

  DateTime get refreshExpiredAt => accessToken.refreshExpiredAt.toDateTime();

  bool get isExpired => expiredAt.isBefore(DateTime.now());

  bool get isRefreshExpired => refreshExpiredAt.isBefore(DateTime.now());

  CallOptions get callOptions {
    return CallOptions(metadata: {key: token});
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, accessToken.writeToJson());
  }

  static Future<AuthStore?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(key);
    if (json == null) {
      return null;
    }

    final auth = AuthStore(AccessTokenEntity.fromJson(json));
    if (auth.isRefreshExpired) {
      return null;
    }

    return auth;
  }

  static Future<T?> can<T>(
    BuildContext context, {
    T? Function(AuthStore)? next,
    T? Function()? or,
    bool show = true,
  }) async {
    final AuthStore? store = context.store.read<AuthStore>();
    if (show && (store == null || store.isExpired)) {
      final AuthStore? response = await AuthScreen(context).show();
      return _maybeCan(response, next: next, or: or);
    }

    return _maybeCan(store, next: next, or: or);
  }

  @protected
  static T? _maybeCan<T>(
    AuthStore? store, {
    T? Function(AuthStore)? next,
    T? Function()? or,
  }) {
    if (store != null && !store.isExpired) {
      return next?.call(store);
    }

    return or?.call();
  }
}
