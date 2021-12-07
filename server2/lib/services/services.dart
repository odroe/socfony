import 'package:grpc/grpc.dart';
import 'package:server2/services/hello.service.dart';

final List<Service> services = [
  HelloService(),
];
