import 'package:grpc/grpc.dart';

import 'verification_code/verification_code.service.dart';

final List<Service> services = [
  VerificationCodeService(),
];
