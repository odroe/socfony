import 'package:grpc/grpc.dart';

import 'user_service.dart';

/// gRPC services.
final List<Service> services = <Service>[
  UserService(),
];
