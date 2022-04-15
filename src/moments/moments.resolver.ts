import { Resolver, Query, Mutation, Args, Int } from '@nestjs/graphql';

import { Moment } from './entities/moment.entity';
import { CreateMomentInput } from './dto/create-moment.input';

@Resolver(() => Moment)
export class MomentsResolver {


  @Mutation(() => Moment)
  createMoment(@Args('createMomentInput') createMomentInput: CreateMomentInput) {}

  @Query(() => [Moment], { name: 'moments' })
  findMany() {

  }

  @Query(() => Moment, { name: 'moment' })
  findUnique(@Args('id', { type: () => Int }) id: number) {

  }

  @Mutation(() => Moment)
  removeMoment(@Args('id', { type: () => Int }) id: number) {
    
  }
}
