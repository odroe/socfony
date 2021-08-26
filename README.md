# Socfony

Socfony is an open source social application, and basic security modules and social function modules have been preset in the software. Whether it is to deploy Socfony directly or as a basis for program development is wonderful.

## Features

- **Open Source** - Socfony is open source
- **Security** - Open source code means being supervised by the public
- **GraphQL** - GraphQL is a query language for APIs and a runtime for fulfilling those queries with your existing data.

## TODO

Before the official version is released, we still have a lot of work to be done.

> If you follow our development progress, please visit [TODO](https://github.com/odroe/socfony/issues/128)

## Mirrors

<a href="https://github.com/odroe/socfony">
   <img src="https://github.githubassets.com/pinned-octocat.svg" height="24" />
</a>
<a href="https://gitee.com/odroe/socfony">
   <img src="https://gitee.com/static/images/logo-en.svg" height="24" />
</a>
<a href="https://gitlab.com/odroe/socfony">
   <img src="https://about.gitlab.com/images/press/press-kit-icon.svg" height="24" />
</a>

## Download

Use Git to clone the project:

```bash
git clone https://github.com/odroe/socfony
```

- [Download the latest release](https://github.com/odroe/socfony/releases)
- [Download the latest development version ZIP](https://github.com/odroe/socfony/archive/refs/heads/main.zip)

## Usage

1. Install Npm dependencies:
   ```bash
   npm install
   ```
2. Edit database connection configuration in `.env` file:
   ```bash
   DATABASE_URL="mysql://[username]:[passwprd]@[address]:3306/socfony"
   ```
3. Configuration database table and seed data:
   ```bash
   npx prisma migrate deploy
   npm run start -w prisma/seeder
   ```
4. Run the client GraphQL API application:
   ```bash
   npm run start -w client-api
   ```

## Documentation

> TODO: Write documentation

## Code of Conduct

We as members, contributors, and leaders pledge to make participation in our community a harassment-free experience for everyone, regardless of age, body size, visible or invisible disability, ethnicity, sex characteristics, gender identity and expression, level of experience, education, socio-economic status, nationality, personal appearance, race, religion, or sexual identity and orientation.

We pledge to act and interact in ways that contribute to an open, welcoming, diverse, inclusive, and healthy community.

More read at [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)

## Contribution

Wecome to Pull Request. For major changes, please open an issue first.

## Community

Join the WeChat discussion group and communicate directly with developers or other Socfony users.

<img src="https://raw.githubusercontent.com/odroe/socfony/main/graph/join-wechat-qrcode.png" alt="Socfony WeChat Group" width="200" />

## License

BSD 3-Clause License.

Copyright (c) 2021, [Odroe, Inc.](https://odroe.com)
All rights reserved.
