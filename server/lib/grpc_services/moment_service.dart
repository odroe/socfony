import 'package:grpc/grpc.dart';
import 'package:postgres/postgres.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../database/connection.dart';
import '../database/models/access_token_model.dart';
import '../database/models/moment_model.dart';
import '../database/repositories/moment_repository.dart';
import '../services/access_token/auth_service.dart';

class MomentService extends MomentServiceBase {
  @override
  Future<Moment> create(ServiceCall call, CreateMomentRequest request) async {
    final AccessTokenModel accessToken = await AuthService(call).required();

    if (request.hasContent() == false && request.images.isEmpty) {
      throw GrpcError.invalidArgument(
          'content and images cannot both be empty');
    }

    final MomentModel moment = await MomentRepository().create(
      userId: accessToken.ownerId,
      title: request.title,
      content: request.content,
      images: request.images,
    );

    return moment.toGrpcMessage();
  }

  @override
  Future<Empty> delete(ServiceCall call, StringValue request) async {
    /// Get access token
    final AccessTokenModel accessToken = await AuthService(call).required();

    /// Get moment
    final MomentModel? moment =
        await MomentRepository().findById(request.value);

    /// If moment not found, throw error
    if (moment == null) {
      throw GrpcError.notFound('moment not found');

      /// If Moment user id not equal to access token user id, throw error
    } else if (moment.userId != accessToken.ownerId) {
      throw GrpcError.permissionDenied('permission denied');
    }

    /// Delete moment
    await MomentRepository().delete(moment.id);

    return Empty();
  }

  @override
  Future<BoolValue> hasLiked(ServiceCall call, StringValue request) async {
    /// Get access token
    final AccessTokenModel? accessToken = await AuthService(call).nullable();
    if (accessToken == null) {
      return BoolValue(value: false);
    }

    /// Get moment
    final MomentModel? moment =
        await MomentRepository().findById(request.value);
    if (moment == null) {
      throw GrpcError.notFound('moment not found');
    }

    /// Create database connection
    final PooledDatabaseConnection connection =
        await PooledDatabaseConnection.connect();

    /// Query like on momment in database.
    final PostgreSQLResult result = await connection.query(
        'SELECT created_at FROM like_on_moments WHERE moment_id = @momentId AND user_id = @userId',
        substitutionValues: {
          'momentId': moment.id,
          'userId': accessToken.ownerId,
        });

    /// Close connection.
    await connection.close();

    return BoolValue(value: result.isNotEmpty);
  }

  @override
  Future<BoolValue> toggleLike(ServiceCall call, StringValue request) async {
    /// Get access token
    final AccessTokenModel accessToken = await AuthService(call).required();

    /// Find moment, if not found, throw error
    final MomentModel? moment =
        await MomentRepository().findById(request.value);
    if (moment == null) {
      throw GrpcError.notFound('moment not found');
    }

    /// Create database connection
    final PooledDatabaseConnection connection =
        await PooledDatabaseConnection.connect();

    /// Query like on momment in database.
    final PostgreSQLResult result = await connection.query(
        'SELECT created_at FROM like_on_moments WHERE moment_id = @momentId AND user_id = @userId',
        substitutionValues: {
          'momentId': moment.id,
          'userId': accessToken.ownerId,
        });

    /// If user has not liked moment, insert like on moment in database.
    if (result.isEmpty) {
      await connection.transaction((connection) async {
        /// Insert a like on moments.
        await connection.execute(
            'INSERT INTO like_on_moments (moment_id, user_id) VALUES (@momentId, @userId)',
            substitutionValues: {
              'momentId': moment.id,
              'userId': accessToken.ownerId,
            });

        /// increment likers count.
        await connection.execute(
            'UPDATE moments SET likers_count = likers_count + 1 WHERE id = @momentId',
            substitutionValues: {
              'momentId': moment.id,
            });
      });

      /// Close connection.
      await connection.close();

      return BoolValue(value: true);
    }

    await connection.transaction((connection) async {
      /// Delete like on moment in database.
      await connection.execute(
          'DELETE FROM like_on_moments WHERE moment_id = @momentId AND user_id = @userId',
          substitutionValues: {
            'momentId': moment.id,
            'userId': accessToken.ownerId,
          });

      /// decrement likers count.
      await connection.execute(
          'UPDATE moments SET likers_count = likers_count - 1 WHERE id = @momentId',
          substitutionValues: {
            'momentId': moment.id,
          });
    });

    /// Close connection.
    await connection.close();

    return BoolValue(value: false);
  }
}
