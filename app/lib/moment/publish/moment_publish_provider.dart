import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Publishinng state provider.
final AutoDisposeStateProvider<bool> publishingProvider =
    StateProvider.autoDispose<bool>(
  (ref) => false,
);
