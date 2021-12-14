// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'container.dart';
import 'database/connection_pool.dart';
import 'options.dart';

class App {
  static bool _isRegistered = false;

  final Container container;
  final List<String> arguments;

  const App._(this.container, this.arguments);

  factory App(List<String> arguments) {
    if (_isRegistered == false) {
      Container() + _factory(arguments);
      _isRegistered = true;
    }

    return Container()<App>();
  }

  static ContainerCreator<App> _factory(List<String> arguments) =>
      (Container container) => App._(container, arguments).._onDependencies();

  void call() {
    print(
      container<Options>().database,
    );
  }

  void _onDependencies() {
    container + (_) => Options.fromArguments(arguments);
    container + ($) => DatabaseConnectionPool.fromString($<Options>().database);
  }
}
