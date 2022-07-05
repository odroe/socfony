import 'package:betid/betid.dart';
import 'package:postgres/postgres.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../connection.dart';
import '../models/user_model.dart';
import '_base_repository.dart';

class UserRepository extends BaseRepository {
  const UserRepository();

  /// Find a user by ID.
  Future<UserModel> find(
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
      return UserModel.fromJson(element.toColumnMap());
    }

    /// If no row found, throw exception.
    throw Exception('User not found.');
  }

  /// Using `phone` find user, if not found, create new user.
  Future<UserModel> findOrCreate(
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
      return UserModel.fromJson(element.toColumnMap());
    }

    /// If no row found, create new user.
    return await createWithPhone(phone, connection: resolvedConnection);
  }

  /// Create new user with `phone`.
  Future<UserModel> createWithPhone(
    String phone, {
    PooledDatabaseConnection? connection,
  }) async {
    /// Get database connection.
    final PooledDatabaseConnection resolvedConnection =
        await getConnection(connection);

    /// Run query and get result.
    final PostgreSQLResult result = await resolvedConnection.query(
      'INSERT INTO users (phone, id) VALUES (@phone, @id) RETURNING *',
      substitutionValues: {
        'phone': phone,
        'id': 64.betid,
      },
    );

    /// Close connection.
    await resolvedConnection.close();

    /// Find first row.
    for (var element in result) {
      return UserModel.fromJson(element.toColumnMap());
    }

    /// If no row found, throw exception.
    throw Exception('User not found.');
  }

  /// Update user.
  Future<UserModel> update(
    String id, {
    PooledDatabaseConnection? connection,
    String? avatar,
    String? bio,
    int? birthday,
    User_Gender? gender,
  }) async {
    /// Resolve Database connection.
    final PooledDatabaseConnection conn = await getConnection(connection);

    final Map<String, dynamic> substitutionValues = {'id': id};
    if (avatar != null && avatar.isNotEmpty) {
      substitutionValues['avatar'] = avatar;
    }
    if (bio != null && bio.isNotEmpty) {
      substitutionValues['bio'] = bio;
    }
    if (birthday != null && birthday.toString().length == 8) {
      substitutionValues['birthday'] = birthday;
    }
    if (gender != null) {
      substitutionValues['gender'] = gender.name;
    }

    /// Using substitetion values build update sql.
    final StringBuffer sql = StringBuffer('UPDATE users SET');
    final List<String> params = <String>[];
    for (String key in substitutionValues.keys) {
      params.add('$key = @$key');
    }

    /// Append params to sql.
    sql.write(' ${params.join(', ')} WHERE id = @id RETURNING *');

    /// Run query and get result.
    final PostgreSQLResult result = await conn.query(
      sql.toString(),
      substitutionValues: substitutionValues,
    );

    /// Close connection.
    await conn.close();

    return UserModel.fromJson(result.first.toColumnMap());
  }

  /// Find user by phone.
  Future<UserModel?> findByPhone(String phone,
      {PooledDatabaseConnection? connection}) async {
    /// Get database connection.
    final PooledDatabaseConnection resolvedConnection =
        await getConnection(connection);

    /// Run query and get result.
    final PostgreSQLResult result = await resolvedConnection.query(
      'SELECT * FROM users WHERE phone = @phone',
      substitutionValues: {'phone': phone},
    );

    /// Close connection.
    await resolvedConnection.close();

    /// Find first row.
    for (var element in result) {
      return UserModel.fromJson(element.toColumnMap());
    }

    return null;
  }

  /// Find user by name.
  Future<UserModel?> findByName(String name,
      {PooledDatabaseConnection? connection}) async {
    /// Get database connection.
    final PooledDatabaseConnection resolvedConnection =
        await getConnection(connection);

    /// Run query and get result.
    final PostgreSQLResult result = await resolvedConnection.query(
      'SELECT * FROM users WHERE name = @name',
      substitutionValues: {'name': name},
    );

    /// Close connection.
    await resolvedConnection.close();

    /// Find first row.
    for (var element in result) {
      return UserModel.fromJson(element.toColumnMap());
    }

    return null;
  }

  /// Update user's name.
  Future<UserModel> updateName(String id, String name,
      {PooledDatabaseConnection? connection}) async {
    /// Get database connection.
    final PooledDatabaseConnection resolvedConnection =
        await getConnection(connection);

    /// Run query and get result.
    final PostgreSQLResult result = await resolvedConnection.query(
      'UPDATE users SET name = @name WHERE id = @id RETURNING *',
      substitutionValues: {
        'id': id,
        'name': name,
      },
    );

    /// Close connection.
    await resolvedConnection.close();

    /// Return first row formated as [UserModel].
    return UserModel.fromJson(result.first.toColumnMap());
  }

  /// Update user's phone.
  Future<UserModel> updatePhone(String id, String phone,
      {PooledDatabaseConnection? connection}) async {
    /// Get database connection.
    final PooledDatabaseConnection resolvedConnection =
        await getConnection(connection);

    /// Run query and get result.
    final PostgreSQLResult result = await resolvedConnection.query(
      'UPDATE users SET phone = @phone WHERE id = @id RETURNING *',
      substitutionValues: {
        'id': id,
        'phone': phone,
      },
    );

    /// Close connection.
    await resolvedConnection.close();

    /// Return first row formated as [UserModel].
    return UserModel.fromJson(result.first.toColumnMap());
  }
}
