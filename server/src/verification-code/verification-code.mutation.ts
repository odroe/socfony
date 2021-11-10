import { PrismaClient } from "@prisma/client";
import { Metadata } from "@grpc/grpc-js";
import { Controller } from "@nestjs/common";
import { GrpcMethod } from "@nestjs/microservices";
import { StringValue } from "src/protobuf/google/protobuf/StringValue";
import { VerificationCodeMessage } from "./verification-code.message";
import { VerificationCodeService } from "./verification-code.service";
import { Empty } from "src/protobuf/google/protobuf/Empty";

@Controller()
export class VerificationCodeMutation {
    constructor(
        private readonly verificationCodeService: VerificationCodeService,
        private readonly prisma: PrismaClient,
    ) {}

    @GrpcMethod()
    async send(data: StringValue, metadata: Metadata): Promise<Empty> {
        const phoneNumber = this.#resolvePhoneNumber(data, metadata);
        const message = await VerificationCodeMessage.createMessage(this.prisma, phoneNumber);

        await this.verificationCodeService.send(message);

        return {};
    }

    #resolvePhoneNumber(data: StringValue, metadata: Metadata): string {
        if (data.value) {
            return data.value;
        }

        const [authentication] = metadata.get('authorization');
        const decoded =
            typeof authentication === 'string'
            ? authentication
            : authentication.toString();

        return decoded;
    }
}