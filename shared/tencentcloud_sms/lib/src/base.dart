import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' show Response;

import 'actions/send/send.dart';

export 'actions/send/send.dart';

class TencentCloudSMS {
  static TencentCloudSMS? _internal;

  final String appId;
  final String secretId;
  final String secretKey;

  static TencentCloudSMS get instance {
    if (_internal is TencentCloudSMS) {
     return _internal!;
    }

    throw Exception('TencentCloudSMS is not initialized');
  }

  const TencentCloudSMS._({
    required this.appId,
    required this.secretId,
    required this.secretKey,
  });

  factory TencentCloudSMS({
    required String appId,
    required String secretId,
    required String secretKey,
  }) => TencentCloudSMS._(
        appId: appId,
        secretId: secretId,
        secretKey: secretKey,
      );

  factory TencentCloudSMS.init({
    required String appId,
    required String secretId,
    required String secretKey,
  }) {
    if (_internal is TencentCloudSMS) {
      return _internal!;
    }

    return _internal = TencentCloudSMS._(
      appId: appId,
      secretId: secretId,
      secretKey: secretKey,
    );
  }

  String get endpoint => 'sms.tencentcloudapi.com';

  String sign(String payload, DateTime date) {
    final DateTime utc = date.toUtc();
    final String headersString = ['content-type:application/json; charset=utf-8', 'host:$endpoint'].join('\n') + '\n';

    final String canonicalRequest = 'POST\n/\n\n$headersString\ncontent-type;host\n${hash256(payload)}'; 

    final String dateStr = '${utc.year}-${utc.month}-${utc.day}';

    final String stringToSign = 'TC3-HMAC-SHA256\n${(date.millisecondsSinceEpoch~/1000).toString()}\n$dateStr/sms/tc3_request\n${hash256(canonicalRequest)}';

    final Digest secretDate = Hmac(sha256, utf8.encode('TC3' + secretKey)).convert(utf8.encode(dateStr));

    final Digest secretService = Hmac(sha256, secretDate.bytes).convert(utf8.encode('sms'));

    final Digest secretSigning = Hmac(sha256, secretService.bytes).convert(utf8.encode('tc3_request'));

    final Digest signature = Hmac(sha256, secretSigning.bytes).convert(utf8.encode(stringToSign));

    return 'TC3-HMAC-SHA256 Credential=$secretId/$dateStr/sms/tc3_request, SignedHeaders=content-type;host, Signature=${signature.toString()}';
  }

  static Future<Response> send(SendTencentCloudSMSOptions options) => TencentCloudSMSSendAction(instance).send(options);
}
