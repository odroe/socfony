import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'framework.dart';
import 'screens/home_screen.dart';
import 'services/auth_service.dart';
import 'theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: _createStoreState),
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const _InternalApp(),
    );
  }

  void run() => runApp(this);

  StoreState _createStoreState(BuildContext context) {
    return StoreState()
      ..write(PageController(
        initialPage: 0,
        keepPage: true,
      ));
  }
}

class _InternalApp extends StatelessWidget {
  const _InternalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData? themeData = context.store.watch<ThemeData>();

    return MaterialApp(
      title: 'Socfony',
      theme: theme(themeData ?? lightThemeData),
      darkTheme: theme(themeData ?? darkThemeData),
      home: const HomeScreen(),
    );
  }
}
