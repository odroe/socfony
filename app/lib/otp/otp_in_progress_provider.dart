import 'package:flutter_riverpod/flutter_riverpod.dart';

/// One-time password verification in progress status provider.
final AutoDisposeStateProvider<bool> otpInProgressProvider =
    StateProvider.autoDispose<bool>(
  (ref) => false,
);
