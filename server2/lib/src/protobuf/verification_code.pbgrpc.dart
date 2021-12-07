///
//  Generated code. Do not modify.
//  source: verification_code.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'google/protobuf/wrappers.pb.dart' as $0;
import 'google/protobuf/empty.pb.dart' as $1;
export 'verification_code.pb.dart';

class VerificationCodeServiceClient extends $grpc.Client {
  static final _$send = $grpc.ClientMethod<$0.StringValue, $1.Empty>(
      '/odroe.socfony.VerificationCodeService/Send',
      ($0.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  VerificationCodeServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.Empty> send($0.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$send, request, options: options);
  }
}

abstract class VerificationCodeServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.VerificationCodeService';

  VerificationCodeServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.StringValue, $1.Empty>(
        'Send',
        send_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> send_Pre(
      $grpc.ServiceCall call, $async.Future<$0.StringValue> request) async {
    return send(call, await request);
  }

  $async.Future<$1.Empty> send($grpc.ServiceCall call, $0.StringValue request);
}
