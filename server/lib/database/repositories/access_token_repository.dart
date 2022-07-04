import 'package:betid/betid.dart';
import 'package:postgres/postgres.dart';

import '../connection.dart';
import '../models/access_token_model.dart';
import '_base_repository.dart';

class AccessTokenRepository extends BaseRepository {
  const AccessTokenRepository();

  /// Using [token] to find the access token.
  Future<AccessTokenModel?> find(String token,
      {PooledDatabaseConnection? connection}) async {
    /// Resolved connection.
    final PooledDatabaseConnection conn = await getConnection(connection);

    /// Find a access token in the database.
    final PostgreSQLResult result = await conn.query(
      'SELECT * FROM access_tokens WHERE token = @token ORDER BY created_at DESC LIMIT 1',
      substitutionValues: {'token': token},
    );

    /// Close the connection and clean up expired tokens.
    clear(conn);

    /// Resolve row to model.
    for (final PostgreSQLResultRow element in result) {
      return AccessTokenModel.fromJson(element.toColumnMap());
    }

    /// If no access token found, return null.
    return null;
  }

  /// Clean up expired tokens.
  Future<void> clear([PooledDatabaseConnection? connection]) async {
    /// Resolved connection.
    final PooledDatabaseConnection conn = await getConnection(connection);

    /// Clean up expired tokens.
    await conn.query(
      'DELETE FROM access_tokens WHERE expired_at < NOW() AND refresh_expired_at < NOW()',
    );

    /// Close the connection.
    await conn.close();
  }

  /// Create a new access token.
  Future<AccessTokenModel> create(String ownerId,
      {PooledDatabaseConnection? connection}) async {
    /// Resolved connection.
    final PooledDatabaseConnection conn = await getConnection(connection);

    /// Create a new access token.
    final PostgreSQLResult result = await conn.query(
      'INSERT INTO access_tokens (token, owner_id, created_at, expired_at, refresh_expired_at) VALUES (@token, @ownerId, NOW(), @expiredAt, @refreshExpiredAt) RETURNING *',
      substitutionValues: {
        'token': 128.betid,
        'ownerId': ownerId,
        'expiredAt': DateTime.now().add(Duration(days: 1)),
        'refreshExpiredAt': DateTime.now().add(Duration(days: 7)),
      },
    );

    /// Close the connection and clean up expired tokens.
    clear(conn);

    /// Resolve row to model.
    for (final PostgreSQLResultRow element in result) {
      return AccessTokenModel.fromJson(element.toColumnMap());
    }

    /// If create failed, throw an exception.
    throw Exception('Create access token failed.');
  }

  /// Refresh an access token.
  Future<AccessTokenModel> refresh(String token,
      {PooledDatabaseConnection? connection}) async {
    /// Resolved connection.
    final PooledDatabaseConnection conn = await getConnection(connection);

    /// Update current access token, and get owner id.
    ///
    /// - `expired_at` set to `NOW()`
    /// - `refresh_expired_at` set to `NOW() + 5 minutes`
    final PostgreSQLResult result = await conn.query(
      'UPDATE access_tokens SET expired_at = NOW(), refresh_expired_at = NOW() + INTERVAL \'5 minutes\' WHERE token = @token RETURNING *',
      substitutionValues: {'token': token},
    );

    /// find the owner id.
    final String ownerId =
        AccessTokenModel.fromJson(result.first.toColumnMap()).ownerId;

    /// Create a new access token.
    return create(ownerId, connection: conn);
  }
}
