<a href="https://odroe.com">
    <img align="right" width="120px" src="graphs/socfony.png" alt="Socfony Logo">
</a>

# Socfony

<div align="center">
    <a href="https://github.com/odroe/socfony">GitHub</a>
    <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
    <a href="https://gitlab.com/odroe/socfony">GitLab</a>
    <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
    <a href="https://gitee.com/odroe/socfony">Gitee</a>
</div>

Socfony is an open source social application, and basic security modules and social function modules have been preset in the software. Whether it is to deploy Socfony directly or as a basis for program development is wonderful.

- [**Socfony Server**](server) - Socfony server gRPC service.
- [**Socfony App**](app) - Socfony application.

Socfony server adopts Node.js runtime environment, TypeScript language and Nest.js framework to develop gRPC API.

Socfony App uses the Flutter framework for cross-platform development

## Reamap

Socfony is currently in the early development stage. For more development content, please visit [Projects page](https://github.com/odroe/socfony/projects).

## Get Started

1. We now clone Socfony Git repository:

```bash
git clone https://github.com/odroe/socfony && cd socfony/server
```

2. Install Socfony dependencies:

```bash
npm install
```

3. Build Socfony protobuf files:

```bash
npm run protobuf
```

4. Configure environment variables:

```bash
export GRPC_LISTEN_ADDRESS=0.0.0.0:3000
export DATABASE_URL=mysql://root:password@localhost:3306/socfony
```

> **Note**: If it is troublesome to set environment variables every time you run, you can copy `.env.example` as the `.env` file and edit it for configuration.

5. Create database:

```bash
npx prisma db push
```

6. Run Socfony server:

```bash
npm run serve
```

## Documentation

TODO

## License

BSD 3-Clause License.

Copyright (c) 2021, [Odroe Inc.](https://odroe.com) All rights reserved.
