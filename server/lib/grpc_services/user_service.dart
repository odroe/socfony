import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../database/models/access_token_model.dart';
import '../database/models/user_model.dart';
import '../database/repositories/user_repository.dart';
import '../services/access_token/auth_service.dart';

class UserService extends UserServiceBase {
  @override
  Future<User> find(ServiceCall call, StringValue request) async {
    final UserModel user = await UserRepository().find(request.value);

    return user.toGrpcMessage();
  }

  @override
  Future<User> update(ServiceCall call, UpdateUserRequest request) async {
    final AccessTokenModel accessToken = await AuthService(call).required();

    // TODO: check if user is the same as the one in the access token
    return User.getDefault();
  }
}
