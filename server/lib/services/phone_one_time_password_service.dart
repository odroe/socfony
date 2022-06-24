import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

class PhoneOneTimePasswordService extends PhoneOneTimePasswordServiceBase {
  @override
  Future<Empty> send(ServiceCall call, StringValue request) {
    // TODO: implement send
    throw UnimplementedError();
  }

  @override
  Future<BoolValue> verify(ServiceCall call, StringValue request) {
    // TODO: implement verify
    throw UnimplementedError();
  }
}
