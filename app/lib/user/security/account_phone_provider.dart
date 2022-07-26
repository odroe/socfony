import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/auth_provider.dart';

/// Cuttent authticated user phone provider.
final accountPhoneProvider = Provider.autoDispose<String?>((Ref ref) {
  /// Watch authenticated user phone.
  final String? phone =
      ref.watch(authenticatedUserProvider.select((value) => value?.phone));

  // If phone is empty, return null.
  if (phone == null || phone.isEmpty) {
    return null;
  }

  // Otherwise, return phone.
  return phone;
});
