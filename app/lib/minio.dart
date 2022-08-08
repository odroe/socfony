import 'package:minio/minio.dart';

import 'configure.dart';

final Minio minio = Minio(
  endPoint: sf$cosAddress,
  accessKey: sf$cosAccessKey,
  secretKey: sf$cosSecretKey,
);
