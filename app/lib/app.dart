import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'framework.dart';
import 'modules/auth/auth_store.dart';
import 'modules/main/main_screen.dart';
import 'theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoreState(),
      child: const _InternalApp(),
    );
  }

  void run() => runApp(this);
}

class _InternalApp extends StatefulWidget {
  const _InternalApp({Key? key}) : super(key: key);

  @override
  State<_InternalApp> createState() => _InternalAppState();

  Widget build(BuildContext context) {
    final ThemeData? themeData = context.store.watch<ThemeData>();

    return MaterialApp(
      title: 'Socfony',
      theme: theme(themeData ?? lightThemeData),
      darkTheme: theme(themeData ?? darkThemeData),
      home: const MainScreen(),
    );
  }
}

class _InternalAppState extends State<_InternalApp> {
  @override
  Widget build(BuildContext context) => widget.build(context);

  @override
  void initState() {
    super.initState();

    initAuthStore();
  }

  Future<void> initAuthStore() async {
    final AuthStore? store = await AuthStore.load();
    if (store is AuthStore) {
      context.store.write<AuthStore>(store);
    }
  }
}
