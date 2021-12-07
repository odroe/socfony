import { Metadata, status } from "@grpc/grpc-js";
import { Controller, UsePipes, ValidationPipe } from "@nestjs/common";
import { GrpcMethod, RpcException } from "@nestjs/microservices";
import { Prisma, PrismaClient } from "@prisma/client";
import COS from "cos-nodejs-sdk-v5";
import { Timestamp } from "google-protobuf/google/protobuf/timestamp_pb";
import { nanoid } from "nanoid";
import { AccessTokenService } from "src/access-token/access-token.service";
import { CreateMomentRequest, Media, MomentEntity } from "src/protobuf/socfony_pb";
import { StorageService } from "src/storage/storage.service";

@Controller()
export class MomentMutation {
    constructor(
        private readonly accessTokenService: AccessTokenService,
        private readonly storageService: StorageService,
        private readonly prisma: PrismaClient,
    ) {}

    @GrpcMethod()
    async create(
        request: CreateMomentRequest.AsObject,
        metadata: Metadata,
    ) {
        const { userId } = await this.accessTokenService.verifyWithMatadata(metadata);
        const data = this.createDatabaseData(await this.createMomentRequest(request), userId);

        const moment = await this.prisma.moment.create({ data });

        return Object.assign({}, moment, {
            createdAt: Timestamp.fromDate(moment.createdAt).toObject(),
        });
    }

    private createDatabaseData(request: CreateMomentRequest, userId: string): Prisma.MomentUncheckedCreateInput {
        const input: Prisma.MomentUncheckedCreateInput = {
            id: nanoid(64),
            userId,
            title: request.hasTitle() ? request.getTitle() : null,
            body: request.hasBody() ? request.getBody() : null,
        };
        if (request.hasMedia()) {
            const media = request.getMedia();
            input.media = media.toObject();

            if (media.getKindCase() === Media.KindCase.IMAGE) {
                input.media = {
                    image: {
                        key: media.getImage().getKeyList(),
                    }
                };
            }
        }

        return input;
    }

    private async createMomentRequest(request: CreateMomentRequest.AsObject): Promise<CreateMomentRequest> {
        const media = await this.createMedia(request.media);
        const value = new CreateMomentRequest();
        value.setTitle(request.title);
        value.setBody(request.body);
        value.setMedia(media);

        if (value.hasBody() === false && value.hasMedia() === false) {
            throw new RpcException({
                code: status.INVALID_ARGUMENT,
                message: '正文和多媒体不能同时为空',
            });
        }

        return value;
    }

    private async createMedia(media?: Media.AsObject): Promise<Media> {
        const value = new Media();

        if (media?.audio && media.audio.src) {
            const audio = new Media.Audio();
            const exists = await this.storageService.exists(
                media.audio.src,
                (data) => this.validateIs('audio', data),
            );
            if (exists[media.audio.src] !== true) {
                throw new RpcException({
                    code: status.INVALID_ARGUMENT,
                    message: '音频文件不存在',
                });
            }

            audio.setSrc(media.audio.src);

            if (media.audio.poster) {
                const exists = await this.storageService.exists(
                    media.audio.poster,
                    (data) => this.validateIs('image', data),
                );
                if (exists[media.audio.poster] !== true) {
                    throw new RpcException({
                        code: status.INVALID_ARGUMENT,
                        message: '音频封面不存在',
                    });
                }

                audio.setPoster(media.audio.poster);
            }

            value.setAudio(audio);

            return value;
        } else if (media?.video) {
            const video = new Media.Video();
            const srcExists = await this.storageService.exists(
                media.video.src,
                (data) => this.validateIs('video', data),
            );
            if (srcExists[media.video.src] !== true) {
                throw new RpcException({
                    code: status.INVALID_ARGUMENT,
                    message: '视频文件不存在',
                });
            }

            const posterExists = await this.storageService.exists(
                media.video.poster,
                (data) => this.validateIs('image', data),
            );
            if (posterExists[media.video.poster] !== true) {
                throw new RpcException({
                    code: status.INVALID_ARGUMENT,
                    message: '视频封面不存在',
                });
            }

            video.setSrc(media.video.src);
            video.setPoster(media.video.poster);

            value.setVideo(video);

            return value;
        } else if (media?.image) {
            const paths: string[] = media.image.keyList || (media.image as any).key;
            const image = new Media.Image();

            if (paths.length === 0) {
                throw new RpcException({
                    code: status.INVALID_ARGUMENT,
                    message: '图片不存在',
                });
            } else if (paths.length > 9) {
                throw new RpcException({
                    code: status.INVALID_ARGUMENT,
                    message: '图片不能超过九张',
                });
            }

            const exists = await this.storageService.exists(
                paths,
                (data) => this.validateIs('image', data),
            );
            const has = Object.values(exists).reduce<boolean>((prev, curr) => {
                if (curr === true && prev === true) {
                    return true;
                }

                return false;
            }, true);

            if (has === false) {
                throw new RpcException({
                    code: status.INVALID_ARGUMENT,
                    message: '图片中有不存在的图片',
                });
            }

            image.setKeyList(paths);

            value.setImage(image);

            return value;
        }

        return null;
    }

    private validateIs(type: string, data?: COS.HeadObjectResult): boolean {
        for (const key in data?.headers ?? {}) {
            if (key.toLowerCase() === 'content-type') {
              const value: string = data.headers[key];

              return value.startsWith(type) && data?.statusCode === 200;
            }
          }

          return false;
    }
}
