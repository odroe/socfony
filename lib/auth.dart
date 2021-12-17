// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:server/database/connection_pool.dart';
import 'package:single/single.dart';

class Auth {
  const Auth._();
  static Auth Function() get fromSingle => () => Auth._();

  String get key => r'Authorization';

  String? getToken([Map<String, String>? metadata]) {
    for (MapEntry<String, String> entry in metadata?.entries ?? {}) {
      if (entry.key.toLowerCase() == key.toLowerCase()) {
        return entry.value;
      }
    }
  }

  getAccessToken([Map<String, String>? metadata]) async {
    final String? token = getToken(metadata);
    if (token == null) {
      return null;
    }

    final database = await single<DatabaseConnectionPool>().getConnection();
    final results = await database.mappedResultsQuery(
      r'SELECT * FROM access_tokens WHERE token = @token LIMIT 1 ORDER BY created_at DESC',
      substitutionValues: {'token': token},
    );
    
    return results.single;
  }
}
