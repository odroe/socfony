import 'package:grpc/grpc.dart';

import 'services/auth_service.dart';
import 'services/user_service.dart';

/// Create gRPC services.
List<Service> createServices() {
  return <Service>[
    AuthService(),
    UserService(),
  ];
}
