import 'package:grpc/grpc.dart';
import 'package:server/protos/google/protobuf/wrappers.pb.dart';
import 'package:server/protos/google/protobuf/empty.pb.dart';
import 'package:server/protos/verification_code.pbgrpc.dart';

class VerificationCodeService extends VerificationCodeServiceBase {
  @override
  Future<Empty> send(ServiceCall call, StringValue request) {
    // TODO: implement send
    throw UnimplementedError();
  }
}
