import 'package:grpc/grpc.dart';

import 'codec_registry.dart';
import 'interceptors/interceptors.dart';
import 'services/services.dart';

/// Create a gRPC server.
final Server server = Server(services, interceptors, codecRegistry);
