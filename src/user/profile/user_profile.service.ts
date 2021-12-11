// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Injectable } from '@nestjs/common';
import { PrismaClient, User, UserProfile } from '@prisma/client';

@Injectable()
export class UserProfileService {
  constructor(private readonly prisma: PrismaClient) {}

  async resolve(user: User | string): Promise<UserProfile> {
    const userId = typeof user === 'string' ? user : user.id;
    const result = await this.prisma.userProfile.findUnique({
      where: { userId },
      rejectOnNotFound: false,
    });

    if (!result) {
      return this.prisma.userProfile.create({
        data: { userId },
      });
    }

    return result;
  }
}
