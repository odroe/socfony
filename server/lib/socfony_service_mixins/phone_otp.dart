import 'package:grpc/grpc.dart';
import 'package:postgres/postgres.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../auth.dart';
import '../database/connection.dart';
import '../phone_ont_time_password/otp_sender_service.dart';

mixin PhoneOneTimePasswordMethods on SocfonyServiceBase {
  @override
  Future<Empty> sendPhoneOneTimePassword(
      ServiceCall call, StringValue request) async {
    // Read phone number.
    final String phone = request.value;

    // Check phone number is China phone number.
    if (!RegExp(r'^1\d{10}$').hasMatch(phone) || phone.length != 11) {
      throw GrpcError.invalidArgument('请输入正确的手机号码');
    }

    // Create database connection.
    final PooledDatabaseConnection connection =
        await PooledDatabaseConnection.connect();

    // Send a one-time password to the phone.
    await PhoneOtpSenderService(connection).send('+86$phone');

    // Close database connection.
    await connection.close();

    return Empty();
  }

  @override
  Future<BoolValue> checkPhoneOneTimePassword(
      ServiceCall call, CheckPhoneOneTimePasswordRequest request) async {
    // Read phone number.
    final String phone = request.phone;

    // Check phone number is China phone number.
    if (!RegExp(r'^1\d{10}$').hasMatch(phone) || phone.length != 11) {
      throw GrpcError.invalidArgument('请输入正确的手机号码');
    }

    // Create database connection.
    final PooledDatabaseConnection connection =
        await PooledDatabaseConnection.connect();

    // Check if the code is valid.
    final bool isValid = await PhoneOtpSenderService(connection)
        .validate('+86$phone', request.otp);

    // Close database connection.
    await connection.close();

    return BoolValue()..value = isValid;
  }

  /// Send a one-time password for current authenticated user.
  @override
  Future<Empty> sendPhoneOneTimePassword2auth(
      ServiceCall call, Empty request) async {
    // Create database connection.
    final PooledDatabaseConnection connection =
        await PooledDatabaseConnection.connect();

    // Get current access token.
    final Map<String, dynamic> accessToken =
        await Auth(connection).required(call);

    // Get current user data.
    final PostgreSQLResult result = await connection.query(
      'SELECT phone FROM users WHERE id = @id LIMIT 1',
      substitutionValues: {'id': accessToken['owner_id']},
    );

    // Find user phone in item.
    for (final PostgreSQLResultRow element in result) {
      final String? phone = element.toColumnMap()['phone'];

      // If phone is null or is empty, throw error.
      if (phone == null || phone.isEmpty) {
        throw GrpcError.invalidArgument('请先绑定手机号码');
      }

      // Send a one-time password to the phone.
      await PhoneOtpSenderService(connection).send(phone);

      // Close database connection.
      await connection.close();
    }

    throw GrpcError.unknown('未知错误');
  }

  /// Check if the code is valid for current authenticated user.
  @override
  Future<BoolValue> checkPhoneOneTimePassword2auth(
      ServiceCall call, StringValue request) async {
    // Create database connection.
    final PooledDatabaseConnection connection =
        await PooledDatabaseConnection.connect();

    // Get current access token.
    final Map<String, dynamic> accessToken =
        await Auth(connection).required(call);

    // Get current user data.
    final PostgreSQLResult result = await connection.query(
      'SELECT phone FROM users WHERE id = @id LIMIT 1',
      substitutionValues: {'id': accessToken['owner_id']},
    );

    // Find user phone in item.
    for (final PostgreSQLResultRow element in result) {
      final String? phone = element.toColumnMap()['phone'];

      // If phone is null or is empty, throw error.
      if (phone == null || phone.isEmpty) {
        return BoolValue()..value = false;
      }

      // Check if the code is valid.
      final bool isValid = await PhoneOtpSenderService(connection)
          .validate(phone, request.value);

      // Close database connection.
      await connection.close();

      return BoolValue()..value = isValid;
    }

    return BoolValue()..value = false;
  }
}
