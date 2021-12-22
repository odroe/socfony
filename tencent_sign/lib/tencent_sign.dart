import 'dart:convert';

import 'package:crypto/crypto.dart';

enum TC3_METHOD { get, post }

class TC3 {
  /// Tencent Cloud Secret ID
  final String secretId;

  /// Tencent Cloud Secret Key
  final String secretKey;

  /// Tencent Cloud Signature 3 version
  const TC3({
    required this.secretId,
    required this.secretKey,
  });

  /// Generate signature
  String sign({
    required String service,
    required Uri uri,
    TC3_METHOD method = TC3_METHOD.post,
    Map<String, String>? headers,
    DateTime? timestamp,
    List<int>? payload,
  }) {
    final List<int> _payload = payload ?? <int>[];
    final String _method = method == TC3_METHOD.get ? 'GET' : 'POST';
    final DateTime _timestamp = timestamp ?? DateTime.now();
    final String _service = service.toLowerCase();
    final Map<String, String> _headers = (headers ?? <String, String>{})
      ..addAll({'host': uri.host});
    final String _date = _timestamp.toIso8601String().substring(0, 10);

    //-------------------------------------------------------------------------
    // STEP 1: Generate a Canonical Request
    //-------------------------------------------------------------------------
    // CanonicalRequest =
    //   HTTPRequestMethod + '\n' +
    //   CanonicalURI + '\n' +
    //   CanonicalQueryString + '\n' +
    //   CanonicalHeaders + '\n' +
    //   SignedHeaders + '\n' +
    //   HashedRequestPayload
    //-------------------------------------------------------------------------
    final String canonicalHeaders = _headers.entries
        .map(
          (e) => [
            e.key.toLowerCase().trim(),
            e.value.toLowerCase().trim(),
          ].join(':'),
        )
        .join('\n');
    final String signedHeaders =
        (_headers.keys.map((e) => e.toLowerCase().trim()).toList()..sort())
            .join(';');
    final String canonicalRequest = [
      // HTTPRequestMethod
      _method,
      // CanonicalURI
      uri.path.isEmpty ? '/' : uri.path,
      // CanonicalQueryString, value using RFC3986 encoding
      uri.queryParameters.entries
          .map(
            (e) => [e.key, Uri.encodeComponent(e.value)].join('='),
          )
          .join('&'),
      // uri.queryParameters.entries.map((e) => '${e.key}=${e.value}').join('&'),
      // CanonicalHeaders
      canonicalHeaders + '\n',
      // SignedHeaders
      signedHeaders,
      // HashedRequestPayload
      sha256.convert(_payload).toString(),
    ].join('\n');

    //-------------------------------------------------------------------------
    // STEP 2: Generate a String to Sign
    //-------------------------------------------------------------------------
    // StringToSign =
    //   Algorithm + '\n' +
    //   RequestTimestamp + '\n' +
    //   CredentialScope + '\n' +
    //   HashedCanonicalRequest
    //-------------------------------------------------------------------------
    final String credentialScope = [
      _date,
      _service,
      'tc3_request',
    ].join('/');
    final String hashedCanonicalRequest =
        sha256.convert(canonicalRequest.codeUnits).toString();
    final String stringToSign = [
      // Algorithm
      'TC3-HMAC-SHA256',
      // RequestTimestamp
      _timestamp.toUtc().millisecondsSinceEpoch ~/ 1000,
      // CredentialScope
      credentialScope,
      // HashedCanonicalRequest
      hashedCanonicalRequest,
    ].join('\n');

    //-------------------------------------------------------------------------
    // STEP 3: Generate a Signature
    //-------------------------------------------------------------------------
    // Signature = HexEncode(HMAC_SHA256(SecretSigning, StringToSign))
    //-------------------------------------------------------------------------
    final Digest secretDate =
        Hmac(sha256, utf8.encode('TC3$secretKey')).convert(utf8.encode(_date));
    final Digest secretService =
        Hmac(sha256, secretDate.bytes).convert(utf8.encode(_service));
    final Digest secretSigning =
        Hmac(sha256, secretService.bytes).convert(utf8.encode('tc3_request'));
    final String signature = Hmac(sha256, secretSigning.bytes)
        .convert(utf8.encode(stringToSign))
        .toString();

    //-------------------------------------------------------------------------
    // STEP 4: Generate Authorization
    //-------------------------------------------------------------------------
    // Authorization =
    //   "TC3-HMAC-SHA256" + ' ' +
    //   "Credential=${SecretId}/${CredentialScope}, " +
    //   "SignedHeaders=${SignedHeaders}, " +
    //   "Signature=${Signature}"
    //-------------------------------------------------------------------------
    return 'TC3-HMAC-SHA256 Credential=$secretId/$credentialScope, SignedHeaders=$signedHeaders, Signature=$signature';
  }
}

void main(List<String> args) {
  final auth = TC3(
    secretId: 'AKIDz8krbsJ5yKBZQpn74WFkmLPx3*******',
    secretKey: 'Gu5t9xGARNpq86cd98joQYCN3*******',
  );
  final headers = <String, String>{
    'Content-type': 'application/json; charset=utf-8',
  };
  final payload =
      r'{"Limit": 1, "Filters": [{"Values": ["\u672a\u547d\u540d"], "Name": "instance-name"}]}';
  final timestamp = DateTime.parse('2019-02-26 00:44:25+08:00');
  final signature = auth.sign(
    service: 'cvm',
    uri: Uri.parse('https://cvm.tencentcloudapi.com'),
    method: TC3_METHOD.post,
    headers: headers,
    payload: utf8.encode(payload),
    timestamp: timestamp,
  );

  print(signature);
}
