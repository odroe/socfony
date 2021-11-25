import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../configuration.dart';
import '../grpc.dart';

class AuthService with ChangeNotifier {
  // Cache key and metadata key.
  static const String _key = "Authorization";

  AccessTokenEntity? _entity;
  static AuthService? _singleton;

  /// AuthService entity.
  AccessTokenEntity? get entity => _entity;

  AuthService._internal() {
    onInitialize();
  }

  factory AuthService() => _singleton ??= AuthService._internal();

  /// Initialize AuthService.
  Future<void> onInitialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessTokenString = prefs.getString(_key);

    if (accessTokenString != null && prefs.containsKey(_key)) {
      _entity = AccessTokenEntity.fromJson(accessTokenString);
      refresh();
    }
  }

  /// Login with phone and code.
  ///
  /// [phone] Phone number.
  /// [code] Code.
  Future<void> login(String phone, String code) async {
    final CreateAccessTokenRequest request = CreateAccessTokenRequest()
      ..phone = phone
      ..code = code;
    _entity = await AccessTokenMutationClient(channel).create(request);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_key, _entity!.writeToJson());

    notifyListeners();
  }

  /// Logout.
  Future<void> logout() async {
    final Empty request = Empty();
    await AccessTokenMutationClient(channel)
        .delete(request, options: callOptions);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_key);

    notifyListeners();
  }

  /// Refresh token.
  Future<void> refresh() async {
    final Empty request = Empty();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      _entity = await AccessTokenMutationClient(channel)
          .refresh(request, options: callOptions);
      prefs.setString(_key, _entity!.writeToJson());
    } catch (e) {
      prefs.remove(_key);
      _entity = null;
    }

    notifyListeners();
  }

  /// Check if user is logged in.
  bool get isAuthenticated =>
      _entity != null &&
      _entity!.expiredAt.toDateTime().isAfter(DateTime.now());

  /// Get auth call options.
  CallOptions get callOptions =>
      CallOptions(metadata: <String, String>{_key: _entity?.token ?? ""});
}
