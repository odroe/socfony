// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart';
import 'package:single/single.dart';
import 'package:tencent_sign/tc3.dart';

import 'configuration.dart';
import 'helpers/string.helper.dart';
import 'protobuf/google/protobuf/timestamp.pb.dart';
import 'protobuf/socfony.pb.dart';

class GetFederationToken {
  const GetFederationToken();

  Future<TencentCloudCredentials> _request({
    required String policy,
    required String secretId,
    required String secretKey,
  }) {
    final url = Uri.parse(r'https://sts.tencentcloudapi.com/');
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    final body = json.encode({
      'Name': StringHelper.string(16),
      'Policy': policy,
      'DurationSeconds': 7200,
    });

    final signature = TC3(secretId: secretId, secretKey: secretKey).sign(
      service: 'sts',
      uri: url,
      method: TC3_METHOD.post,
      headers: headers,
      payload: utf8.encode(body),
    );
    headers['Authorization'] = signature;
    headers['X-TC-Timestamp'] =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    headers['X-TC-Version'] = '2018-08-13';
    headers['X-TC-Action'] = 'GetFederationToken';
    headers['X-TC-Region'] = 'ap-chengdu';

    return post(url, headers: headers, body: body)
        .then<TencentCloudCredentials>((response) {
      final data = json.decode(response.body);
      if (data['Response']['Error'] != null) {
        throw Exception(data['Response']['Error']['Message']);
      }

      final credentials = data['Response']['Credentials'];

      return TencentCloudCredentials(
        secretId: credentials['TmpSecretId'],
        secretKey: credentials['TmpSecretKey'],
        token: credentials['Token'],
        expiredAt: Timestamp.fromDateTime(
            DateTime.parse(data['Response']['Expiration'])),
      );
    });
  }

  Future<TencentCloudCredentials> token(String? uid) {
    final options = single<Configuration>().storage;
    final appid = options.bucket.split('-')[1];
    final String policy = json.encode({
      'version': '2.0',
      'statement': [
        {
          'effect': 'allow',
          'action': [
            'cos:GetObject',
            'cos:HeadObject',
            'cos:OptionsObject',
          ],
          'resource': [
            'qcs::cos:${options.region}:uid/$appid:${options.bucket}/avatars/*',
            'qcs::cos:${options.region}:uid/$appid:${options.bucket}/public/*',
            if (uid != null)
              'qcs::cos:${options.region}:uid/$appid:${options.bucket}/private/$uid/*',
          ],
        },
        if (uid != null)
          {
            'effect': 'allow',
            'action': [
              'cos:PutObject',
              'cos:PostObject',
              'cos:DeleteObject',
            ],
            'resource': [
              'qcs::cos:${options.region}:uid/$appid:${options.bucket}/avatars/$uid.*',
              'qcs::cos:${options.region}:uid/$appid:${options.bucket}/public/$uid/*',
              'qcs::cos:${options.region}:uid/$appid:${options.bucket}/private/$uid/*',
            ],
          },
      ],
    });

    return _request(
      policy: policy,
      secretId: options.secretId,
      secretKey: options.secretKey,
    );
  }
}
