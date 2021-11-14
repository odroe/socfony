import 'package:flutter/cupertino.dart';

import '../theme.dart';

class AppService with ChangeNotifier {
  final String title = 'Socfony';

  CupertinoThemeData _theme = AppTheme.defaultTheme;
  CupertinoThemeData get theme => _theme;
  set theme(CupertinoThemeData theme) {
    _theme = theme;
    notifyListeners();
  }
}
