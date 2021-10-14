import 'package:grpc/grpc.dart' show Server;

import 'codec_registry.dart';
import 'interceptors/interceptors.dart';
import 'services/services.dart';

final Server server = Server(
  services,
  interceptors,
  codecRegistry,
);
