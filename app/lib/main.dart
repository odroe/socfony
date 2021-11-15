import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:socfony/services/state_service.dart';

import 'app.dart';
import 'services/app_service.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AuthService.initialize();

  return runApp(const _ProviderWrapper());
}

class _ProviderWrapper extends StatelessWidget {
  const _ProviderWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthService.instance),
        ChangeNotifierProvider(create: (_) => CupertinoTabController()),
        ChangeNotifierProvider(create: (_) => StateService()),
        ChangeNotifierProvider(create: (_) => AppService()),
      ],
      child: const App(),
    );
  }
}
