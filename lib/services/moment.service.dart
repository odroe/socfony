import 'package:grpc/grpc.dart';
import 'package:server/protobuf/socfony.pbgrpc.dart';

class MomentService extends MomentServiceBase {
  @override
  Future<Moment> create(ServiceCall call, CreateMomentRequest request) {
    print(request.toProto3Json());
    // TODO: implement createMoment
    throw UnimplementedError();
  }

  // @override
  // Future<Empty> delete(ServiceCall call, StringValue request) {
  //   // TODO: implement deleteMoment
  //   throw UnimplementedError();
  // }
}
