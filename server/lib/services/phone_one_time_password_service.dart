import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

class PhoneOneTimePasswordService extends PhoneOneTimePasswordServiceBase {
  @override
  Future<Empty> send(ServiceCall call, StringValue request) {
    // TODO: implement send
    throw UnimplementedError();
  }

  @override
  Future<BoolValue> check(
      ServiceCall call, CheckPhoneOneTimePasswordRequest request) {
    // TODO: implement check
    throw UnimplementedError();
  }
}
