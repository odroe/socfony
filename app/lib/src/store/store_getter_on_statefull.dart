import 'package:flutter/widgets.dart';

import 'store_context.dart';
import 'store.dart';

extension StoreGetterOnStatefull on State {
  Store get store => context.store;
}
