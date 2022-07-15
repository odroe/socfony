import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../database/connection.dart';
import '../phone_ont_time_password/otp_sender_service.dart';

mixin PhoneOneTimePasswordMethods on SocfonyServiceBase {
  @override
  Future<Empty> sendPhoneOneTimePassword(
      ServiceCall call, StringValue request) async {
    // Create database connection.
    final PooledDatabaseConnection connection =
        await PooledDatabaseConnection.connect();

    // Send a one-time password to the phone.
    await PhoneOtpSenderService(connection).send(request.value);

    // Close database connection.
    await connection.close();

    return Empty();
  }

  @override
  Future<BoolValue> checkPhoneOneTimePassword(
      ServiceCall call, CheckPhoneOneTimePasswordRequest request) async {
    // Create database connection.
    final PooledDatabaseConnection connection =
        await PooledDatabaseConnection.connect();

    // Check if the code is valid.
    final bool isValid = await PhoneOtpSenderService(connection)
        .validate(request.phone, request.otp);

    // Close database connection.
    await connection.close();

    return BoolValue()..value = isValid;
  }
}
