// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'container.dart';
import 'database_connection_pool.dart';
import 'options.dart';

class App {
  static bool _isRegistered = false;

  final Container container;
  final List<String> arguments;

  const App._(this.container, this.arguments);

  factory App(List<String> arguments) {
    if (_isRegistered == false) {
      Container().register(_factory(arguments), name: 'app');
      _isRegistered = true;
    }

    return Container().get<App>();
  }

  static ContainerCreator<App> _factory(List<String> arguments) =>
      (Container container) => App._(container, arguments).._onDependencies();

  void run() {
    print(
      container.get<Options>().database,
    );
  }

  void _onDependencies() {
    container.register((container) => Options.fromArguments(arguments));
    container.register((container) =>
        DatabaseConnectionPool.fromString(container.get<Options>().database));
  }
}
