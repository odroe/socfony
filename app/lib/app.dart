import 'package:flutter/cupertino.dart';
import 'package:socfony/screens/home.dart';

import 'theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Socfony',
      theme: AppTheme.defaultTheme,
      home: HomeScreen(),
    );
  }

  static void run() => runApp(const App());
}
