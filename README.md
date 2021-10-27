<img align="right" width="120px" src="graphs/socfony.png" alt="Socfony Logo">

# Socfony

<div align="center">
    <a href="https://github.com/odroe/socfony">GitHub</a>
    <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
    <a href="https://gitlab.com/odroe/socfony">GitLab</a>
    <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
    <a href="https://gitee.com/odroe/socfony">Gitee</a>
</div>

Socfony is an open source social application, and basic security modules and social function modules have been preset in the software. Whether it is to deploy Socfony directly or as a basis for program development is wonderful.

- [**Socfony Server**](https://github.com/odroe/socfony) - Socfony server gRPC service.
- [**Socfony App**](https://github.com/odroe/socfony-app) - Socfony application.

Socfony server adopts Node.js runtime environment, TypeScript language and Nest.js framework to develop gRPC API.

Socfony App uses the Flutter framework for cross-platform development

## Reamap

Socfony is currently in the early development stage. For more development content, please visit [Projects page](https://github.com/odroe/socfony/projects).

## Get Started

| Step | Code                                                       | Description                     |
| :--: | ---------------------------------------------------------- | ------------------------------- |
|  1   | `git clone https://github.com/odroe/socfony && cd socfony` | Clone the project               |
|  2   | `npm install`                                              | Install dependencies            |
|  3   | `npm run protobuf`                                         | Generate protobuf files         |
|  4   | Copy the `.env.example` file to `.env`                     | Configure environment variables |
|  5   | `npx prisma db push`                                       | Create database                 |
|  6   | `npm run serve`                                            | Run server                      |

## Documentation

TODO

## License

BSD 3-Clause License.

Copyright (c) 2021, [Odroe Inc.](https://odroe.com) All rights reserved.
