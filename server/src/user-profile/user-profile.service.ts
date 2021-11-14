import { Injectable } from '@nestjs/common';
import { Gender, PrismaClient, User, UserProfile } from '@prisma/client';
import { UserProfileEntity } from 'src/protobuf/socfony_pb';

@Injectable()
export class UserProfileService {
  constructor(private readonly prisma: PrismaClient) {}

  // Resolve user profile.
  // If user profile does not exist, create it.
  async resolve(user: string | User): Promise<UserProfile> {
    // find user profile
    const profile = await this.prisma.userProfile.findUnique({
      where: { userId: typeof user === 'string' ? user : user.id },
      rejectOnNotFound: false,
    });

    // if profile does not exist, create it
    if (!profile) {
      return await this.prisma.userProfile.create({
        data: { userId: typeof user === 'string' ? user : user.id },
      });
    }

    // return profile
    return profile;
  }

  // Resolve profile gender to GRPC gender type.
  gender2grpcGender(
    gender: Gender,
  ): UserProfileEntity.GenderMap[keyof UserProfileEntity.GenderMap] {
    // console.log(UserProfileEntity.Gender);
    console.log(Gender);

    return UserProfileEntity.Gender[gender.toUpperCase()];
  }

  // GRPC gender tranform to Prisma gender
  grpcGender2gender(
    gender: UserProfileEntity.GenderMap[keyof UserProfileEntity.GenderMap],
  ): Gender {
    switch (gender) {
      case UserProfileEntity.Gender.WOMAN:
        return Gender.woman;
      case UserProfileEntity.Gender.MAN:
        return Gender.man;
    }

    return Gender.unknown;
  }
}
