import 'package:minio/minio.dart';

import 'configure.dart';

const String _endpoint = 'cos.${sf$cosRegion}.myqcloud.com';

final Minio minio = Minio(
  endPoint: _endpoint,
  accessKey: sf$cosAccessKey,
  secretKey: sf$cosSecretKey,
  region: sf$cosRegion,
);
