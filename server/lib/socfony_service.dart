import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

import 'socfony_service_mixins/access_token.dart';
import 'socfony_service_mixins/phone_otp.dart';

class SocfonyService extends SocfonyServiceBase
    with AccessTokenMethods, PhoneOneTimePasswordMethods {
  @override
  Future<Moment> createMoment(ServiceCall call, CreateMomentRequest request) {
    // TODO: implement createMoment
    throw UnimplementedError();
  }

  @override
  Future<User> findUser(ServiceCall call, StringValue request) {
    // TODO: implement findUser
    throw UnimplementedError();
  }

  @override
  Future<BoolValue> hasMomentLiked(ServiceCall call, StringValue request) {
    // TODO: implement hasMomentLiked
    throw UnimplementedError();
  }

  @override
  Future<BoolValue> toggleMomentLike(ServiceCall call, StringValue request) {
    // TODO: implement toggleMomentLike
    throw UnimplementedError();
  }

  @override
  Future<User> updateUser(ServiceCall call, UpdateUserRequest request) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<User> updateUserName(ServiceCall call, StringValue request) {
    // TODO: implement updateUserName
    throw UnimplementedError();
  }

  @override
  Future<User> updateUserPhone(ServiceCall call, StringValue request) {
    // TODO: implement updateUserPhone
    throw UnimplementedError();
  }
}
