import 'package:grpc/grpc.dart' show Service;

import 'verification_code.service.dart';

final List<Service> services = [
  VerificationCodeService(),
];
