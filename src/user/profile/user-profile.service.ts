// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Injectable } from '@nestjs/common';
import { PrismaClient, User, UserProfile } from '@prisma/client';

@Injectable()
export class UserProfileService {
  constructor(private readonly prisma: PrismaClient) {}

  async resolve(user: User): Promise<UserProfile> {
    // Find user profile
    const userProfile = await this.prisma.userProfile.findUnique({
      where: { userId: user.id },
      rejectOnNotFound: false,
    });

    // If user profile exists, return it
    if (userProfile) return userProfile;

    // Create user profile
    return this.prisma.userProfile.create({
      data: { userId: user.id },
    });
  }
}