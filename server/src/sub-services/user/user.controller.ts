import { status } from "@grpc/grpc-js";
import { Controller } from "@nestjs/common";
import { GrpcMethod, RpcException } from "@nestjs/microservices";
import { PrismaClient, User } from "@prisma/client";
import { phoneSafeParse } from "src/helpers";
import { FindOneUserRequest } from "src/protobuf/odroe/socfony/FindOneUserRequest";
import { UserResponse } from "src/protobuf/odroe/socfony/UserResponse";

const Method = (method: string) => GrpcMethod("UserService", method);

@Controller()
export class UserSubServiceController {
    constructor(
        private readonly prisma: PrismaClient,
    ) {}

    @Method('FindOne')
    public async findOne(where: FindOneUserRequest): Promise<UserResponse> {
        const user = await this.prisma.user.findUnique({
            where,
            rejectOnNotFound: false,
        });

        if (!user) {
            throw new RpcException({
                code: status.NOT_FOUND,
                message: "User not found",
            });
        }

        return Object.assign<UserResponse, User, UserResponse>({}, user, {
            createdAt: {
                value: user.createdAt.toISOString(),
            },
            phone: phoneSafeParse(user.phone),
        });
    }
}