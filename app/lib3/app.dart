import 'package:flutter/cupertino.dart';
import 'package:get/route_manager.dart';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import '../lib/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetCupertinoApp(
      title: "Socfony",
      theme: AppTheme.theme,
      getPages: AppPages.pages,
      initialRoute: AppRoutes.home,
    );
  }

  void run() => runApp(this);
}
