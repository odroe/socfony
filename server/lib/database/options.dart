/// Database connection options.
class DatabaseConnectionOptions {
  final String host;
  final int port;
  final String databaseName;
  final String? username;
  final String? password;
  final int connectionTimeout;
  final int queryTimeout;
  final String timezone;
  final bool useSSL;
  final bool isUnixSocket;
  final bool allowClearTextPassword;

  const DatabaseConnectionOptions({
    required this.host,
    required this.port,
    required this.databaseName,
    this.username,
    this.password,
    this.connectionTimeout = 30,
    this.queryTimeout = 30,
    this.timezone = 'UTC',
    this.useSSL = false,
    this.isUnixSocket = false,
    this.allowClearTextPassword = false,
  });
}
