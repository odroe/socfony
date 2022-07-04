import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../database/models/access_token_model.dart';
import '../database/models/phone_sent_code_model.dart';
import '../database/models/user_model.dart';
import '../database/repositories/access_token_repository.dart';
import '../database/repositories/phone_sent_code_repository.dart';
import '../database/repositories/user_repository.dart';
import '../services/access_token/auth_service.dart' as $auth;

class AuthService extends AuthServiceBase {
  @override
  Future<AccessToken> create(
      ServiceCall call, CreateAccessTokenRequest request) async {
    /// Find phone sent code
    final PhoneSentCodeModel? phoneSentCode =
        await PhoneSentCodeRepository().find(request.phone);

    /// If phone sent code not fount, or expired, throw exception.
    if (phoneSentCode == null ||
        phoneSentCode.expiredAt.isBefore(DateTime.now())) {
      throw Exception('Phone sent code not found or expired.');
    }

    /// Delete phone sent code.
    await PhoneSentCodeRepository().delete(phoneSentCode);

    /// Find or create user.
    final UserModel user = await UserRepository().findOrCreate(request.phone);

    /// Create access token.
    final AccessTokenModel accessToken =
        await AccessTokenRepository().create(user.id);

    /// Create response.
    return AccessToken(
      token: accessToken.token,
      userId: user.id,
      expiredAt: Timestamp.fromDateTime(accessToken.expiredAt),
      refreshExpiredAt: Timestamp.fromDateTime(accessToken.refreshExpiredAt),
    );
  }

  @override
  Future<Empty> delete(ServiceCall call, Empty request) async {
    final AccessTokenModel? accessToken =
        await $auth.AuthService(call).nullable();
    if (accessToken != null) {
      await AccessTokenRepository().delete(accessToken.token);
    }

    return Empty();
  }

  @override
  Future<AccessToken> refresh(ServiceCall call, Empty request) async {
    final AccessTokenModel accesstoken =
        await $auth.AuthService(call).refresh();
    final AccessTokenModel refreshedToken =
        await AccessTokenRepository().refresh(accesstoken.token);

    return AccessToken(
      token: refreshedToken.token,
      userId: refreshedToken.ownerId,
      expiredAt: Timestamp.fromDateTime(refreshedToken.expiredAt),
      refreshExpiredAt: Timestamp.fromDateTime(refreshedToken.refreshExpiredAt),
    );
  }
}
