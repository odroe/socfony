import 'package:grpc/grpc.dart';
import 'package:server/protobuf/socfony.pbgrpc.dart';

class MomentService extends MomentServiceBase {
  @override
  Future<Moment> create(ServiceCall call, CreateMomentRequest request) {
    if (request.content.isEmpty && _checkMomentMediaIsEmpty(request.media)) {
      throw GrpcError.invalidArgument('Missing content or media');
    }

    // TODO: implement createMoment
    throw UnimplementedError();
  }

  bool _checkMomentMediaIsEmpty(Moment_Media media) {
    switch (media.whichKind()) {
      case Moment_Media_Kind.image:
        return media.image.images.isEmpty;
      case Moment_Media_Kind.video:
        return media.video.path.isEmpty && media.video.poster.path.isEmpty;
      case Moment_Media_Kind.audio:
        final bool isEmpty = media.audio.path.isEmpty;
        if (media.audio.hasPoster()) {
          return isEmpty && media.audio.poster.path.isEmpty;
        }
        return isEmpty;
      case Moment_Media_Kind.notSet:
        return true;
    }
  }
}
