import 'dart:io' as io;
import 'package:easysms/easysms.dart' as easysms;
import 'database/options.dart' as database;

/// Database connection options.
const database.DatabaseConnectionOptions kDatabaseConnectionOptions =
    database.DatabaseConnectionOptions(
  host: 'localhost',
  port: 5432,
  databaseName: 'socfony',
  username: 'seven',
  password: null,
);

/// Database connection max allocated connections.
final int kDatabaseConnectionMaxAllocatedResources =
    io.Platform.numberOfProcessors * 2 + 1;

/// Tencent Cloud sdhort message service geteway.
const easysms.Geteway kTencentCloudSdhortMessageServiceGeteway =
    easysms.TencentCloudGeteway(
  appId: 'You Tencent Cloud SMS APP ID>',
  secretId: 'You Tencent Cloud Secret ID',
  secretKey: 'You Tencent Cloud Secret Key',
);
