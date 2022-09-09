import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart' as socfonyapis;

import '../prisma/prisma.dart';
import '../bridges/user_bridge.dart';

class UserService extends socfonyapis.UserServiceBase {
  @override
  Future<socfonyapis.User> find(
      ServiceCall call, socfonyapis.FindUserRequest request) {
    late final UserWhereUniqueInput where;
    switch (request.whichKind()) {
      case socfonyapis.FindUserRequest_Kind.id:
        where = UserWhereUniqueInput(id: request.id);
        break;
      case socfonyapis.FindUserRequest_Kind.phone:
        where = UserWhereUniqueInput(phone: request.phone);
        break;
      case socfonyapis.FindUserRequest_Kind.name:
        where = UserWhereUniqueInput(name: request.name);
        break;
      case socfonyapis.FindUserRequest_Kind.notSet:
      default:
        throw GrpcError.invalidArgument('Invalid request kind');
    }

    return prisma.user
        .findUnique(where: where)
        .then((value) => value?.toGrpcMessage())
        .then((value) => value ?? (throw GrpcError.notFound()));
  }

  @override
  Future<socfonyapis.User> update(
      ServiceCall call, socfonyapis.UpdateUserOtherInfoRequest request) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<socfonyapis.User> updateAvatar(
      ServiceCall call, socfonyapis.StringValue request) {
    // TODO: implement updateAvatar
    throw UnimplementedError();
  }

  @override
  Future<socfonyapis.User> updateName(
      ServiceCall call, socfonyapis.StringValue request) {
    // TODO: implement updateName
    throw UnimplementedError();
  }

  @override
  Future<socfonyapis.User> updatePhone(
      ServiceCall call, socfonyapis.UpdateUserPhoneRequest request) {
    // TODO: implement updatePhone
    throw UnimplementedError();
  }
}
