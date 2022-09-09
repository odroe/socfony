import 'package:grpc/grpc.dart';

import 'auth.dart';

extension AuthExtension on ServiceCall {
  /// Get current authorization
  Auth get auth => Auth(this);
}
