import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

import 'auth/auth_provider.dart';

final ClientChannel _channel = ClientChannel(
  InternetAddress('192.168.31.5', type: InternetAddressType.IPv4),
  port: 8080,
  options: ChannelOptions(
    userAgent: 'socfony/1.0.0',
    codecRegistry: CodecRegistry(codecs: const <Codec>[
      IdentityCodec(),
      GzipCodec(),
    ]),
    credentials: const ChannelCredentials.insecure(),
  ),
);

/// Create unauthenticated client.
final SocfonyServiceClient _unauthenticatedClient =
    SocfonyServiceClient(_channel);

/// Refresh access token.
Future<AccessToken?> _refreshAccessToken(AccessToken accessToken) async {
  /// Create authenticated call options.
  final CallOptions callOptions = CallOptions(
    metadata: <String, String>{'authorization': accessToken.token},
  );

  try {
    final AccessToken result = await _unauthenticatedClient
        .refreshAccessToken(Empty(), options: callOptions);

    // Save access token.
    await writeAccessToken(result);

    // Return access token.
    return result;
  } on GrpcError catch (e) {
    // If error, destroy access token.
    if (e.code == StatusCode.unauthenticated) {
      await destroyAccessToken();
    }
  }

  return null;
}

/// Resolve access token
Future<AccessToken?> _resolveAccessToken([AccessToken? accessToken]) async {
  // If access token is null, return null.
  if (accessToken == null) return null;

  // If token is expired, refresh it.
  if (accessToken.expiredAt.toDateTime().isBefore(DateTime.now())) {
    return await _refreshAccessToken(accessToken);
  }

  // Otherwise, return access token.
  return accessToken;
}

Future<void> _authencateMetadataProvider(
    Map<String, String> metadata, String uri) async {
  // Read access token.
  final AccessToken? accessToken = await readAccessToken();

  // Reslove access token.
  final AccessToken? resolvedAccessToken =
      await _resolveAccessToken(accessToken);

  // If access token already, add to metadata.
  if (resolvedAccessToken?.hasToken() == true) {
    metadata['authorization'] = resolvedAccessToken!.token;
  }
}

final CallOptions _callOptions = CallOptions(
  timeout: const Duration(seconds: 10),
  providers: [_authencateMetadataProvider],
);

/// Public refresh access token.
Future<void> refreshAccessToken() async {
  // Read access token.
  final AccessToken? accessToken = await readAccessToken();

  // Access token is null, return.
  if (accessToken == null) return;

  // Refresh access token.
  await _refreshAccessToken(accessToken);
}

final SocfonyServiceClient socfonyService =
    SocfonyServiceClient(_channel, options: _callOptions);
