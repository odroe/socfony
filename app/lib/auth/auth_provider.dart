import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../user/user_providers.dart';

class AuthenticatedNotifier extends ValueNotifier<String?> {
  AuthenticatedNotifier._(super.value);

  /// Cached authenticated notifier.
  static final AuthenticatedNotifier _instance = AuthenticatedNotifier._(null);

  /// Get cached authenticated notifier.
  factory AuthenticatedNotifier() => _instance;
}

/// Current authenticated user ID provider.
final ChangeNotifierProvider<AuthenticatedNotifier> authenticatedProvider =
    ChangeNotifierProvider((Ref ref) => AuthenticatedNotifier());

/// Current authenticated user  provider.
final Provider<User?> authenticatedUserProvider = Provider((Ref ref) {
  /// Read current authenticated user ID.
  final String? userId = ref.watch(authenticatedProvider).value;

  // If user ID is null, return null.
  if (userId == null) {
    return null;
  }

  return ref.watch(usersProvider.of(userId));
});

/// Extension for Authenticated provider.
extension AuthenticatedExtension
    on ChangeNotifierProvider<AuthenticatedNotifier> {
  /// Of ffset authenticated user ID.
  String? of(Reader reader) => reader(authenticatedProvider).value;

  /// Set authenticated user ID.
  void set(Reader reader, String? value) =>
      reader(authenticatedProvider.notifier).value = value;

  /// Has authenticated
  bool has(Reader reader) => reader(authenticatedProvider).value != null;

  /// Find user
  User? user(Reader reader) => reader(authenticatedUserProvider);
}

/// has user is authenticated provider.
final AutoDisposeProviderFamily<bool, String>
    hasUserEqualAuthenticatedProvider =
    Provider.autoDispose.family<bool, String>((Ref ref, String userId) {
  final String? authenticatedUserId =
      ref.watch(authenticatedProvider.select((notifier) => notifier.value));

  return authenticatedUserId == userId && authenticatedUserId != null;
});

/// Read access token.
Future<AccessToken?> readAccessToken() async {
  // Create shared preferences instance.
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  try {
    // Read token from shared preferences.
    final String? accessToken = prefs.getString(r'socfony_access_token');

    // If token is not null, return it.
    if (accessToken != null) {
      return AccessToken.fromJson(accessToken);
    }
  } catch (e) {
    // If error, destroy access token.
    await prefs.remove(r'socfony_access_token');
  }

  // Otherwise, return null.
  return null;
}

/// Write access token.
Future<void> writeAccessToken(AccessToken accessToken) async {
  // Create shared preferences instance.
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Write token to shared preferences.
  await prefs.setString(r'socfony_access_token', accessToken.writeToJson());
}

/// Destroy access token.
Future<void> destroyAccessToken() async {
  // Create shared preferences instance.
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Destroy token in shared preferences.
  await prefs.remove(r'socfony_access_token');
}
