import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';
import 'services/app_service.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context
        .select<AppService, CupertinoThemeData>((service) => service.theme);

    return CupertinoApp(
      title: context.read<AppService>().title,
      theme: theme,
      home: const HomeScreen(),
    );
  }
}
