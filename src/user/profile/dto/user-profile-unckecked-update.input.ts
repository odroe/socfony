import { InputType, PickType } from '@nestjs/graphql';
import { Prisma } from '@prisma/client';
import { UserProfile } from '../entities/user-profile.entity';

@InputType()
export class UserProfileUncheckedUpdateInput
  extends PickType(
    UserProfile,
    ['bio', 'birthday', 'gender'] as const,
    InputType,
  )
  implements
    Pick<
      Prisma.UserProfileUncheckedUpdateInput,
      'bio' | 'birthday' | 'gender'
    > {}
