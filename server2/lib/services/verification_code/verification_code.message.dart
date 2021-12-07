import 'dart:convert';
import 'dart:math';

import 'package:easysms/easysms.dart';
import 'package:grpc/grpc.dart';
import 'package:server2/src/database.dart';
import 'package:server2/src/sms.dart';

class VerificationCodeMessage extends Message {
  VerificationCodeMessage(this.phone);

  final String phone;
  
  Map<String, dynamic>? _options;
  late final String _code;

  @override
  Future<void> initialize() async {
    if (_options == null) {
      await _fetchOptions();
    }

    _code = Random().nextInt(999999).toString().padLeft(6, '0');
  }

  @override
  String get content => _code;

  @override
  List<String> get data => (_options?['templateParams'] as List<dynamic>).map<String>((element) {
    switch (element) {
      case '<code>':
        return content;
      case '<minutes>':
        return (_options?['minutes']).toString();
    }

    return element;
  }).toList();

  @override
  String get signName => _options?['signName'];

  @override
  String get template => _options?['temaplateId'];

  void send() async {
    if (_options == null) {
      await _fetchOptions();
    }

    final geteway = await getGateway(_options?['appId']);
    await geteway.send(phone, this);
  }

  Future<void> _fetchOptions() async {
    final database = await mysql();
    final results = await database.query(
      'select value from Configuration where `key` = ? limit 1',
      ['tencentcloud-sms'],
    );
    database.close();
    if (results.isEmpty) {
      throw GrpcError.internal('未配置腾讯云短信服务');
    }

    _options = json.decode(results.single.fields['value']);
  }
}
