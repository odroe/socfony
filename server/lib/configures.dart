import 'dart:io';

import 'database/options.dart';

/// Database connection options.
const DatabaseConnectionOptions kDatabaseConnectionOptions =
    DatabaseConnectionOptions(
  host: 'localhost',
  port: 5432,
  databaseName: 'socfony',
  username: 'seven',
  password: null,
);

/// Database connection max allocated connections.
final int kDatabaseConnectionMaxAllocatedResources =
    Platform.numberOfProcessors * 2 + 1;
