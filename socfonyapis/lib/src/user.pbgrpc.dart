///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'user.pb.dart' as $0;
export 'user.pb.dart';

class UserServiceClient extends $grpc.Client {
  static final _$findUnique =
      $grpc.ClientMethod<$0.UserWhereUniqueRequest, $0.User>(
          '/odroe.socfony.UserService/FindUnique',
          ($0.UserWhereUniqueRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.User.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.User> findUnique($0.UserWhereUniqueRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$findUnique, request, options: options);
  }
}

abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.UserWhereUniqueRequest, $0.User>(
        'FindUnique',
        findUnique_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UserWhereUniqueRequest.fromBuffer(value),
        ($0.User value) => value.writeToBuffer()));
  }

  $async.Future<$0.User> findUnique_Pre($grpc.ServiceCall call,
      $async.Future<$0.UserWhereUniqueRequest> request) async {
    return findUnique(call, await request);
  }

  $async.Future<$0.User> findUnique(
      $grpc.ServiceCall call, $0.UserWhereUniqueRequest request);
}
