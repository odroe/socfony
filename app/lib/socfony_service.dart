import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

final ClientChannel _channel = ClientChannel(
  '192.168.31.5',
  port: 8080,
  options: const ChannelOptions(userAgent: 'socfony/1.0.0'),
);

Future<void> _authencateMetadataProvider(
    Map<String, String> metadata, String uri) async {
  print(metadata);
  print(uri);
}

final CallOptions _callOptions = CallOptions(
  timeout: const Duration(seconds: 10),
  providers: [_authencateMetadataProvider],
);

final SocfonyServiceClient socfonyService =
    SocfonyServiceClient(_channel, options: _callOptions);
