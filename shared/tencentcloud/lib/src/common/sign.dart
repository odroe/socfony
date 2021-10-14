import 'dart:collection';
import 'dart:convert';

import 'package:crypto/crypto.dart';

enum RequestMethod {
  get,
  post,
}

class Sign {
  final RequestMethod method;
  final Uri uri;
  final String payload;
  final DateTime dateTime;
  final String service;
  final String secretId;
  final String secretKey;
  final bool multipart;
  final String? boundary;

  const Sign({
    this.method = RequestMethod.post,
    this.payload = "",
    required this.uri,
    required this.dateTime,
    required this.service,
    required this.secretId,
    required this.secretKey,
    this.multipart = false,
    this.boundary,
  });

  @override
  String toString() {
    return '$algorithm Credential=$secretId/$date/$service/tc3_request, SignedHeaders=$signedHeaders, Signature=$signature';
  }

  String get algorithm => "TC3-HMAC-SHA256";

  String get signature => _hmacSha256(_str2sign, _kSigning).toString();

  String get _str2sign =>
      algorithm +
      "\n" +
      "${dateTime.millisecondsSinceEpoch / 1000}" +
      "\n" +
      "$date/$service/tc3_request" +
      "\n" +
      _hashSha256(canonicalRequest).toString();

  String get canonicalRequest =>
      "${method == RequestMethod.post ? 'POST' : 'GET'}"
      "\n"
      "${uri.path}"
      "\n"
      "${uri.query}"
      '\n'
      "$headers"
      "\n"
      "$signedHeaders"
      "\n"
      "$hashedPayload";

  String get hashedPayload => _hashSha256(payload).toString();

  String get _kSigning => _hmacSha256('tc3_request', _kService).toString();

  String get _kService => _hmacSha256(service, _kDate).toString();

  String get _kDate => _hmacSha256(date, 'TC3$secretKey').toString();

  /// The canonical headers.
  String get headers {
    final SplayTreeMap<String, String> headers = SplayTreeMap<String, String>();
    headers['host'] = uri.host;
    headers['content-type'] = "application/x-www-form-urlencoded";

    if (method == RequestMethod.post) {
      headers['content-type'] = multipart
          ? 'multipart/form-data; boundary=$boundary'
          : 'content-type:application/json';
    }

    return headers.entries
        .map((entry) => '${entry.key}:${entry.value}')
        .join('\n');
  }

  /// Headers that require verification
  String get signedHeaders => "content-type;host";

  /// The date in ISO8601 format, e.g. `2019-01-01`
  String get date {
    final utc = dateTime.toUtc();
    return '${utc.year}-${utc.month}-${utc.day}';
  }

  /// HMAC SHA256 helper
  ///
  /// [data] is the data to sign
  /// [key] is the key to sign with
  Digest _hmacSha256(String data, String key) =>
      Hmac(sha256, utf8.encode(key)).convert(utf8.encode(data));

  /// Hash SHA256 helper
  /// [data] is the data to sign
  Digest _hashSha256(String data) => sha256.convert(utf8.encode(data));
}
