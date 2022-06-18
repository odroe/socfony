import 'package:grpc/grpc.dart';

import 'services.dart';

/// Create a gRPC server, and register the services.
Server createServer() {
  return Server(
    createServices(),
    const <Interceptor>[],
    CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
  );
}
