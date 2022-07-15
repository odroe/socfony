import 'package:grpc/grpc.dart';

import 'socfony_service.dart';

/// Create a gRPC server.
final Server server = Server(
  [SocfonyService()],
  const <Interceptor>[],
  CodecRegistry(codecs: const [IdentityCodec()]),
);
