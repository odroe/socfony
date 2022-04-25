// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Injectable } from '@nestjs/common';
import { PrismaClient, User } from '@prisma/client';

@Injectable()
export class UserService {
  constructor(private readonly prisma: PrismaClient) {}

  /**
   * Update a user's username.
   * @param userId Current user ID
   * @param username New username
   * @returns Updated user
   */
  async updateUsername(userId: string, username: string): Promise<User> {
    // Find exists user by username.
    const user = await this.prisma.user.findUnique({
      where: { username },
      rejectOnNotFound: false,
    });

    // If user exists, and exists user is not current user, throw error.
    if (user && user.id !== userId) {
      throw new Error('Username is already taken.');
    }

    // Update username.
    return this.prisma.user.update({
      where: { id: userId },
      data: { username },
    });
  }

  updateUserSecurity(
    user: string | User,
    field: 'email' | 'phone' | 'password',
    value: string,
  ): Promise<User> {
    const userId = typeof user === 'string' ? user : user.id;
    const userData = { [field]: value };
    return this.prisma.user.update({
      where: { id: userId },
      data: userData,
    });
  }
}
