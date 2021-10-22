import 'dart:convert';

import 'package:http/http.dart';

import '../../base.dart';

part 'options.dart';

/// Tencend cloud SMS action.
/// See: https://cloud.tencent.com/document/product/382/55981
/// 
/// [client] - Tencent cloud SMS client.
class TencentCloudSMSSendAction {

  /// Tencent cloud SMS client.
  final TencentCloudSMS client;

  /// Tencent cloud SMS action.
  /// 
  /// [client] - Tencent cloud SMS client.
  const TencentCloudSMSSendAction(this.client);

  /// Send SMS.
  /// 
  /// [options] - Send SMS options.
  Future<Response> send(SendTencentCloudSMSOptions options) async {
    // Create request url.
    final Uri url = Uri.https(client.endpoint, '/');

    // Get now time.
    final DateTime now = DateTime.now();

    // Get request body.
    final Map<String, dynamic> body = await options.toMap(this);

    // Get request json encoded body.
    final String jsonEncodedBody = json.encode(body);

    // create request authorization.
    final String authorization = client.sign(jsonEncodedBody, now);

    return await post(url, headers: {
      'X-TC-Action': 'SendSms',
      'X-TC-Timestamp': (now.millisecondsSinceEpoch ~/ 1000).toString(),
      'X-TC-Version': '2021-01-11',
      'X-TC-Region': 'ap-guangzhou',
      'Host': client.endpoint,
      'Content-Type': 'application/json',
      'Authorization': authorization,
    }, body: jsonEncodedBody);
  }
}