import 'package:grpc/grpc.dart';
import 'package:socfony_server/prisma.dart' as prisma;
import 'package:socfony_server/utils/user_message.dart';
import 'package:socfonyapis/socfonyapis.dart';

class UserService extends UserServiceBase {
  @override
  Future<User> findUnique(
      ServiceCall call, UserWhereUniqueRequest request) async {
    late final prisma.UserWhereUniqueInput where;
    switch (request.whichKind()) {
      case UserWhereUniqueRequest_Kind.id:
        where = prisma.UserWhereUniqueInput(id: request.id);
        break;
      case UserWhereUniqueRequest_Kind.login:
        where = prisma.UserWhereUniqueInput(login: request.login);
        break;
      case UserWhereUniqueRequest_Kind.notSet:
        throw GrpcError.invalidArgument('UserWhereUniqueRequest is not set');
    }

    final prisma.User? user = await prisma.client.user.findUnique(where: where);
    if (user == null) throw GrpcError.notFound('User not found');

    return convertPrismaToUser(user);
  }
}
