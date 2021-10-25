// Original file: protos/socfony.proto

import type * as grpc from '@grpc/grpc-js'
import type { MethodDefinition } from '@grpc/proto-loader'
import type { Empty as _google_protobuf_Empty, Empty__Output as _google_protobuf_Empty__Output } from '../../google/protobuf/Empty';
import type { StringValue as _google_protobuf_StringValue, StringValue__Output as _google_protobuf_StringValue__Output } from '../../google/protobuf/StringValue';

/**
 * Verification code service.
 */
export interface VerificationCodeServiceClient extends grpc.Client {
  /**
   * Send a verification code to the specified phone number.
   */
  send(argument: _google_protobuf_StringValue, metadata: grpc.Metadata, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _google_protobuf_Empty__Output) => void): grpc.ClientUnaryCall;
  send(argument: _google_protobuf_StringValue, metadata: grpc.Metadata, callback: (error?: grpc.ServiceError, result?: _google_protobuf_Empty__Output) => void): grpc.ClientUnaryCall;
  send(argument: _google_protobuf_StringValue, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _google_protobuf_Empty__Output) => void): grpc.ClientUnaryCall;
  send(argument: _google_protobuf_StringValue, callback: (error?: grpc.ServiceError, result?: _google_protobuf_Empty__Output) => void): grpc.ClientUnaryCall;
  /**
   * Send a verification code to the specified phone number.
   */
  send(argument: _google_protobuf_StringValue, metadata: grpc.Metadata, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _google_protobuf_Empty__Output) => void): grpc.ClientUnaryCall;
  send(argument: _google_protobuf_StringValue, metadata: grpc.Metadata, callback: (error?: grpc.ServiceError, result?: _google_protobuf_Empty__Output) => void): grpc.ClientUnaryCall;
  send(argument: _google_protobuf_StringValue, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _google_protobuf_Empty__Output) => void): grpc.ClientUnaryCall;
  send(argument: _google_protobuf_StringValue, callback: (error?: grpc.ServiceError, result?: _google_protobuf_Empty__Output) => void): grpc.ClientUnaryCall;
  
  /**
   * Send a verification code to the authenticated user's phone number.
   */
  sendByAuthenticatedUser(argument: _google_protobuf_Empty, metadata: grpc.Metadata, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _google_protobuf_Empty__Output) => void): grpc.ClientUnaryCall;
  sendByAuthenticatedUser(argument: _google_protobuf_Empty, metadata: grpc.Metadata, callback: (error?: grpc.ServiceError, result?: _google_protobuf_Empty__Output) => void): grpc.ClientUnaryCall;
  sendByAuthenticatedUser(argument: _google_protobuf_Empty, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _google_protobuf_Empty__Output) => void): grpc.ClientUnaryCall;
  sendByAuthenticatedUser(argument: _google_protobuf_Empty, callback: (error?: grpc.ServiceError, result?: _google_protobuf_Empty__Output) => void): grpc.ClientUnaryCall;
  /**
   * Send a verification code to the authenticated user's phone number.
   */
  sendByAuthenticatedUser(argument: _google_protobuf_Empty, metadata: grpc.Metadata, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _google_protobuf_Empty__Output) => void): grpc.ClientUnaryCall;
  sendByAuthenticatedUser(argument: _google_protobuf_Empty, metadata: grpc.Metadata, callback: (error?: grpc.ServiceError, result?: _google_protobuf_Empty__Output) => void): grpc.ClientUnaryCall;
  sendByAuthenticatedUser(argument: _google_protobuf_Empty, options: grpc.CallOptions, callback: (error?: grpc.ServiceError, result?: _google_protobuf_Empty__Output) => void): grpc.ClientUnaryCall;
  sendByAuthenticatedUser(argument: _google_protobuf_Empty, callback: (error?: grpc.ServiceError, result?: _google_protobuf_Empty__Output) => void): grpc.ClientUnaryCall;
  
}

/**
 * Verification code service.
 */
export interface VerificationCodeServiceHandlers extends grpc.UntypedServiceImplementation {
  /**
   * Send a verification code to the specified phone number.
   */
  send: grpc.handleUnaryCall<_google_protobuf_StringValue__Output, _google_protobuf_Empty>;
  
  /**
   * Send a verification code to the authenticated user's phone number.
   */
  sendByAuthenticatedUser: grpc.handleUnaryCall<_google_protobuf_Empty__Output, _google_protobuf_Empty>;
  
}

export interface VerificationCodeServiceDefinition extends grpc.ServiceDefinition {
  send: MethodDefinition<_google_protobuf_StringValue, _google_protobuf_Empty, _google_protobuf_StringValue__Output, _google_protobuf_Empty__Output>
  sendByAuthenticatedUser: MethodDefinition<_google_protobuf_Empty, _google_protobuf_Empty, _google_protobuf_Empty__Output, _google_protobuf_Empty__Output>
}
