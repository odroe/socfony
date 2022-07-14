import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

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
  Future<BoolValue> hasLiked(ServiceCall call, StringValue request) {
    // TODO: implement hasLiked
    throw UnimplementedError();
  }

  @override
  Future<BoolValue> toggleLike(ServiceCall call, StringValue request) {
    // TODO: implement toggleLike
    throw UnimplementedError();
  }
}
