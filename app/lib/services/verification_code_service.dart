import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../configuration.dart';
import '../grpc.dart';
import 'auth_service.dart';

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
