import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

class UserService extends UserServiceBase {
  @override
  Future<User> find(ServiceCall call, StringValue request) {
    // TODO: implement find
    throw UnimplementedError();
  }

  @override
  Future<User> update(ServiceCall call, UpdateUserRequest request) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
