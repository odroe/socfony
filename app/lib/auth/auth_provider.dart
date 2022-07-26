import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../riverpod/value_state_notifier.dart';
import '../user/user_providers.dart';

/// Authenticated notifier type.
typedef AuthenticatedNotifier = ValueStateNotifier<String?>;

/// Authenticated notifier.
final AuthenticatedNotifier authenticatedNotifier =
    ValueStateNotifier<String?>(null);

/// Current authenticated user ID provider.
final StateNotifierProvider<AuthenticatedNotifier, String?>
    authenticatedProvider =
    StateNotifierProvider<AuthenticatedNotifier, String?>(
        (Ref ref) => authenticatedNotifier);

/// Current authenticated user  provider.
final Provider<User?> authenticatedUserProvider = Provider((Ref ref) {
  /// Read current authenticated user ID.
  final String? userId = ref.watch(authenticatedProvider);

  // If user ID is null, return null.
  if (userId == null) {
    return null;
  }

  return ref.watch(usersProvider.of(userId));
});

/// has user is authenticated provider.
final AutoDisposeProviderFamily<bool, String>
    hasUserEqualAuthenticatedProvider =
    Provider.autoDispose.family<bool, String>((Ref ref, String userId) {
  final String? authenticatedUserId = ref.watch(authenticatedProvider);

  return authenticatedUserId == userId && authenticatedUserId != null;
});

/// Extension for Authenticated provider.
extension AuthenticatedExtension
    on StateNotifierProvider<AuthenticatedNotifier, String?> {
  /// Of ffset authenticated user ID.
  String? of(Reader reader) => reader(authenticatedProvider);

  /// Set authenticated user ID.
  void set(Reader reader, String? value) =>
      reader(authenticatedProvider.notifier).update(value);

  /// Has authenticated
  bool has(Reader reader) => reader(authenticatedProvider) != null;

  /// Find user
  User? user(Reader reader) => reader(authenticatedUserProvider);

  /// Input user same as authenticated user.
  bool same(Reader reader, String userId) =>
      reader(hasUserEqualAuthenticatedProvider(userId));
}

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
