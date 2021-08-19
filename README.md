# Socfony

Socfony is an open source social application, and basic security modules and social function modules have been preset in the software. Whether it is to deploy Socfony directly or as a basis for program development is wonderful.

## Features

- **Open Source** - Socfony is open source
- **Security** - Open source code means being supervised by the public
- **GraphQL** - GraphQL is a query language for APIs and a runtime for fulfilling those queries with your existing data.

## TODO

- [ ] Unit tests
- [ ] Documentation
- [ ] Docker
- [ ] Send validate SMS
- [ ] Register
- [ ] Update user's data
- [ ] Update user's password
- [ ] Update user's email
- [ ] Update user's phone
- [ ] Update user's avatar
- [ ] Tencent COS driver
- [ ] Moment create
- [ ] Like a moment
- [ ] Comment a moment
- [ ] Delete a moment
- [ ] Like a comment
- [ ] Delete a comment
- [ ] Follow a user
- [ ] Unfollow a user
- [ ] Notification
- [ ] User chat
- Community
  - [ ] Create a community
  - [ ] Join a community
  - [ ] Set a community's admin
  - [ ] Delete a community
  - [ ] Delete a community's admin
  - Category
    - [ ] Create a category
    - [ ] Delete a category
  - Discussion
    - [ ] Create a discussion
    - [ ] Delete a discussion
    - [ ] Comment a discussion
    - [ ] Delete a discussion's comment
    - [ ] Like a discussion

## Download

Use Git to clone the project:

```bash
git clone https://github.com/odroe/socfony
```

## Usage

1. Install Npm dependencies:
   ```bash
   npm install
   ```
2. Edit database connection configuration in `.env` file:
   ```bash
   DATABASE_URL="mysql://[username]:[passwprd]@[address]:3306/socfony"
   ```
3. Configuration database table:
   ```bash
   npx prisma db push
   ```
4. Run the application:
   ```bash
   npm run dev
   ```

## Documentation

> TODO: Write documentation

## Contribution

Wecome to Pull Request. For major changes, please open an issue first.

## Community

Join the WeChat discussion group and communicate directly with developers or other Socfony users.

<img src="https://raw.githubusercontent.com/odroe/socfony/main/graph/join-wechat-qrcode.png" alt="Socfony WeChat Group" width="200" />

## License

BSD 3-Clause License

Copyright (c) 2021, [Odroe, Inc.](https://odroe.com)
All rights reserved.
