import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';
import 'services/app_service.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: context.read<AppService>().title,
      theme: context.watch<AppService>().theme,
      home: const HomeScreen(),
    );
  }
}
