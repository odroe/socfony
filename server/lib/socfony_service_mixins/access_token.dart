import 'package:betid/betid.dart';
import 'package:grpc/grpc.dart';
import 'package:postgres/postgres.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../auth.dart';
import '../database/connection.dart';

mixin AccessTokenMethods on SocfonyServiceBase {
  @override
  Future<AccessToken> createAccessToken(
      ServiceCall call, CreateAccessTokenRequest request) async {
    // Create database connection.
    final PooledDatabaseConnection connection =
        await PooledDatabaseConnection.connect();

    // Find phone sent code
    final PostgreSQLResult result = await connection.query(
      'SELECT * FROM phone_sent_codes WHERE phone = @phone AND code = @code ORDER BY created_at DESC LIMIT 1',
      substitutionValues: {
        'phone': request.phone,
        'code': request.otp,
      },
    );

    // If result is empty then return error.
    if (result.isEmpty) {
      // Close database connection.
      await connection.close();
      throw GrpcError.notFound('验证码不正确');
      // If code is expired then return error.
    } else if ((result.first.toColumnMap()['expired_at'] as DateTime)
        .isBefore(DateTime.now())) {
      // Close database connection.
      await connection.close();
      throw GrpcError.invalidArgument('验证码已过期');
    }

    // Find or create user by phone number.
    final Map<String, dynamic> user =
        await _findOrCreateUser(connection, request.phone);

    // Create access token by user id.
    final Map<String, dynamic> accessToken =
        await _createAccessToken(connection, user['id']);

    // Delete phone sent code.
    await connection.execute(
      'DELETE FROM phone_sent_codes WHERE phone = @phone AND code = @code',
      substitutionValues: {
        'phone': request.phone,
        'code': request.otp,
      },
    );

    // Close database connection.
    await connection.close();

    // Create and return [AccessToken].
    return AccessToken()
      ..token = accessToken['token']
      ..userId = user['id']
      ..expiredAt = accessToken['expired_at']
      ..refreshExpiredAt = accessToken['refresh_expired_at'];
  }

  @override
  Future<AccessToken> refreshAccessToken(
      ServiceCall call, Empty request) async {
    // Create database connection.
    final PooledDatabaseConnection connection =
        await PooledDatabaseConnection.connect();

    // Find and validate access token in refresh token.
    final Map<String, dynamic> accessToken =
        await Auth(connection).refresh(call);

    // Update current access token.
    // - [expired_at] is set to now + 5 minutes.
    // - [refresh_expired_at] is set to now.
    await connection.execute(
      'UPDATE access_tokens SET expired_at = NOW() + INTERVAL \'5 minutes\', refresh_expired_at = NOW() WHERE token = @token',
      substitutionValues: {'token': accessToken['token']},
    );

    final Map<String, dynamic> result = await connection
        .transaction((PostgreSQLExecutionContext connection) async {
      // Update current access token.
      // - [expired_at] is set to now + 5 minutes.
      // - [refresh_expired_at] is set to now.
      await connection.execute(
        'UPDATE access_tokens SET expired_at = NOW() + INTERVAL \'5 minutes\', refresh_expired_at = NOW() WHERE token = @token',
        substitutionValues: {'token': accessToken['token']},
      );

      // Create token and return it.
      return await _createAccessToken(
          connection as dynamic, accessToken['owner_id']);
    });

    // Close database connection.
    await connection.close();

    // Create and return [AccessToken].
    return AccessToken()
      ..token = result['token']
      ..userId = result['owner_id']
      ..expiredAt = result['expired_at']
      ..refreshExpiredAt = result['refresh_expired_at'];
  }

  @override
  Future<Empty> deleteAccessToken(ServiceCall call, Empty request) async {
    // Create database connection.
    final PooledDatabaseConnection connection =
        await PooledDatabaseConnection.connect();

    // Find nullable access token.
    final Map<String, dynamic>? accessToken =
        await Auth(connection).nullable(call);

    // If access token is not null then delete it.
    if (accessToken != null) {
      await connection.execute(
        'DELETE FROM access_tokens WHERE token = @token',
        substitutionValues: {'token': accessToken['token']},
      );
    }

    // Close database connection.
    await connection.close();

    return Empty();
  }

  Future<Map<String, dynamic>> _createAccessToken(
      PooledDatabaseConnection connection, String userId) async {
    // Create access token.
    final PostgreSQLResult result = await connection.query(
      'INSERT INTO access_tokens (token, owner_id, created_at, expired_at, refresh_expired_at) VALUES (@token, @ownerId, NOW(), @expiredAt, @refreshExpiredAt) RETURNING *',
      substitutionValues: {
        'token': 128.betid,
        'ownerId': userId,
        'expiredAt': DateTime.now().add(Duration(days: 7)),
        'refreshExpiredAt': DateTime.now().add(Duration(days: 15)),
      },
    );

    // Return access token.
    return result.first.toColumnMap();
  }

  Future<Map<String, dynamic>> _findOrCreateUser(
      PooledDatabaseConnection connection, String phone) async {
    final PostgreSQLResult result = await connection.query(
      'SELECT * FROM users WHERE phone = @phone LIMIT 1',
      substitutionValues: {'phone': phone},
    );

    // if result is not empty then return user.
    if (result.isNotEmpty) {
      return result.first.toColumnMap();
    }

    // Create user.
    final PostgreSQLResult result2 = await connection.query(
      'INSERT INTO users (phone, id) VALUES (@phone, @id) RETURNING *',
      substitutionValues: {
        'phone': phone,
        'id': 64.betid,
      },
    );

    return result2.first.toColumnMap();
  }
}
