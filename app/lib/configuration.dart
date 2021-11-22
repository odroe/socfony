import 'package:grpc/grpc.dart' as grpc
    show ClientChannel, ChannelOptions, ChannelCredentials;

final grpc.ClientChannel channel = grpc.ClientChannel(
  '192.168.0.5',
  port: 3000,
  options: const grpc.ChannelOptions(
    userAgent: 'Socfony/1.0.0',
    credentials: grpc.ChannelCredentials.insecure(),
  ),
);
