// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:easysms/easysms.dart';
import 'package:single/single.dart';

import 'configuration.dart';
import 'helpers/string.helper.dart';

class SMS extends Message {
  static TencentCloudGeteway Function() get fromSingle => () {
        final options = single<Configuration>().tencentCloudSms;

        return TencentCloudGeteway(
          appId: options.appId,
          secretId: options.secretId,
          secretKey: options.secretKey,
        );
      };

  SMS(this.phone) : code = StringHelper.numeric(6) {
    try {
      single<TencentCloudGeteway>();
    } catch (e) {
      single + fromSingle;
    }
  }

  final String phone;
  final String code;

  int get minute => 5;

  @override
  String get content => code;

  @override
  List<String> get data {
    final params = single<Configuration>().tencentCloudSms.templateParam;

    return params.map<String>((element) {
      final result = element.toString();

      switch (result) {
        case '<code>':
          return code;
        case '<minute>':
          return minute.toString();
      }

      return result;
    }).toList();
  }

  @override
  Future<void> initialize() async {}

  @override
  String get signName => single<Configuration>().tencentCloudSms.signName;

  @override
  String get template => single<Configuration>().tencentCloudSms.templateId;

  void send() async {
    await single<TencentCloudGeteway>().send(phone, this);
  }
}
