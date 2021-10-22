import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' show Response;

import 'actions/send/send.dart';

export 'actions/send/send.dart';

/// Tencend cloud SMS
class TencentCloudSMS {

  // [TencentCloudSMS] instance
  static TencentCloudSMS? _internal;

  /// Tencent cloud SMS app id.
  final String appId;

  /// Tencent cloud secret id.
  final String secretId;

  /// Tencent cloud secret key.
  final String secretKey;

  /// Get [TencentCloudSMS] instance.
  static TencentCloudSMS get instance {
    if (_internal is TencentCloudSMS) {
     return _internal!;
    }

    throw Exception('TencentCloudSMS is not initialized');
  }

  /// Create a new [TencentCloudSMS] instance.
  const TencentCloudSMS({
    required this.appId,
    required this.secretId,
    required this.secretKey,
  });

  /// Initialize [TencentCloudSMS] instance.
  factory TencentCloudSMS.init({
    required String appId,
    required String secretId,
    required String secretKey,
  }) {
    if (_internal is TencentCloudSMS) {
      return _internal!;
    }

    return _internal = TencentCloudSMS(
      appId: appId,
      secretId: secretId,
      secretKey: secretKey,
    );
  }

  /// Get SMS APIs endpoint.
  String get endpoint => 'sms.tencentcloudapi.com';

  /// Sign a request.
  String sign(String payload, DateTime date) {
    // Get date UTC.
    final DateTime utc = date.toUtc();

    // Get headers stting.
    final String headersString = ['content-type:application/json; charset=utf-8', 'host:$endpoint'].join('\n') + '\n';

    final String canonicalRequest = 'POST\n/\n\n$headersString\ncontent-type;host\n${sha256.convert(utf8.encode(payload)).toString()}'; 

    final String dateStr = '${utc.year}-${utc.month}-${utc.day}';

    final String stringToSign = 'TC3-HMAC-SHA256\n${(date.millisecondsSinceEpoch~/1000).toString()}\n$dateStr/sms/tc3_request\n${sha256.convert(utf8.encode(canonicalRequest)).toString()}';

    final Digest secretDate = Hmac(sha256, utf8.encode('TC3' + secretKey)).convert(utf8.encode(dateStr));

    final Digest secretService = Hmac(sha256, secretDate.bytes).convert(utf8.encode('sms'));

    final Digest secretSigning = Hmac(sha256, secretService.bytes).convert(utf8.encode('tc3_request'));

    final Digest signature = Hmac(sha256, secretSigning.bytes).convert(utf8.encode(stringToSign));

    return 'TC3-HMAC-SHA256 Credential=$secretId/$dateStr/sms/tc3_request, SignedHeaders=content-type;host, Signature=${signature.toString()}';
  }

  /// Send SMS.
  /// 
  /// [options] is a [SendTencentCloudSMSOptions] instance.
  static Future<Response> send(SendTencentCloudSMSOptions options) => TencentCloudSMSSendAction(instance).send(options);
}
