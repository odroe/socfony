// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:io' show Platform;

import 'package:pool/pool.dart';
import 'package:postgres/postgres.dart';

/// Database connection pool
///
/// This class is used to manage a pool of database connections.
///
/// Usage:
/// - Use [Uri] to create a connection pool.
///    ```dart
///    final Uri uri = Uri();
///    // More fields can be set on the [uri] object.
///    final pool = DatabaseConnectionPool(uri);
///   ```
/// - Use [String] to create a connection pool.
///   ```dart
///   final pool = DatabaseConnectionPool('postgres://user:pass@host:port/database');
///   ```
class DatabaseConnectionPool {
  final Pool _pool;
  final Uri _uri;

  const DatabaseConnectionPool._({
    required Pool pool,
    required Uri uri,
  })  : _pool = pool,
        _uri = uri;

  /// Create a new database connection pool.
  ///
  /// The [uri] parameter is the connection [Uri].
  ///
  /// [Uri] is a [String] that contains the connection information.
  /// schema: `postgresql://user:password@host:port/database?ssl=false&pool_timeout=30&connect_timeout=30&connection_limit=<CUP process + 1>&time_zone=UTC&query_timeout=30`
  /// - [uri.scheme] is the database type, pinned to 'postgresql'.
  /// - [uri.userInfo] is the user name and password, separated by a colon.
  /// - [uri.host] is the host name or IP address.
  /// - [uri.port] is the port number.
  /// - [uri.path] is the database name. E.g: `/socfony`.
  /// - [uri.query] is the query string, containing the connection parameters:
  ///  - `ssl=<true|false|1|0>`: Whether to use SSL. Default is `false`.
  ///  - `pool_timeout=<seconds>`: The maximum time to wait for a connection from the pool. Default is `30`.
  ///  - `connect_timeout=<seconds>`: The maximum time to wait for a connection to be established. Default is `30`.
  ///  - `connection_limit=<number>`: The maximum number of connections to create. Default is [Platform.numberOfProcessors] + 1.
  ///  - `time_zone=<timezone>`: The time zone to use. Default is `UTC`.
  ///  - `query_timeout=<seconds>`: The maximum time to wait for a query to complete. Default is `30`.
  factory DatabaseConnectionPool(Uri uri) => DatabaseConnectionPool._(
        pool: _createPool(uri),
        uri: uri,
      );

  /// Using URI string create a new database connection pool.
  ///
  /// The [uri] schame: `postgresql://user:password@host:port/database?ssl=false&pool_timeout=30&connect_timeout=30&connection_limit=<CUP process + 1>&time_zone=UTC&query_timeout=30`
  /// - schame: `postgresql` is pinned.
  /// - user: Connection user name.
  /// - password: Connection password.
  /// - host: Connection host name or IP address.
  /// - port: Connection port number.
  /// - database: Connection database name. E.g: `socfony`.
  /// - ssl: Whether to use SSL. Default is `false`.
  /// - pool_timeout: The maximum time to wait for a connection from the pool. Default is `30`.
  /// - connect_timeout: The maximum time to wait for a connection to be established. Default is `30`.
  /// - connection_limit: The maximum number of connections to create. Default is [Platform.numberOfProcessors] + 1.
  /// - time_zone: The time zone to use. Default is `UTC`.
  /// - query_timeout: The maximum time to wait for a query to complete. Default is `30`.
  factory DatabaseConnectionPool.fromString(String uri) =>
      DatabaseConnectionPool(Uri.parse(uri));

  /// Create the database connection pool.
  static Pool _createPool(Uri uri) {
    final Map<String, String> query = uri.queryParameters;
    final int maxConnections = int.parse(
        query['connection_limit'] ?? '${Platform.numberOfProcessors + 1}');
    final int? poolTimeout = query['pool_timeout']?.isNotEmpty == true
        ? int.parse(query['pool_timeout']!)
        : null;
    final Duration? poolTimeoutDuration =
        poolTimeout == null ? null : Duration(seconds: poolTimeout);

    return Pool(maxConnections, timeout: poolTimeoutDuration);
  }

  /// Create a new database connection.
  ///
  /// This method returns a [Future] that completes with a [PostgreSQLConnection] object.
  Future<PostgreSQLConnection> _createConnection() async {
    // Chacl connection type.
    if (_uri.scheme != 'postgresql') {
      throw ArgumentError('Unsupported scheme: ${_uri.scheme}');
    }

    final List<String> auth = _uri.userInfo.split(':');
    final String timezone = _uri.queryParameters['time_zone'] ?? 'UTC';
    final bool ssl = _uri.queryParameters['ssl'] == 'true' ||
        _uri.queryParameters['ssl'] == '1';
    final int connectTimeout =
        int.tryParse(_uri.queryParameters['connect_timeout'] ?? '30') ?? 30;
    final int queryTimeout =
        int.tryParse(_uri.queryParameters['query_timeout'] ?? '30') ?? 30;

    // Create connection.
    final PostgreSQLConnection connection = PostgreSQLConnection(
      _uri.host,
      _uri.port,
      _uri.pathSegments.single,
      username: auth.first.isEmpty ? null : auth.first,
      password: auth.last.isEmpty ? null : auth.last,
      timeZone: timezone.isNotEmpty ? timezone : 'UTC',
      useSSL: ssl,
      timeoutInSeconds: connectTimeout,
      queryTimeoutInSeconds: queryTimeout,
    );

    // Open connection.
    await connection.open();

    return connection;
  }

  /// Get a database connection.
  ///
  /// This method returns a [Future] that completes with a [PostgreSQLConnection] object.
  Future<PostgreSQLConnection> getConnection() =>
      _pool.withResource<PostgreSQLConnection>(_createConnection);
}
