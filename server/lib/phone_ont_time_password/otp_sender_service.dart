import 'package:betid/betid.dart';
import 'package:easysms/easysms.dart';
import 'package:postgres/postgres.dart';

import '../configures.dart';
import '../database/connection.dart';

class _SendOtpSmsMessage extends Message {
  final String phone;
  final String code;

  _SendOtpSmsMessage(this.phone, this.code);

  @override
  String get content => throw UnimplementedError();

  @override
  List<String> get data => kSendOtpSmsOptions.params.map((element) {
        switch (element) {
          case '{otp}':
            return code;
          case '{minutes}':
            return '5';
        }

        return element;
      }).toList();

  @override
  Future<void> initialize() async {}

  @override
  String get signName => kSendOtpSmsOptions.signName;

  @override
  String get template => kSendOtpSmsOptions.templateId;
}

class PhoneOtpSenderService {
  final PooledDatabaseConnection connection;

  const PhoneOtpSenderService(this.connection);

  /// Send one-time password to phone number.
  Future<void> send(String phone) async {
    // Create a 6 digit code.
    final String code = '1234567890'.betid(6);

    // Create a message.
    final message = _SendOtpSmsMessage(phone, code);

    // Save otp to database.
    await connection.execute(
      'INSERT INTO phone_sent_codes (phone, code, expired_at) VALUES (@phone, @code, @expired_at:timestamptz)',
      substitutionValues: {
        'phone': phone,
        'code': code,
        'expired_at': DateTime.now().add(Duration(minutes: 5)),
      },
    );

    // Send a short message.
    await kTencentCloudSdhortMessageServiceGeteway.send(phone, message);
  }

  /// Validate one-time password.
  Future<bool> validate(String phone, String code) async {
    // Find phone sent code.
    final PostgreSQLResult result = await connection.query(
      'SELECT * FROM phone_sent_codes WHERE phone = @phone AND code = @code LIMIT 1 ORDER BY created_at DESC',
      substitutionValues: {
        'phone': phone,
        'code': code,
      },
    );

    // If row [expired_at] is less than [DateTime.now()], return false.
    for (final PostgreSQLResultRow element in result) {
      final DateTime expiredAt = element.toColumnMap()['expired_at'];
      if (expiredAt.isBefore(DateTime.now())) {
        return false;
      }
    }

    return result.isNotEmpty;
  }

  /// Validate one-time password and return delete call function.
  Future<Future<void> Function()?> validateReturnFn(
      String phone, String code) async {
    // If validate is false, return null.
    if (!await validate(phone, code)) {
      return null;
    }

    // Return delete call function.
    return () async {
      // Delete phone sent code.
      await connection.execute(
        'DELETE FROM phone_sent_codes WHERE phone = @phone AND code = @code',
        substitutionValues: {
          'phone': phone,
          'code': code,
        },
      );

      // Clean up.
      await connection
          .execute('DELETE FROM phone_sent_codes WHERE expired_at < NOW()');
    };
  }
}
