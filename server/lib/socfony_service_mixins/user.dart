import 'package:grpc/grpc.dart';
import 'package:postgres/postgres.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../auth.dart';
import '../database/connection.dart';

User _createUserFromJson(Map<String, dynamic> json) {
  final User user = User()
    ..id = json['id']
    ..phone = json['phone'];

  // User avatar
  if (json['avatar'] != null && (json['avatar'] as String).isNotEmpty) {
    user.avatar = json['avatar'] as String;
  }

  // User name
  if (json['name'] != null && (json['name'] as String).isNotEmpty) {
    user.name = json['name'] as String;
  }

  // User bio
  if (json['bio'] != null && (json['bio'] as String).isNotEmpty) {
    user.bio = json['bio'] as String;
  }

  // User birthday
  if (json['birthday'] != null &&
      (json['birthday'] as int).toString().length != 8) {
    user.birthday = json['birthday'] as int;
  }

  // Parse user gender
  for (final User_Gender gender in User_Gender.values) {
    if (gender.name.toLowerCase() == json['gender'].toString().toLowerCase()) {
      user.gender = gender;
      break;
    }
  }

  return user;
}

mixin UserMethods on SocfonyServiceBase {
  @override
  Future<User> findUser(ServiceCall call, StringValue request) async {
    // Create database connection.
    final PooledDatabaseConnection connection =
        await PooledDatabaseConnection.connect();

    // Find user
    final PostgreSQLResult result = await connection.query(
      'SELECT * FROM users WHERE id = @id LIMIT 1',
      substitutionValues: {'id': request.value},
    );

    // Close database connection.
    await connection.close();

    // If result is empty, throw an error.
    if (result.isEmpty) {
      throw GrpcError.notFound('用户不存在');
    }

    return _createUserFromJson(result.first.toColumnMap());
  }

  @override
  Future<User> updateUserName(ServiceCall call, StringValue request) async {
    // Create database connection.
    final PooledDatabaseConnection connection =
        await PooledDatabaseConnection.connect();

    // Validate authentication.
    final Map<String, dynamic> accessToken =
        await Auth(connection).required(call);

    // Find new username user is existing.
    final PostgreSQLResult result = await connection.query(
      'SELECT * FROM users WHERE name = @name LIMIT 1',
      substitutionValues: {'name': request.value},
    );

    // If result is not empty, and user id is not same as current user id, throw an error.
    if (result.isNotEmpty &&
        accessToken['owner_id'] != result.first.toColumnMap()['id']) {
      // Close database connection.
      await connection.close();
      throw GrpcError.alreadyExists('用户名已存在');
    }

    // Update user name.
    final PostgreSQLResult updateResult = await connection.query(
      'UPDATE users SET name = @name WHERE id = @id RETURNING *',
      substitutionValues: {
        'name': request.value,
        'id': accessToken['owner_id'],
      },
    );

    // Close database connection.
    await connection.close();

    return _createUserFromJson(updateResult.first.toColumnMap());
  }

  @override
  Future<User> updateUserAvatar(ServiceCall call, StringValue request) async {
    // Create database connection.
    final PooledDatabaseConnection connection =
        await PooledDatabaseConnection.connect();

    // Validate authentication.
    final Map<String, dynamic> accessToken =
        await Auth(connection).required(call);

    // Update user avatar.
    final PostgreSQLResult updateResult = await connection.query(
      'UPDATE users SET avatar = @avatar WHERE id = @id RETURNING *',
      substitutionValues: {
        'avatar': request.value,
        'id': accessToken['owner_id'],
      },
    );

    // Close database connection.
    await connection.close();

    return _createUserFromJson(updateResult.first.toColumnMap());
  }
}
