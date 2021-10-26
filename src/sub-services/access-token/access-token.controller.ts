import { Controller } from '@nestjs/common';
import { GrpcMethod } from '@nestjs/microservices';

@Controller()
export class AccessTokenSubServiceController {
  constructor() {}

  @GrpcMethod('AccessTokenService', 'Create')
  async create() {
    const now = new Date();
    now.getMilliseconds();
  }

  @GrpcMethod('AccessTokenService', 'Delete')
  async delete() {}

  @GrpcMethod('AccessTokenService', 'Refresh')
  async refresh() {}
}
