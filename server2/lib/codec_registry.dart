import 'package:grpc/grpc.dart';

final CodecRegistry codecRegistry = CodecRegistry(
  codecs: <Codec> [
    GzipCodec(),
    IdentityCodec(),
  ],
);