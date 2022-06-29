import 'package:grpc/grpc.dart';

import 'grpc_services/auth_service.dart';
import 'grpc_services/phone_one_time_password_service.dart';
import 'grpc_services/user_service.dart';

/// Create gRPC services.
List<Service> createServices() {
  return <Service>[
    AuthService(),
    UserService(),
    PhoneOneTimePasswordService(),
  ];
}
