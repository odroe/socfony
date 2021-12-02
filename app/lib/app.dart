import 'package:app/grpc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'configuration.dart';
import 'framework.dart';
import 'modules/auth/auth_store.dart';
import 'modules/main/main_screen.dart';
import 'theme.dart';

class App extends StatelessWidget {
  App._internal({Key? key}) : super(key: key) {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      onInitAuthStore();
      onInitTheme();
    });
  }

  @protected
  StoreState get store => StoreState();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoreState(),
      child: const _InternalApp(),
    );
  }

  @protected
  void onInitAuthStore() async {
    final AuthStore? auth = await AuthStore.load();
    if (auth != null) {
      store.write<AuthStore>(auth);
      refreshAccessToken(auth);
    }
  }

  @protected
  void onInitTheme() {
    store.write<ThemeMode>(ThemeMode.system);
  }

  @protected
  void refreshAccessToken(AuthStore auth) async {
    try {
      final token = await AccessTokenMutationClient(channel).refresh(
        Empty(),
        options: auth.callOptions,
      );
      final newAuth = AuthStore(token);

      store.write<AuthStore>(AuthStore(token));
      newAuth.save();
    } catch (e) {
      store.delete<AuthStore>();
    }
  }

  static void run() => runApp(App._internal());
}

class _InternalApp extends StatelessWidget {
  const _InternalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeMode? mode = context.store.watch<ThemeMode>();
    final Color? color = context.store.watch<Color>();
    final theme = AppTheme(color);

    return MaterialApp(
      title: 'Socfony',
      theme: theme.light,
      darkTheme: theme.dark,
      themeMode: mode,
      home: const MainScreen(),
    );
  }
}
