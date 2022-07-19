import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Login in progress provider.
/// This provider is used to control the login in progress status.
///
/// The login in progress status is used to control the login next button
/// and close the login dialog.
final AutoDisposeStateProvider<bool> loginInProgressProvider =
    StateProvider.autoDispose<bool>((Ref ref) => false);
