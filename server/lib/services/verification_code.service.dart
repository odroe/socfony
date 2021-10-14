import 'package:grpc/grpc.dart';
import 'package:socfony_protobuf/protobuf.dart';

class VerificationCodeService extends VerificationCodeServiceBase {
  @override
  Future<VerificationCodeResponse> send(ServiceCall call, SendVerificationCodeRequest request) async {
    return VerificationCodeResponse.create()
      ..success = true;
  }
}