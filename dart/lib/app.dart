// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:server/auth.dart';
import 'package:single/single.dart';

import 'codec_registry.dart';
import 'database/connection_pool.dart';
import 'get_federation_token.dart';
import 'interceptors.dart';
import 'configuration.dart';
import 'services.dart';

class App {
  App._();

  factory App() => App._().._onDependencies();

  Future<void> run() async {
    final address = InternetAddress.anyIPv4;
    final port = single<Configuration>().port;
    final server = single<Server>();

    await server.serve(
      address: address,
      port: port,
    );

    print('Socfony Server listening on $port port for $address');
  }

  Future<void> close() async => await single<Server>().shutdown();

  void _onDependencies() {
    single + () => this;
    single + () => Configuration();
    single + _createDatabaseConnectionPool();
    single + createServer();
    single + Auth.fromSingle;
    single + () => GetFederationToken();
  }

  Server Function() createServer() =>
      () => Server(services, interceptors, codecRegistry);

  DatabaseConnectionPool Function() _createDatabaseConnectionPool() =>
      () => DatabaseConnectionPool.fromString(
            single<Configuration>().database,
          );
}
