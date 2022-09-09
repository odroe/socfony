import 'package:grpc/grpc.dart';

/// Codecs
const List<Codec> _codecs = <Codec>[
  IdentityCodec(),
  GzipCodec(),
];

/// Codes registry
final CodecRegistry codecRegistry = CodecRegistry(codecs: _codecs);
