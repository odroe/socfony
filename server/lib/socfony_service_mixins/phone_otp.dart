import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

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
}
