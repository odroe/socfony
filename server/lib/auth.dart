import 'package:grpc/grpc.dart';
import 'package:postgres/postgres.dart';

import 'database/connection.dart';

class Auth {
  final PooledDatabaseConnection connection;

  const Auth(this.connection);

  // Find token in client metadata or headers.
  String _findToken(ServiceCall call) {
    // Find token in client metadata.
    for (final String key in (call.clientMetadata?.keys ?? const <String>[])) {
      if (key.toLowerCase() == 'authorization') {
        return call.clientMetadata![key]!;
      }
    }

    // Find token in headers.
    for (final String key in (call.headers?.keys ?? const <String>[])) {
      if (key.toLowerCase() == 'authorization') {
        return call.headers![key]!;
      }
    }

    throw GrpcError.unauthenticated('没有找到登录信息');
  }

  /// Auth is required.
  Future<Map<String, dynamic>> required(ServiceCall call) async {
    final String token = _findToken(call);
    final Map<String, dynamic>? accessToken = await _findTokenOnDatabase(token);

    // If result is empty, throw unauthenticated.
    if (accessToken == null) {
      throw GrpcError.unauthenticated('没有找到登录信息');
    }

    // If access token is not empty, check if token is expired.
    if ((accessToken['expired_at'] as DateTime).isBefore(DateTime.now())) {
      throw GrpcError.unauthenticated('登录信息已过期');
    }

    return accessToken;
  }

  /// Auth is nullable.
  Future<Map<String, dynamic>?> nullable(ServiceCall call) async {
    try {
      return await required(call);
    } on GrpcError {
      return null;
    } catch (e) {
      rethrow;
    }
  }

  /// Auth is refresh.
  Future<Map<String, dynamic>> refresh(ServiceCall call) async {
    final String token = _findToken(call);
    final Map<String, dynamic>? accessToken = await _findTokenOnDatabase(token);

    // If result is empty, throw unauthenticated.
    if (accessToken == null) {
      throw GrpcError.unauthenticated('没有找到登录信息');
    }

    // If access token is not empty, check if token is expired.
    if ((accessToken['refresh_expired_at'] as DateTime)
        .isBefore(DateTime.now())) {
      throw GrpcError.unauthenticated('Token刷新周期已过期');
    }

    return accessToken;
  }

  /// Find token on database.
  Future<Map<String, dynamic>?> _findTokenOnDatabase(String token) async {
    final PostgreSQLResult result = await connection.query(
      'SELECT * FROM access_tokens WHERE token = @token ORDER BY created_at DESC LIMIT 1',
      substitutionValues: {'token': token},
    );

    if (result.isEmpty) {
      return null;
    }

    return result.first.toColumnMap();
  }
}
