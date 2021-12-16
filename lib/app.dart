// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:server/services.dart';
import 'package:single/single.dart';

import 'codec_registry.dart';
import 'database/connection_pool.dart';
import 'interceptors.dart';
import 'configuration.dart';

class App extends Server {
  App._() : super(services, interceptors, codecRegistry);

  factory App() => App._().._onDependencies();

  void run() async {
    final address = InternetAddress.anyIPv4;
    final port = single<Configuration>().port;

    await serve(
      address: address,
      port: port,
    );

    print('Socfony Server listening on $port port for $address');
  }

  void _onDependencies() {
    single + () => this;
    single + () => Configuration();
    single +
        () => DatabaseConnectionPool.fromString(
              single<Configuration>().database,
            );
  }
}
