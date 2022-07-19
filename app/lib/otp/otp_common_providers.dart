import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// One-time password verification status provider.
final AutoDisposeStateProvider<bool> otpVerificationStatusProvider =
    StateProvider.autoDispose<bool>((Ref ref) => false);

/// One-time password countdown notifier.
class OneTimePasswordCountdownNotifier extends StateNotifier<int> {
  OneTimePasswordCountdownNotifier(this.tag) : super(0);

  /// tag
  final String tag;

  /// Countdown timer.
  Timer? _timer;

  /// Maximum countdown seconds.
  static const int maxCountdownSeconds = 60;

  /// Timer is running.
  bool get isRunning => _timer?.isActive ?? false;

  /// Start countdown.
  void start() {
    // If countdown is already started, do nothing.
    if (state != 0 || _timer?.isActive == true) return;

    // Start countdown.
    _timer = Timer.periodic(const Duration(seconds: 1), _timerPeriodicHandler);

    // Update countdown.
    state = maxCountdownSeconds;
  }

  /// Stop countdown.
  void stop() {
    // Stop countdown.
    _timer?.cancel();
    _timer = null;

    // If countdown is not started, do nothing.
    if (state == 0) return;

    // Reset countdown.
    state = 0;
  }

  // Reset countdown.
  void reset() => this
    ..stop()
    ..start();

  /// Countdown timer periodic handler.
  void _timerPeriodicHandler(Timer timer) {
    // If mounted is not true, do nothing.
    if (!mounted) return;

    // If timer tick is greater than maximum countdown seconds, stop timer.
    if (timer.tick >= maxCountdownSeconds) {
      timer.cancel();

      // Reset countdown.
      state = 0;
    }

    // Update countdown.
    state = maxCountdownSeconds - timer.tick;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

/// One-time password countdown provider.
final StateNotifierProviderFamily<OneTimePasswordCountdownNotifier, int, String>
    otpCountdownProvider =
    StateNotifierProvider.family<OneTimePasswordCountdownNotifier, int, String>(
  (Ref ref, String phone) => OneTimePasswordCountdownNotifier(phone),
);
