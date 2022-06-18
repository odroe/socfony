import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<Key> rootKeyProvider = StateProvider<Key>(
  (Ref ref) => UniqueKey(),
);
