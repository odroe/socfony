import 'package:betid/betid.dart';
import 'package:grpc/grpc.dart';
import 'package:postgres/postgres.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../auth.dart';
import '../database/connection.dart';

Moment _createMomentFromJson(Map<String, dynamic> json) {
  final Moment moment = Moment();
  moment.id = json['id'] as String;
  moment.userId = json['user_id'] as String;
  moment.commentsCount = json['comments_count'] as int;
  moment.likersCount = json['likers_count'] as int;
  moment.createdAt = Timestamp.fromDateTime(json['created_at']);

  if (json['titme'] != null && json['title'].isNotEmpty) {
    moment.title = json['title'] as String;
  }
  if (json['content'] != null && json['content'].isNotEmpty) {
    moment.content = json['content'] as String;
  }
  if (json['images'] != null && json['images'].isNotEmpty) {
    moment.images.addAll(json['images'] as List<String>);
  }

  return moment;
}

mixin MomentMethods on SocfonyServiceBase {
  @override
  Future<Moment> createMoment(
      ServiceCall call, CreateMomentRequest request) async {
    // If images is empty and content is empty, throw error
    if ((request.hasContent() == false || request.content.isEmpty) &&
        request.images.isEmpty) {
      throw GrpcError.invalidArgument('图片或者内容必须至少有一个不为空');
    }

    // Create database connection.
    final PooledDatabaseConnection connection =
        await PooledDatabaseConnection.connect();

    // Validate access token.
    final Map<String, dynamic> accessToken =
        await Auth(connection).required(call);

    // substitution Values
    final Map<String, dynamic> substitutionValues = <String, dynamic>{
      'id': 64.betid,
      'user_id': accessToken['owner_id'],
    };

    // If title is not empty, add to substitution values.
    if (request.hasTitle() && request.title.isNotEmpty) {
      substitutionValues['title'] = request.title;
    }

    // If content is not empty, add to substitution values.
    if (request.hasContent() && request.content.isNotEmpty) {
      substitutionValues['content'] = request.content;
    }

    // If images is not empty, add to substitution values.
    if (request.images.isNotEmpty) {
      substitutionValues['images'] = request.images;
    }

    final StringBuffer sql = StringBuffer('INSERT INTO moments');

    /// Build columns.
    sql.write('(');
    sql.write(substitutionValues.keys.join(','));
    sql.write(')');

    /// Build values.
    sql.write(' VALUES (');
    sql.write(substitutionValues.keys.map((key) => '@$key').join(','));
    sql.write(')');

    /// Build returning.
    sql.write(' RETURNING *');

    // Save moment.
    final PostgreSQLResult result = await connection.query(
      sql.toString(),
      substitutionValues: substitutionValues,
    );

    // Close database connection.
    await connection.close();

    return _createMomentFromJson(result.first.toColumnMap());
  }

  @override
  Future<BoolValue> toggleMomentLike(
      ServiceCall call, StringValue request) async {
    // Create database connection.
    final PooledDatabaseConnection connection =
        await PooledDatabaseConnection.connect();

    // Validate access token.
    final Map<String, dynamic> accessToken =
        await Auth(connection).required(call);

    // Find moment, if not found, throw error
    final PostgreSQLResult moment = await connection.query(
      'SELECT * FROM moments WHERE id = @id LIMIT 1',
      substitutionValues: {'id': request.value},
    );

    // If moment is not found, throw error
    if (moment.isEmpty) {
      throw GrpcError.invalidArgument('动态不存在');
    }

    // Find user liked moment row.
    final PostgreSQLResult userLikedMoment = await connection.query(
      'SELECT * FROM like_on_moments WHERE moment_id = @momentId AND user_id = @userId LIMIT 1',
      substitutionValues: {
        'momentId': request.value,
        'userId': accessToken['ownerId'],
      },
    );

    // If user liked moment, now unlike it.
    if (userLikedMoment.isNotEmpty) {
      final BoolValue result = await _unlikeMoment(
          connection, moment.first.toColumnMap()['id'], accessToken['ownerId']);

      // Close database connection.
      await connection.close();

      return result;
    }

    // If user didn't liked moment, now like it.
    final BoolValue result = await _likeMoment(
        connection, moment.first.toColumnMap()['id'], accessToken['ownerId']);

    // Close database connection.
    await connection.close();

    return result;
  }

  /// Private method to like moment.
  /// @param connection database connection.
  /// @param momentId moment id.
  /// @param userId user id.
  /// @returns BoolValue.
  Future<BoolValue> _likeMoment(PooledDatabaseConnection connection,
      String momentId, String userId) async {
    final bool result = await connection.transaction((connection) async {
      // Insert like on moment.
      final PostgreSQLResult insertLikeOnMoment = await connection.query(
        'INSERT INTO like_on_moments (moment_id, user_id) VALUES (@momentId, @userId) RETURNING *',
        substitutionValues: {
          'momentId': momentId,
          'userId': userId,
        },
      );

      // Update moment likers count.
      await connection.execute(
        'UPDATE moments SET likers_count = likers_count + 1 WHERE id = @momentId',
        substitutionValues: {'momentId': momentId},
      );

      return insertLikeOnMoment.isNotEmpty;
    });

    return BoolValue()..value = result;
  }

  /// Private method to unlike moment.
  /// @param connection Database connection.
  /// @param momentId Moment id.
  /// @param userId User id.
  /// @returns BoolValue.
  Future<BoolValue> _unlikeMoment(PooledDatabaseConnection connection,
      String momentId, String userId) async {
    await connection.transaction((connection) async {
      // Delete like on moment.
      await connection.execute(
        'DELETE FROM like_on_moments WHERE moment_id = @momentId AND user_id = @userId',
        substitutionValues: {
          'momentId': momentId,
          'userId': userId,
        },
      );

      // Update moment likers count.
      await connection.execute(
        'UPDATE moments SET likers_count = likers_count - 1 WHERE id = @momentId',
        substitutionValues: {'momentId': momentId},
      );
    });

    return BoolValue()..value = false;
  }
}
