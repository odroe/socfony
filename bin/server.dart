// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

void main(List<String> arguments) async {
  final str = 'postgresql://user:password@host:5432/database?ssl=false&pool_timeout=30&connect_timeout=30connection_limit=<CUP process + 1>&time_zone=UTC&query_timeout=30';
  final uri = Uri.parse(str);

  final auth = ''.split(':');

  print(auth.last.runtimeType);
}
