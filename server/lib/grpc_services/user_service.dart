import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../database/models/access_token_model.dart';
import '../database/models/user_model.dart';
import '../database/repositories/user_repository.dart';
import '../services/access_token/auth_service.dart';

class UserService extends UserServiceBase {
  /// Mask user phone
  User _maskUserPhone(User user, {bool mask = true}) {
    if (mask && user.hasPhone()) {
      user.phone = user.phone.replaceRange(5, 10, '****');
    } else {
      user.clearPhone();
    }

    return user;
  }

  @override
  Future<User> find(ServiceCall call, StringValue request) async {
    final UserModel user = await UserRepository().find(request.value);

    /// Get nullable current authenticated user.
    final AccessTokenModel? current = await AuthService(call).nullable();

    return _maskUserPhone(user.toGrpcMessage(),
        mask: current?.ownerId == user.id);
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

    return _maskUserPhone(user.toGrpcMessage(),
        mask: accessToken.ownerId == user.id);
  }
}
