import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:socfony/screens/home.dart';

import 'services/auth_service.dart';
import 'theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService.instance),
      ],
      child: const CupertinoApp(
        title: 'Socfony',
        theme: AppTheme.defaultTheme,
        home: HomeScreen(),
      ),
    );
  }

  static void run() => runApp(const App());
}
