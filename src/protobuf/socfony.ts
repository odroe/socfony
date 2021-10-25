import type * as grpc from '@grpc/grpc-js';
import type { MessageTypeDefinition } from '@grpc/proto-loader';

import type { VerificationCodeServiceClient as _odroe_socfony_VerificationCodeServiceClient, VerificationCodeServiceDefinition as _odroe_socfony_VerificationCodeServiceDefinition } from './odroe/socfony/VerificationCodeService';

type SubtypeConstructor<Constructor extends new (...args: any) => any, Subtype> = {
  new(...args: ConstructorParameters<Constructor>): Subtype;
};

export interface ProtoGrpcType {
  google: {
    protobuf: {
      BoolValue: MessageTypeDefinition
      BytesValue: MessageTypeDefinition
      DoubleValue: MessageTypeDefinition
      Empty: MessageTypeDefinition
      FloatValue: MessageTypeDefinition
      Int32Value: MessageTypeDefinition
      Int64Value: MessageTypeDefinition
      StringValue: MessageTypeDefinition
      UInt32Value: MessageTypeDefinition
      UInt64Value: MessageTypeDefinition
    }
  }
  odroe: {
    socfony: {
      /**
       * Verification code service.
       */
      VerificationCodeService: SubtypeConstructor<typeof grpc.Client, _odroe_socfony_VerificationCodeServiceClient> & { service: _odroe_socfony_VerificationCodeServiceDefinition }
    }
  }
}

