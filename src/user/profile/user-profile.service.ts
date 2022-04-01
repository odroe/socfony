// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import { Injectable } from '@nestjs/common';
import fs from '@odroe/fs';
import { PrismaClient, User, UserProfile } from '@prisma/client';
import dayjs = require('dayjs');
import { nanoid } from 'nanoid';
import { extname } from 'path';
import { StorageHost } from 'src/storage/storage_host';

@Injectable()
export class UserProfileService {
  constructor(
    private readonly prisma: PrismaClient,
    private readonly host: StorageHost,
  ) {}

  async resolve(user: User | string): Promise<UserProfile> {
    // resolve user ID
    const userId = typeof user === 'string' ? user : user.id;

    // Find user profile
    const userProfile = await this.prisma.userProfile.findUnique({
      where: { userId },
      rejectOnNotFound: false,
    });

    // If user profile exists, return it
    if (userProfile) return userProfile;

    // Create user profile
    return this.prisma.userProfile.create({
      data: { userId },
    });
  }

  async saveAvatar(userId: string, path: string): Promise<UserProfile> {
    const source = this.host.path(path);
    const metadata = await fs.metadata(source.toString());

    if (!(await metadata.isFile())) {
      throw new Error('File not found');
    }

    const extra = await metadata.extra();
    const mimeType = await extra.mimeType();
    if (!mimeType || mimeType.startsWith('image/')) {
      throw new Error('Invalid file type');
    }

    const destination = this.host.path(
      `public/${dayjs().format('YYYY/MM/DD')}/${nanoid(32)}.${extname(
        metadata.path,
      ).toLocaleLowerCase()}`,
    );

    await fs.copy(source.path, destination.toString());
    await fs.remove(source.path);

    const { userId: _userId } = await this.resolve(userId);
    return this.prisma.userProfile.update({
      where: { userId: _userId },
      data: { avatar: destination.path },
    });
  }
}
