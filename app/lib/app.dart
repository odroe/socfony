import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'framework.dart';
import 'grpc.dart';
import 'modules/auth/auth_store.dart';
import 'modules/main/main_screen.dart';
import 'theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: _createStoreState,
      child: const _InternalApp()
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

  Future<void> initAuthStore() async  {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString(AuthStore.key);

    if (token == null || token.isEmpty) {
      return;
    }

    final AccessTokenEntity entity = AccessTokenEntity.fromJson(token);
    final AuthStore store = AuthStore(entity);

    this.store.write<AuthStore>(store);
  }
}
