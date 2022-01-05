import 'dart:convert';

import 'package:grpc/grpc.dart';
import 'package:server/auth.dart';
import 'package:server/database/connection_pool.dart';
import 'package:server/helpers/string.helper.dart';
import 'package:server/protobuf/google/protobuf/timestamp.pb.dart';
import 'package:server/protobuf/socfony.pbgrpc.dart';
import 'package:single/single.dart';

/// Moment gRPC sub service.
class MomentService extends MomentServiceBase {
  /// Create a new moment.
  @override
  Future<Moment> create(ServiceCall call, CreateMomentRequest request) async {
    final hasMediaIsEmpty = _checkMomentMediaIsEmpty(request.media);
    if (request.content.isEmpty && hasMediaIsEmpty) {
      throw GrpcError.invalidArgument('Missing content or media');
    }

    final AccessToken? accessToken =
        await single<Auth>().getAccessToken(call.clientMetadata);
    single<Auth>().validate(accessToken: accessToken);

    final database = await single<DatabaseConnectionPool>().getConnection();
    final String momentId = StringHelper.string(64);
    await database.execute(
      r'INSERT INTO moments (id, user_id, title, content, media) VALUES (@id, @userId, @title, @content, @media)',
      substitutionValues: {
        'id': momentId,
        'userId': accessToken!.userId,
        'title': request.title.isNotEmpty ? request.title : null,
        'content': request.content.isNotEmpty ? request.content : null,
        'media':
            hasMediaIsEmpty ? null : json.encode(request.media.toProto3Json()),
      },
    );

    return Moment()
      ..id = momentId
      ..userId = accessToken.userId
      ..title = request.title
      ..content = request.content
      ..media = request.media
      ..createdAt = Timestamp.fromDateTime(DateTime.now());
  }

  // Check if the moment media is empty.
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
