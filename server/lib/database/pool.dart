import 'package:pool/pool.dart';

import '../configures.dart';

final kDatabasePool = Pool(
  kDatabaseConnectionMaxAllocatedResources,
  timeout: Duration(seconds: kDatabaseConnectionOptions.connectionTimeout),
);
