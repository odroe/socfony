import 'package:app/grpc.dart';

class AuthStore {
  static const String key = 'Authorization';

  const AuthStore(this.accessToken);

  final AccessTokenEntity accessToken;

  String get token => accessToken.token;

  String get userId => accessToken.userId;

  DateTime get expiredAt => accessToken.expiredAt.toDateTime();

  DateTime get refreshExpiredAt => accessToken.refreshExpiredAt.toDateTime();

  bool get isExpired => expiredAt.isBefore(DateTime.now());

  bool get isRefreshExpired => refreshExpiredAt.isBefore(DateTime.now());

  CallOptions get callOptions {
    return CallOptions(
      metadata: { key: token }
    );
  }
}