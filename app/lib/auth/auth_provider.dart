import 'package:shared_preferences/shared_preferences.dart';
import 'package:socfonyapis/socfonyapis.dart';

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
