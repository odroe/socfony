import 'dart:convert';

import 'package:easysms/easysms.dart';
import 'package:grpc/grpc.dart';

import 'database.dart';

Future<Geteway> getGateway(String appId) async {
  final database = await mysql();
  final results = await database.query(
    'select value from Configuration where `key` = ?',
    ['tencentcloud']
  );

  if (results.isEmpty) {
    throw GrpcError.internal('未找到腾讯云配置');
  }

  final options = json.decode(results.single.fields['value']);

  return TencentCloudGeteway(
    secretId: options['secretId'],
    secretKey: options['secretKey'],
    appId: appId,
  );
}
