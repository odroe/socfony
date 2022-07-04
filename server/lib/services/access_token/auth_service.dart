import 'package:grpc/grpc.dart';

import '../../database/models/access_token_model.dart';
import '../../database/repositories/access_token_repository.dart';

class AuthService {
  final ServiceCall call;

  const AuthService(this.call);

  String get token => _getAccessToken();

  /// Get acces token in call.
  String _getAccessToken() {
    /// Find token in client metadata.
    for (final String key in (call.clientMetadata?.keys ?? const <String>[])) {
      if (key.toLowerCase() == 'authorization') {
        return call.clientMetadata![key]!;
      }
    }

    /// Find token in headers.
    for (final String key in (call.headers?.keys ?? const <String>[])) {
      if (key.toLowerCase() == 'authorization') {
        return call.headers![key]!;
      }
    }

    throw GrpcError.unauthenticated('Access token required.');
  }

  Future<AccessTokenModel> required() async {
    final AccessTokenModel? accessToken =
        await AccessTokenRepository().find(token);
    if (accessToken == null) {
      throw GrpcError.unauthenticated();
    } else if (accessToken.expiredAt.isBefore(DateTime.now())) {
      throw GrpcError.unauthenticated();
    }

    return accessToken;
  }

  /// nullable
  Future<AccessTokenModel?> nullable() async {
    final AccessTokenModel? accessToken =
        await AccessTokenRepository().find(token);
    if (accessToken == null) {
      return null;
    } else if (accessToken.expiredAt.isBefore(DateTime.now())) {
      return null;
    }

    return accessToken;
  }

  /// refresh
  Future<AccessTokenModel> refresh() async {
    final AccessTokenModel? accessToken =
        await AccessTokenRepository().find(token);
    if (accessToken == null) {
      throw GrpcError.unauthenticated();
    } else if (accessToken.refreshExpiredAt.isBefore(DateTime.now())) {
      throw GrpcError.unauthenticated();
    }

    return accessToken;
  }
}
