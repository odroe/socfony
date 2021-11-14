import 'package:flutter/widgets.dart';
import 'package:grpc/grpc.dart';
import 'package:provider/provider.dart';
import 'package:socfony/grpc.dart';
import 'package:socfony/services/auth_service.dart';
import 'package:socfony/src/protobuf/google/protobuf/wrappers.pb.dart';
import 'package:socfony/src/protobuf/socfony.pbgrpc.dart';

class VerificationCodeService {
  final BuildContext context;

  const VerificationCodeService(this.context);

  CallOptions get callOptions => context.read<AuthService>().callOptions;

  Future<void> send([String? phone]) async {
    final request = StringValue(value: phone != null ? '+86' + phone : null);

    await VerificationCodeMutationClient(channel)
        .send(request, options: callOptions);
  }
}
