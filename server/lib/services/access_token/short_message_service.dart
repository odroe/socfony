import 'package:betid/betid.dart';
import 'package:easysms/easysms.dart';

import '../../configures.dart';
import '../../database/repositories/phone_sent_code_repository.dart';

String _generateOtp() {
  return '1234567890'.betid(6);
}

class AccessTokenShortMessageService extends Message {
  AccessTokenShortMessageService(this.phone);

  /// Formated e.164 phone number.
  final String phone;

  /// One-time password.
  late String otp;

  /// Unimplemented, Tencent Cloud SMS does not support this feature.
  @override
  String get content => throw UnimplementedError();

  @override
  Future<void> initialize() async {
    // Nothing to do.
  }

  @override
  List<String> get data =>
      kAccessTokenShortMessageServiceOptions.params.map((element) {
        switch (element) {
          case '{otp}':
            return otp;
          case '{minutes}':
            return '5';
        }

        return element;
      }).toList();

  @override
  String get signName => kAccessTokenShortMessageServiceOptions.signName;

  @override
  String get template => kAccessTokenShortMessageServiceOptions.templateId;

  /// Send a short message.
  Future<void> send() async {
    /// Set otp.
    otp = _generateOtp();

    /// Save otp to database.
    await PhoneSentCodeRepository().create(
      phone: phone,
      code: otp,
      expiredAt: DateTime.now().add(Duration(minutes: 5)),
    );

    /// Send a short message.
    await kTencentCloudSdhortMessageServiceGeteway.send(phone, this);
  }
}
