import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Value state notifier.
class ValueStateNotifier<T> extends StateNotifier<T> {
  ValueStateNotifier(T state) : super(state);

  /// Update state.
  void update(T state) => super.state = state;
}
