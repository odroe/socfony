import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'app_theme.dart';
import 'socfony_service.dart';

/// Scofony app runner.
Future<void> main() async {
  // Ensure Flutter is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Start app before refresh access token.
  await refreshAccessToken();

  // Run socfony app.
  // Root widget is a provider scope.
  runApp(
    ProviderScope(
      child: SocfonyApp(
        themeDataProvider: await createThemeDataProvider(),
        themeModeProvider: await createThemeModeProvider(),
      ),
    ),
  );
}
