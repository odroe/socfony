import 'package:grpc/grpc.dart';

import 'services/user_service.dart';

/// Create a gRPC server, and register the services.
Server createServer() {
  return Server(
    [UserService()],
    const <Interceptor>[],
    CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
  );
}
