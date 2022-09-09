import 'package:grpc/grpc.dart';

import '../prisma/prisma.dart';

class Auth {
  const Auth(this.call);

  /// Current request service call.
  final ServiceCall call;

  /// Get current authorization
  String? get authorization =>
      _findAuthorization(call.clientMetadata) ??
      _findAuthorization(call.headers);

  /// Authorization finder
  String? _findAuthorization(Map<String, String>? matadata) {
    // Find authorization in matadata.
    for (final MapEntry<String, String> child in matadata?.entries ?? []) {
      if (child.key.toLowerCase() == 'authorization') {
        return child.value;
      }
    }

    return null;
  }

  /// Get current access token.
  Future<AccessToken?> get accessToken {
    // If authorization is null, return null.
    if (authorization == null) return Future.value(null);

    return prisma.accessToken.findUnique(
      where: AccessTokenWhereUniqueInput(token: authorization),
    );
  }

  /// Get current authenticated user.
  Future<User?> get user async {
    // Resolve access token.
    final AccessToken? accessToken = await this.accessToken;

    // If access token is null, return null.
    if (accessToken == null) return null;

    return prisma.user.findUnique(
      where: UserWhereUniqueInput(id: accessToken.ownerId),
    );
  }

  /// Validate access token.
  Future<void> validate({bool isRefresh = false}) async {
    // Resolve access token.
    final AccessToken? accessToken = await this.accessToken;

    // If access token is null, throw error.
    if (accessToken == null) throw GrpcError.unauthenticated();

    // Validate expired time.
    _validateDataTime(
        isRefresh ? accessToken.refreshExpiredAt : accessToken.expiredAt);
  }

  /// Validate data time, If now is after [expiredAt], throw [GrpcError].
  void _validateDataTime(DateTime expiredAt) {
    // If now is after expiredAt, throw error.
    if (DateTime.now().isAfter(expiredAt)) {
      throw GrpcError.unauthenticated();
    }
  }
}
