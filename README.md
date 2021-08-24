# Socfony

Socfony is an open source social application, and basic security modules and social function modules have been preset in the software. Whether it is to deploy Socfony directly or as a basis for program development is wonderful.

## Features

- **Open Source** - Socfony is open source
- **Security** - Open source code means being supervised by the public
- **GraphQL** - GraphQL is a query language for APIs and a runtime for fulfilling those queries with your existing data.

## TODO

Before the official version is released, we still have a lot of work to be done.

> If you follow our development progress, please visit [TODO](https://github.com/odroe/socfony/issues/128)

## Download

Use Git to clone the project:

```bash
git clone https://github.com/odroe/socfony
```

## Usage

1. Install Npm dependencies:
   ```bash
   npm install -ws
   ```
2. Edit database connection configuration in `.env` file:
   ```bash
   DATABASE_URL="mysql://[username]:[passwprd]@[address]:3306/socfony"
   ```
3. Configuration database table:
   ```bash
   npx prisma migrate deploy
   npm run start -w prisma/seeder
   ```
4. Run Client GraphQL API application:
   ```bash
   npm run start -w client-api
   ```

## Documentation

> TODO: Write documentation

## Contribution

Wecome to Pull Request. For major changes, please open an issue first.

## Community

Join the WeChat discussion group and communicate directly with developers or other Socfony users.

<img src="https://raw.githubusercontent.com/odroe/socfony/main/graph/join-wechat-qrcode.png" alt="Socfony WeChat Group" width="200" />

## License

BSD 3-Clause License.

Copyright (c) 2021, [Odroe, Inc.](https://odroe.com)
All rights reserved.
