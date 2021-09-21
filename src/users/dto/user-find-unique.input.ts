import { InputType, PartialType, PickType } from '@nestjs/graphql';
import { User } from '../entities/user.entity';

@InputType()
export class UserFindUniqueInput extends PickType(
  PartialType(User),
  <const>['id', 'name', 'email', 'phone'],
  InputType,
) {}
