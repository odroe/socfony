import { Metadata } from "@grpc/grpc-js";
import { Controller } from "@nestjs/common";
import { GrpcMethod } from "@nestjs/microservices";
import { StringValue } from "google-protobuf/google/protobuf/wrappers_pb";
import { CreateStorageLinkRequest } from "src/protobuf/socfony_pb";

@Controller()
export class StorageMutation {
    @GrpcMethod()
    async create(
        request: CreateStorageLinkRequest.AsObject,
        metadata: Metadata,
    ): Promise<StringValue.AsObject> {}
}
