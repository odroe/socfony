import 'package:grpc/grpc.dart';

const List<Codec> codecs = [
  GzipCodec(),
  IdentityCodec(),
];

final CodecRegistry codecRegistry = CodecRegistry(codecs: codecs);
