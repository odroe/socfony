import 'package:grpc/grpc.dart';
import 'package:server2/src/protobuf/google/protobuf/wrappers.pb.dart';
import 'package:server2/src/protobuf/google/protobuf/empty.pb.dart';
import 'package:server2/src/protobuf/verification_code.pbgrpc.dart';

import 'verification_code.message.dart';

class VerificationCodeService extends VerificationCodeServiceBase {
  @override
  Future<Empty> send(ServiceCall call, StringValue request) async {
    VerificationCodeMessage(request.value).send();

    return Empty();
  }
}