import 'package:grpc/grpc.dart';

export 'package:grpc/grpc.dart' show GrpcError;

/// gRPC server host.
const String _host = '192.168.0.5';

/// gRPC server port.
const int _port = 3000;

/// gRPC channel options.
const ChannelOptions _options = ChannelOptions(
  userAgent: 'Socfony/1.0.0',
  credentials: ChannelCredentials.insecure(),
);

final ClientChannel channel =
    ClientChannel(_host, port: _port, options: _options);
