///
//  Generated code. Do not modify.
//  source: moment.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'moment.pb.dart' as $5;
export 'moment.pb.dart';

class MomentServiceClient extends $grpc.Client {
  static final _$createMoment =
      $grpc.ClientMethod<$5.CreateMomentRequest, $5.Moment>(
          '/odroe.socfony.MomentService/CreateMoment',
          ($5.CreateMomentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $5.Moment.fromBuffer(value));

  MomentServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$5.Moment> createMoment($5.CreateMomentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createMoment, request, options: options);
  }
}

abstract class MomentServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.MomentService';

  MomentServiceBase() {
    $addMethod($grpc.ServiceMethod<$5.CreateMomentRequest, $5.Moment>(
        'CreateMoment',
        createMoment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.CreateMomentRequest.fromBuffer(value),
        ($5.Moment value) => value.writeToBuffer()));
  }

  $async.Future<$5.Moment> createMoment_Pre($grpc.ServiceCall call,
      $async.Future<$5.CreateMomentRequest> request) async {
    return createMoment(call, await request);
  }

  $async.Future<$5.Moment> createMoment(
      $grpc.ServiceCall call, $5.CreateMomentRequest request);
}
