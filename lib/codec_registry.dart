import 'package:grpc/grpc.dart';

const List<Codec> _codecs = [
  IdentityCodec(),
  GzipCodec(),
];

CodecRegistry codecRegistry = CodecRegistry(codecs: _codecs);
