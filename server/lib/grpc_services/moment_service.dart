import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

class MomentService extends MomentServiceBase {
  @override
  Future<Moment> create(ServiceCall call, CreateMomentRequest request) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Empty> delete(ServiceCall call, StringValue request) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<BoolValue> hasLiked(ServiceCall call, StringValue request) {
    // TODO: implement hasLiked
    throw UnimplementedError();
  }

  @override
  Future<BoolValue> toggleLike(ServiceCall call, StringValue request) {
    // TODO: implement toggleLike
    throw UnimplementedError();
  }
}
