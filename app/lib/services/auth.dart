import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';
import 'package:socfony/grpc.dart';
import 'package:socfony/src/protobuf/google/protobuf/empty.pb.dart';

import '../src/protobuf/socfony.pb.dart' hide DateTime;

class AuthService with ChangeNotifier {
  AccessTokenResponse? _accessTokenResponse;

  AccessTokenResponse? get accessTokenResponse => _accessTokenResponse;
  set accessTokenResponse(AccessTokenResponse? value) {
    _accessTokenResponse = value;
    notifyListeners();
  }

  String? get token => _accessTokenResponse?.token;

  String? get userId => _accessTokenResponse?.userId;

  DateTime? get expiresAt =>
      DateTime.tryParse(_accessTokenResponse?.expiredAt.value ?? "");

  DateTime? get refreshExpiredAt =>
      DateTime.tryParse(_accessTokenResponse?.refreshExpiredAt.value ?? "");

  bool get isAuthenticated =>
      _accessTokenResponse != null &&
      expiresAt != null &&
      DateTime.now().isBefore(expiresAt!);

  bool get isRefreshAuthenticated =>
      _accessTokenResponse != null &&
      refreshExpiredAt != null &&
      DateTime.now().isBefore(refreshExpiredAt!);

  CallOptions get callOptions {
    if (isAuthenticated) {
      return CallOptions(
        metadata: <String, String>{
          'authorization': token!,
        },
      );
    }

    return CallOptions();
  }

  Future<bool> authenticate(CreateAccessTokenRequest request) async {
    _accessTokenResponse = await Grpc.accessToken.create(request);

    return isAuthenticated;
  }

  Future<bool> refresh() async {
    if (!isRefreshAuthenticated) {
      return false;
    }

    _accessTokenResponse = await Grpc.accessToken.refresh(
      Empty(),
      options: callOptions,
    );

    return isAuthenticated;
  }

  void logout() {
    Grpc.accessToken.delete(
      Empty(),
      options: callOptions,
    );
    _accessTokenResponse = null;
    notifyListeners();
  }
}
