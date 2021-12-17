// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:server/app.dart';
import 'package:watcher/watcher.dart';

void main() {
  final App app = App();
  final Watcher watcher = Watcher('lib');
  watcher.events.listen((WatchEvent event) async {
    print('${event.type} ${event.path}');
    await app.close();
    app.run();
  });

  app.run();
}
