import 'dart:convert';
import 'dart:math';

import 'package:grpc/grpc.dart';
import 'package:server/auth.dart';
import 'package:server/database/connection_pool.dart';
import 'package:server/helpers/string.helper.dart';
import 'package:server/protobuf/google/protobuf/empty.pb.dart';
import 'package:server/protobuf/google/protobuf/timestamp.pb.dart';
import 'package:server/protobuf/google/protobuf/wrappers.pb.dart';
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
        'media': hasMediaIsEmpty ? null : request.media.writeToJson(),
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

  /// Delete a moment.
  @override
  Future<Empty> delete(ServiceCall call, StringValue request) async {
    final AccessToken? accessToken =
        await single<Auth>().getAccessToken(call.clientMetadata);
    single<Auth>().validate(accessToken: accessToken);

    final database = await single<DatabaseConnectionPool>().getConnection();
    final mappedResults = await database.mappedResultsQuery(
      r'SELECT id, user_id FROM moments WHERE id = @id',
      substitutionValues: {'id': request.value},
    );
    if (mappedResults.isEmpty) {
      throw GrpcError.notFound('Moment not found');
    }

    final String momentOwnerId = mappedResults.first['moments']!['user_id']!;
    if (momentOwnerId != accessToken!.userId) {
      throw GrpcError.permissionDenied('You are not the owner of this moment');
    }

    await database.execute(
      r'DELETE FROM moments WHERE id = @id',
      substitutionValues: {'id': request.value},
    );

    return Empty();
  }

  /// Find all moments.
  @override
  Future<MomentList> findAll(
      ServiceCall call, FindAllMomentRequest request) async {
    final int limit = max(min(request.limit, 50), 1);
    final int offset = max(request.offset, 0);
    final database = await single<DatabaseConnectionPool>().getConnection();

    final String query =
        r'SELECT id, user_id, title, content, media, created_at FROM moments ORDER BY created_at DESC LIMIT @limit OFFSET @offset';
    final mappedResults = await database.mappedResultsQuery(
      query,
      substitutionValues: {'limit': limit, 'offset': offset},
    );

    final List<Moment> moments = [];
    for (final Map<String, dynamic> row in mappedResults) {
      final Moment moment = Moment()
        ..id = row['moments']['id']
        ..userId = row['moments']['user_id']
        ..title = row['moments']['title']
        ..content = row['moments']['content']
        ..createdAt = Timestamp.fromDateTime(row['moments']['created_at']);
      if (row['moments']['media'] != null &&
          row['moments']['media'] != '{}' &&
          row['moments']['media'] != '[]' &&
          row['moments']['media'] != '') {
        moment.media =
            Moment_Media.fromJson(json.encode(row['moments']['media']));
      }

      moments.add(moment);
    }

    return MomentList(moments: moments);
  }
}
