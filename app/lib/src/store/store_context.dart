import 'package:flutter/widgets.dart' show BuildContext;

import 'store.dart';

extension StoreContext on BuildContext {
  Store get store => Store(this);
}
