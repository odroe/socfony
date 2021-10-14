///
//  Generated code. Do not modify.
//  source: verification-code.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'verification-code.pb.dart' as $1;
export 'verification-code.pb.dart';

class VerificationCodeServiceClient extends $grpc.Client {
  static final _$send = $grpc.ClientMethod<$1.SendVerificationCodeRequest,
          $1.VerificationCodeResponse>(
      '/odroe.socfony.VerificationCodeService/Send',
      ($1.SendVerificationCodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.VerificationCodeResponse.fromBuffer(value));

  VerificationCodeServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.VerificationCodeResponse> send(
      $1.SendVerificationCodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$send, request, options: options);
  }
}

abstract class VerificationCodeServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.VerificationCodeService';

  VerificationCodeServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.SendVerificationCodeRequest,
            $1.VerificationCodeResponse>(
        'Send',
        send_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.SendVerificationCodeRequest.fromBuffer(value),
        ($1.VerificationCodeResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.VerificationCodeResponse> send_Pre($grpc.ServiceCall call,
      $async.Future<$1.SendVerificationCodeRequest> request) async {
    return send(call, await request);
  }

  $async.Future<$1.VerificationCodeResponse> send(
      $grpc.ServiceCall call, $1.SendVerificationCodeRequest request);
}
