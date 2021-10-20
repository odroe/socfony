import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart';

import '../../../tencentcloud_sms.dart';

part 'options.dart';

String hash256(String data) => sha256.convert(utf8.encode(data)).toString();
Digest hmacSha256(List<int> key, String data) => Hmac(sha256, key).convert(utf8.encode(data));

class TencentCloudSMSSendAction {
  final TencentCloudSMS client;

  const TencentCloudSMSSendAction(this.client);

  Future<Response> send(SendTencentCloudSMSOptions options) async {
    final Uri url = Uri.https(client.endpoint, '/');
    final DateTime now = DateTime.now();
    // DateTime now = DateTime.parse('2021-10-20T18:50:35.742246');
    final Map<String, dynamic> body = await options.toJson(this);
    final String jsonEncodedBody = json.encode(body);
    final String authorization = client.sign(jsonEncodedBody, now);

    print('\n');
    print(jsonEncodedBody);
     print('\n');

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