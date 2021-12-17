// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

class Configuration {
  const Configuration._();

  factory Configuration() => Configuration._();

  final String database = "postgresql://seven@localhost:5432/socfony";
  final int port = 8080;
}
