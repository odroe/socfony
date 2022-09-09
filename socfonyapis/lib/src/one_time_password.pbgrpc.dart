///
//  Generated code. Do not modify.
//  source: one_time_password.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'one_time_password.pb.dart' as $0;
import 'google/protobuf/wrappers.pb.dart' as $1;
export 'one_time_password.pb.dart';

class OneTimePasswordServiceClient extends $grpc.Client {
  static final _$send =
      $grpc.ClientMethod<$0.SendOneTimePasswordRequest, $1.StringValue>(
          '/odroe.socfony.OneTimePasswordService/Send',
          ($0.SendOneTimePasswordRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.StringValue.fromBuffer(value));
  static final _$verify =
      $grpc.ClientMethod<$0.VerifyOneTimePasswordRequest, $1.BoolValue>(
          '/odroe.socfony.OneTimePasswordService/Verify',
          ($0.VerifyOneTimePasswordRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.BoolValue.fromBuffer(value));

  OneTimePasswordServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.StringValue> send(
      $0.SendOneTimePasswordRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$send, request, options: options);
  }

  $grpc.ResponseFuture<$1.BoolValue> verify(
      $0.VerifyOneTimePasswordRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verify, request, options: options);
  }
}

abstract class OneTimePasswordServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.OneTimePasswordService';

  OneTimePasswordServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.SendOneTimePasswordRequest, $1.StringValue>(
            'Send',
            send_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.SendOneTimePasswordRequest.fromBuffer(value),
            ($1.StringValue value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.VerifyOneTimePasswordRequest, $1.BoolValue>(
            'Verify',
            verify_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.VerifyOneTimePasswordRequest.fromBuffer(value),
            ($1.BoolValue value) => value.writeToBuffer()));
  }

  $async.Future<$1.StringValue> send_Pre($grpc.ServiceCall call,
      $async.Future<$0.SendOneTimePasswordRequest> request) async {
    return send(call, await request);
  }

  $async.Future<$1.BoolValue> verify_Pre($grpc.ServiceCall call,
      $async.Future<$0.VerifyOneTimePasswordRequest> request) async {
    return verify(call, await request);
  }

  $async.Future<$1.StringValue> send(
      $grpc.ServiceCall call, $0.SendOneTimePasswordRequest request);
  $async.Future<$1.BoolValue> verify(
      $grpc.ServiceCall call, $0.VerifyOneTimePasswordRequest request);
}
