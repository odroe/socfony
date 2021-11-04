import 'package:flutter/widgets.dart';
import 'package:provider/src/provider.dart';
import 'package:socfony/services/auth.dart';
import 'package:socfony/src/protobuf/google/protobuf/empty.pb.dart';
import 'package:socfony/src/protobuf/google/protobuf/wrappers.pb.dart';

import '../grpc.dart';

abstract class VerificationCodeService {
  static Future<void> send(String phoneNumber) {
    return Grpc.verificationCode.send(StringValue(
      value: '+86' + phoneNumber,
    ));
  }

  static Future<void> sendWithAuth(BuildContext context) {
    return Grpc.verificationCode.sendByAuthenticatedUser(
      Empty(),
      options: context.read<AuthService>().callOptions,
    );
  }
}
