// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:single/single.dart';

import 'database/connection_pool.dart';
import 'options.dart';

class App {
  const App._();

  factory App() => App._().._onDependencies();

  void run() {
    // print(single<Options>());
    print(2222222);
  }

  void _onDependencies() {
    single + () => this;
    single + Options.fromEnvironment;
    single +
        () => DatabaseConnectionPool.fromString(single<Options>().database);
  }
}
