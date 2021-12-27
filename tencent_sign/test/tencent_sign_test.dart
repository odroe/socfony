import 'dart:convert';

import 'package:tencent_sign/tc3.dart';
import 'package:test/test.dart';

void main() {
  group('Test Sign', () {
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

    test('First Test', () {
      expect(signature,
          r'TC3-HMAC-SHA256 Credential=AKIDz8krbsJ5yKBZQpn74WFkmLPx3*******/2019-02-25/cvm/tc3_request, SignedHeaders=content-type;host, Signature=2230eefd229f582d8b1b891af7107b91597240707d778ab3738f756258d7652c');
    });
  });
}
