import 'package:postgres/postgres.dart';

import '../connection.dart';
import '_base_repository.dart';

class UserRepository extends BaseRepository {
  const UserRepository();

  /// Find a user by ID.
  Future<Map<String, dynamic>> find(
    String id, {
    PooledDatabaseConnection? connection,
  }) async {
    /// Get database connection.
    final PooledDatabaseConnection resolvedConnection =
        await getConnection(connection);

    /// Run query and get result.
    final PostgreSQLResult result = await resolvedConnection.query(
      'SELECT * FROM users WHERE id = @id',
      substitutionValues: {'id': id},
    );

    /// Close connection.
    await resolvedConnection.close();

    /// Find first row.
    for (var element in result) {
      return element.toColumnMap();
    }

    /// If no row found, throw exception.
    throw Exception('User not found.');
  }

  /// Using `phone` find user, if not found, create new user.
  Future<Map<String, dynamic>> findOrCreate(
    String phone, {
    PooledDatabaseConnection? connection,
  }) async {
    /// Get database connection.
    final PooledDatabaseConnection resolvedConnection =
        await getConnection(connection);

    /// Run query and get result.
    final PostgreSQLResult result = await resolvedConnection.query(
      'SELECT * FROM users WHERE phone = @phone',
      substitutionValues: {'phone': phone},
    );

    /// Find first row.
    for (var element in result) {
      /// Close connection.
      await resolvedConnection.close();

      /// Return user.
      return element.toColumnMap();
    }

    /// If no row found, create new user.
    return await createWithPhone(phone, connection: resolvedConnection);
  }

  /// Create new user with `phone`.
  Future<Map<String, dynamic>> createWithPhone(
    String phone, {
    PooledDatabaseConnection? connection,
  }) async {
    /// Get database connection.
    final PooledDatabaseConnection resolvedConnection =
        await getConnection(connection);

    /// Run query and get result.
    final PostgreSQLResult result = await resolvedConnection.query(
      'INSERT INTO users (phone) VALUES (@phone) RETURNING *',
      substitutionValues: {'phone': phone},
    );

    /// Close connection.
    await resolvedConnection.close();

    /// Find first row.
    for (var element in result) {
      return element.toColumnMap();
    }

    /// If no row found, throw exception.
    throw Exception('User not found.');
  }
}