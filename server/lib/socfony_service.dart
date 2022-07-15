import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

import 'socfony_service_mixins/access_token.dart';
import 'socfony_service_mixins/phone_otp.dart';
import 'socfony_service_mixins/user.dart';

class SocfonyService extends SocfonyServiceBase
    with AccessTokenMethods, PhoneOneTimePasswordMethods, UserMethods {
  @override
  Future<Moment> createMoment(ServiceCall call, CreateMomentRequest request) {
    // TODO: implement createMoment
    throw UnimplementedError();
  }

  @override
  Future<BoolValue> toggleMomentLike(ServiceCall call, StringValue request) {
    // TODO: implement toggleMomentLike
    throw UnimplementedError();
  }

  @override
  Future<User> updateUserPhone(ServiceCall call, StringValue request) {
    // TODO: implement updateUserPhone
    throw UnimplementedError();
  }
}
