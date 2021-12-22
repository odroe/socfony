import 'package:minio/minio.dart';
import 'package:server/configuration.dart';

main() async {
  final options = Configuration().avatarStorageCos;
  final minio = Minio(
    endPoint: 'cos.${options.region}.myqcloud.com',
    accessKey: options.secretId,
    secretKey: options.secretKey,
    region: options.region,
  );

  final demo = await minio.presignedGetObject(
    options.bucket,
    'socfony.png',
    respHeaders: {
      'response-content-disposition': 'attachment; filename="socfony.png"',
    },
  );

  print(demo);
}
