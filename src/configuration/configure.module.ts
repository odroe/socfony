import { ConfigFactoryKeyHost, ConfigModule } from '@nestjs/config';

type FlattenConfigOrigin = Record<string, ConfigFactoryKeyHost>;
function flatten(
  origin: FlattenConfigOrigin | Record<string, FlattenConfigOrigin>,
): any[] {
  return Object.values<ConfigFactoryKeyHost | FlattenConfigOrigin>(
    origin,
  ).reduce<ConfigFactoryKeyHost[]>((result, value) => {
    if (value.KEY) {
      return [...result, value];
    }

    return [...result, ...flatten(value as FlattenConfigOrigin)];
  }, []);
}

export const ConfigureModule = ConfigModule.forRoot({
  isGlobal: true,
  envFilePath: ['.env'],
  load: flatten(require('./config')),
});
