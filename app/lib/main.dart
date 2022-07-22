import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socfonyapis/socfonyapis.dart';

import 'app.dart';
import 'app_theme.dart';
import 'auth/auth_provider.dart';
import 'socfony_service.dart';

/// Scofony app runner.
Future<void> main() async {
  // Ensure Flutter is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Start app before refresh access token.
  final AccessToken? accessToken = await refreshAccessToken();

  // If access token is not null, set authenticated notifier.
  if (accessToken != null) {
    AuthenticatedNotifier().value = accessToken.userId;
  }

  // Initialize application theme.
  await _initializeTheme();

  // Run socfony app.
  // Root widget is a provider scope.
  runApp(const ProviderScope(child: SocfonyApp()));
}

/// Initialize application theme.
Future<void> _initializeTheme() async {
  ThemeColorController().update(await readThemeColor());
  ThemeModeController().update(await readThemeMode());
}
