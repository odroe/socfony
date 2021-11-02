import 'package:grpc/grpc.dart';

import 'src/protobuf/socfony.pbgrpc.dart';

/// gRPC server host.
const String _host = '192.158.0.5';

/// gRPC server port.
const int _port = 3000;

/// gRPC channel options.
const ChannelOptions _options = ChannelOptions(
  userAgent: 'Socfony/0.0.1',
);

abstract class Grpc {
  /// gRPC client channel.
  static ClientChannel get channel =>
      ClientChannel(_host, port: _port, options: _options);

  /// Access token sub service
  static AccessTokenServiceClient get accessToken =>
      AccessTokenServiceClient(channel);

  /// Verification code sub service
  static VerificationCodeServiceClient get verificationCode =>
      VerificationCodeServiceClient(channel);
}
