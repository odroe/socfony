import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../services/access_token/short_message_service.dart';

class PhoneOneTimePasswordService extends PhoneOneTimePasswordServiceBase {
  @override
  Future<Empty> send(ServiceCall call, StringValue request) async {
    await AccessTokenShortMessageService(request.value).send();

    return Empty.create();
  }

  @override
  Future<BoolValue> check(
      ServiceCall call, CheckPhoneOneTimePasswordRequest request) {
    // TODO: implement check
    throw UnimplementedError();
  }
}
