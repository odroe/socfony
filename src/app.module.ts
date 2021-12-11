// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Module } from '@nestjs/common';
import { AccessTokenModule } from 'access_token/access_token.module';
import { CommentModule } from 'comment/comment.module';
import { MediaModule } from 'media/media.module';
import { MomentModule } from 'moment/moment.module';
import { SharedModule } from 'shared/shared.module';
import { UserModule } from 'user/user.module';
import { VerificationCodeModule } from 'verification_code/verification_code.module';
import { GraphQL } from './graphql/graphql.module';

@Module({
  imports: [
    SharedModule,
    GraphQL,
    AccessTokenModule,
    VerificationCodeModule,
    UserModule,
    MediaModule,
    MomentModule,
    CommentModule,
  ],
})
export class AppModule {}
