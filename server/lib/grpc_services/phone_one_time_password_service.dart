import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../database/models/phone_sent_code_model.dart';
import '../database/repositories/phone_sent_code_repository.dart';
import '../services/access_token/short_message_service.dart';

class PhoneOneTimePasswordService extends PhoneOneTimePasswordServiceBase {
  @override
  Future<Empty> send(ServiceCall call, StringValue request) async {
    await AccessTokenShortMessageService(request.value).send();

    return Empty.create();
  }

  @override
  Future<BoolValue> check(
      ServiceCall call, CheckPhoneOneTimePasswordRequest request) async {
    /// Get phone sent code repository.
    const PhoneSentCodeRepository repository = PhoneSentCodeRepository();

    /// Find a phone sent code.
    final PhoneSentCodeModel? phoneSentCode =
        await repository.find(request.phone);

    /// Check if phone sent code is expired.
    if (phoneSentCode == null ||
        phoneSentCode.expiredAt.isBefore(DateTime.now())) {
      return BoolValue(value: false);
    }

    return BoolValue(value: true);
  }
}
