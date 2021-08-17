# Socfony

Socfony is an open source social application, and basic security modules and social function modules have been preset in the software. Whether it is to deploy Socfony directly or as a basis for program development is wonderful.

## Features

- **Open Source** - Socfony is open source
- **Security** - Open source code means being supervised by the public
- **GraphQL** - GraphQL is a query language for APIs and a runtime for fulfilling those queries with your existing data.

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
    DATABASE_URL="mysql://socfony:socfony@localhost:3306/socfony"
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

Copyright (c) 2021, [Sichuan Odroe Tec Ltd.](https://odroe.com)
All rights reserved.
