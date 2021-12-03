import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

@immutable
class CosImage extends ImageProvider<CosImage> {
  @override
  ImageStreamCompleter load(CosImage key, DecoderCallback decode) {
    assert(key == this);

    // TODO: implement load
    throw UnimplementedError();
  }

  @override
  Future<CosImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<CosImage>(this);
  }
}
