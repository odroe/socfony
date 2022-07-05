import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../database/models/access_token_model.dart';
import '../database/models/user_model.dart';
import '../database/repositories/user_repository.dart';
import '../services/access_token/auth_service.dart';

/// 用户 E.64 编码后的手机号码脱敏处理
String _maskPhone(String phone) {
  return phone.replaceRange(5, 10, '****');
}

class UserService extends UserServiceBase {
  @override
  Future<User> find(ServiceCall call, StringValue request) async {
    final UserModel user = await UserRepository().find(request.value);

    /// Get nullable current authenticated user.
    final AccessTokenModel? current = await AuthService(call).nullable();

    /// Get response message
    final User response = user.toGrpcMessage();

    /// If current owner id is user id, mask phone.
    if (current?.ownerId == user.id) {
      response.phone = _maskPhone(user.phone);
    }

    /// Return response.
    return response;
  }

  @override
  Future<User> update(ServiceCall call, UpdateUserRequest request) async {
    final AccessTokenModel accessToken = await AuthService(call).required();

    final UserModel user = await UserRepository().update(
      accessToken.ownerId,
      avatar: request.hasAvatar() == true ? request.avatar : null,
      bio: request.hasBio() == true ? request.bio : null,
      birthday: request.hasBirthday() == true ? request.birthday : null,
      gender: request.hasGender() == true ? request.gender : null,
    );

    /// Get response message
    final User response = user.toGrpcMessage();

    /// If access token owner is user, mask phone.
    if (accessToken.ownerId == user.id) {
      response.phone = _maskPhone(user.phone);
    }

    /// Return response.
    return response;
  }
}
