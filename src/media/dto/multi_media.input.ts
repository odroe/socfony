import { Field, InputType, Int, registerEnumType } from '@nestjs/graphql';

enum MultiMediaItemType {
  IMAGE,
  VIDEO,
  AUDIO,
}

registerEnumType(MultiMediaItemType, {
  name: 'MultiMediaItemType',
});

export type MultiMediaTransfromReturn =
  | string
  | { audio: string; poster?: string }
  | { video: string; poster: string };

@InputType()
export class MultiMediaInput {
  @Field(() => String, { nullable: false })
  src?: string;

  @Field(() => String, { nullable: true })
  poster?: string;

  @Field(() => MultiMediaItemType, { nullable: false })
  type!: MultiMediaItemType;

  static transfrom(
    input?: MultiMediaInput,
  ): MultiMediaTransfromReturn | undefined {
    switch (input?.type) {
      case MultiMediaItemType.IMAGE:
        if (!input.src) {
          throw new Error('Image src is required');
        }
        return input.src;
      case MultiMediaItemType.AUDIO:
        if (!input.src) {
          throw new Error('Audio src is required');
        }
        const result = { audio: input.src } as {
          audio: string;
          poster?: string;
        };
        if (input.poster) {
          result.poster = input.poster;
        }

        return result;
      case MultiMediaItemType.VIDEO:
        if (!input.src || !input.poster) {
          throw new Error('Video src and poster are required');
        }
        return {
          video: input.src,
          poster: input.poster,
        };
    }

    return undefined;
  }

  static transfromArray(
    input?: MultiMediaInput[],
  ): MultiMediaTransfromReturn[] | undefined {
    if (!input) {
      return undefined;
    }

    return input
      .map<MultiMediaTransfromReturn>(
        (item) => MultiMediaInput.transfrom(item)!,
      )
      .filter((item) => !!item);
  }
}
