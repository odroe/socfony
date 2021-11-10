
import 'package:grpc/grpc.dart';

import 'codec_registry.dart';
import 'services/services.dart';

final Server server = Server(
  services,
  [],
  codecRegistry
);
