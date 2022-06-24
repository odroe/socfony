import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../database/repositories/user_repository.dart';

class AuthService extends AuthServiceBase {
  late final UserRepository userRepository;

  AuthService() {
    userRepository = const UserRepository();
  }

  @override
  Future<AccessToken> create(
      ServiceCall call, CreateAccessTokenRequest request) async {
    final user = await userRepository.find('11111');

    print(call);

    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Empty> delete(ServiceCall call, Empty request) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<AccessToken> refresh(ServiceCall call, Empty request) {
    // TODO: implement refresh
    throw UnimplementedError();
  }
}
