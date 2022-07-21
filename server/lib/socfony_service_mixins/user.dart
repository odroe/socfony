import 'package:grpc/grpc.dart';
import 'package:postgres/postgres.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../auth.dart';
import '../database/connection.dart';
import '../phone_ont_time_password/otp_sender_service.dart';

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
  if (json['bio'] != null && json['bio'].toString().isNotEmpty) {
    user.bio = json['bio'] as String;
  }

  // User birthday
  if (json['birthday'] != null && json['birthday'].toString().length == 8) {
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

/// mask phone in [User].
extension _MaskPhone on User {
  User maskPhone(bool mask) {
    if (mask && hasPhone()) {
      phone = phone.replaceRange(5, 10, '****');

      return this;
    }

    clearPhone();

    return this;
  }
}

mixin UserMethods on SocfonyServiceBase {
  @override
  Future<User> findUser(ServiceCall call, StringValue request) async {
    // Create database connection.
    final PooledDatabaseConnection connection =
        await PooledDatabaseConnection.connect();

    /// Validate nullable access token.
    final Map<String, dynamic>? accessToken =
        await Auth(connection).nullable(call);

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

    return _createUserFromJson(result.first.toColumnMap()).maskPhone(
        accessToken?['owner_id'] == result.first.toColumnMap()['id']);
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

    return _createUserFromJson(updateResult.first.toColumnMap())
        .maskPhone(true);
  }

  @override
  Future<User> updateUserAvatar(ServiceCall call, StringValue request) async {
    // Create database connection.
    final PooledDatabaseConnection connection =
        await PooledDatabaseConnection.connect();

    // Validate authentication.
    final Map<String, dynamic> accessToken =
        await Auth(connection).required(call);

    // TODO: implement validate avatar file in storage.

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

    return _createUserFromJson(updateResult.first.toColumnMap())
        .maskPhone(true);
  }

  @override
  Future<User> updateUser(ServiceCall call, UpdateUserRequest request) async {
    // Create database connection.
    final PooledDatabaseConnection connection =
        await PooledDatabaseConnection.connect();

    // Validate authentication.
    final Map<String, dynamic> accessToken =
        await Auth(connection).required(call);

    // need to update user substitution values
    final Map<String, dynamic> substitutionValues = {};

    // If request has bio, update user bio.
    if (request.hasBio() && request.bio.isNotEmpty) {
      substitutionValues['bio'] = request.bio;
    }

    // If request has birthday, update user birthday.
    if (request.hasBirthday() && request.birthday.toString().length == 8) {
      substitutionValues['birthday'] = request.birthday;
    }

    // If has gender, update user gender.
    if (request.hasGender()) {
      substitutionValues['gender'] = request.gender.name.toLowerCase();
    }

    // If substitution values is empty, return user.
    if (substitutionValues.isEmpty) {
      final PostgreSQLResult result = await connection.query(
        'SELECT * FROM users WHERE id = @id LIMIT 1',
        substitutionValues: {'id': accessToken['owner_id']}
          ..addAll(substitutionValues),
      );

      // Close database connection.
      await connection.close();

      return _createUserFromJson(result.first.toColumnMap()).maskPhone(true);
    }

    // Build update fields SQL statement.
    final String updateFields =
        substitutionValues.keys.map((String key) => '$key = @$key').join(', ');

    // Update user data.
    final PostgreSQLResult updateResult = await connection.query(
      'UPDATE users SET $updateFields WHERE id = @id RETURNING *',
      substitutionValues: {'id': accessToken['owner_id']}
        ..addAll(substitutionValues),
    );

    // Close database connection.
    await connection.close();

    return _createUserFromJson(updateResult.first.toColumnMap())
        .maskPhone(true);
  }

  @override
  Future<User> updateUserPhone(
      ServiceCall call, UpdateUserPhoneRequest request) async {
    // Create database connection.
    final PooledDatabaseConnection connection =
        await PooledDatabaseConnection.connect();

    // Validate authentication.
    final Map<String, dynamic> accessToken =
        await Auth(connection).required(call);

    // Find currenr user.
    final PostgreSQLResult currentUserResult = await connection.query(
      'SELECT * FROM users WHERE id = @id LIMIT 1',
      substitutionValues: {'id': accessToken['owner_id']},
    );

    // If current user phone is not empty and is not same as request phone, return current user.
    if (currentUserResult.first.toColumnMap()['phone'] ==
        request.current.phone) {
      // Close database connection.
      await connection.close();

      return _createUserFromJson(currentUserResult.first.toColumnMap());
    }

    // Find new phone user is existing.
    final PostgreSQLResult newPhoneUserResult = await connection.query(
      'SELECT * FROM users WHERE phone = @phone LIMIT 1',
      substitutionValues: {'phone': request.current.phone},
    );

    // if new phone user is not empty, and phone field is not same as current user phone, throw an error.
    if (newPhoneUserResult.isNotEmpty &&
        newPhoneUserResult.first.toColumnMap()['phone'] !=
            currentUserResult.first.toColumnMap()['phone']) {
      // Close database connection.
      await connection.close();
      throw GrpcError.alreadyExists('手机号已被其他账号绑定');
    }

    // Create one-time password sender service instance.
    final PhoneOtpSenderService otp = PhoneOtpSenderService(connection);

    // Validate current user phone one-time password
    final Future<void> Function()? validatedCurrentOtpFn =
        await otp.validateReturnFn(
            currentUserResult.first.toColumnMap()['phone'], request.otp);

    // If current user phone one-time password is not valid, throw an error.
    if (validatedCurrentOtpFn == null) {
      // Close database connection.
      await connection.close();
      throw GrpcError.invalidArgument('原绑定的手机验证码不正确');
    }

    // Validate new phone one-time password.
    final Future<void> Function()? validatedNewOtpFn =
        await otp.validateReturnFn(request.current.phone, request.current.otp);

    // If new phone one-time password is not valid, throw an error.
    if (validatedNewOtpFn == null) {
      // Close database connection.
      await connection.close();
      throw GrpcError.invalidArgument('新绑定的手机验证码不正确');
    }

    // Update user phone.
    final PostgreSQLResult updateResult = await connection.query(
      'UPDATE users SET phone = @phone WHERE id = @id RETURNING *',
      substitutionValues: {
        'phone': request.current.phone,
        'id': accessToken['owner_id'],
      },
    );

    // Run all fns.
    await validatedCurrentOtpFn();
    await validatedNewOtpFn();

    // Close database connection.
    await connection.close();

    return _createUserFromJson(updateResult.first.toColumnMap())
        .maskPhone(true);
  }
}
