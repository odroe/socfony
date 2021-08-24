import { Injectable } from '@nestjs/common';
import { OnEvent } from '@nestjs/event-emitter';
import { PrismaClient, User } from '@prisma/client';
import { nanoid } from 'nanoid';
import { pbkdf2Sync } from 'crypto';
import { logger, SEEDER } from '../const';

function sha256(str: string, salt: string): string {
  return pbkdf2Sync(str, salt, 10000, 64, 'sha256').toString('hex');
}

const id = nanoid(64);
const name = 'socfony';
const password = sha256(name, id);
const defaultUser: Pick<User, 'id' | 'email' | 'password' | 'name'> = {
  id,
  name,
  email: 'hello@socfony.com',
  password,
};

@Injectable()
export class UsersListener {
  constructor(private readonly prisma: PrismaClient) {}

  /**
   * Create default user
   */
  @OnEvent(SEEDER)
  async onCreateDefaultUser(): Promise<User> {
    // Find a user with same email or name.
    const user = await this.prisma.user.findFirst({
      where: {
        OR: [
          { name: { equals: name } },
          { email: { equals: defaultUser.email } },
        ],
      },
    });

    // If user exists, return it.
    if (user) {
      logger.log(`User ${user.name} already exists.`);
      return user;
    }

    // Create user.
    const userCreated = await this.prisma.user.create({ data: defaultUser });
    logger.log(`User ${userCreated.name} created.`);

    return userCreated;
  }
}
