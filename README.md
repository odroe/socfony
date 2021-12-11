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

Socfony 是一款**完全开源**的基础 App。程序中具有完备的社交功能，例如动态、圈子、好友、私信等。使用 Socfony 可以快速搭建一个社交 App，并且在此基础上添加功能也非常轻松。

- [**Socfony Server**](https://github.com/socfony/server) - Socfony 的 GraphQL 服务端
- [**Socfony App**](https://github.com/socfony/app) - Socfony 使用 Flutter 的 App 实现

## 发展路线

Socfony 目前处于早期开发阶段，更多的开发计划请访问 [Socfony RFCs](https://github.com/socfony/rfcs)

## 快速开始

克隆 Socfony 服务端代码：`git clone https://github.com/socfony/server`。

1. 安装依赖：
   ```bash
   npm install
   ```
2. 创建配置文件，将 `.env.example` 拷贝一份命名为 `.env`，并修改其中的 `DATABASE_URL`。
   ```bash
   DATABASE_URL="mysql://root@localhost:3306/socfony"
   # 查看所有数据库驱动连接选项：https://www.prisma.io/docs/reference/database-reference/connection-urls
   ```
3. 创建数据表结构：
   ```bash
   npx prisma db push
   ```
4. 运行：
   ```bash
   npm run start:dev
   ```

## 数据库

Socfony 使用 [Prisma ORM](https://prisma.io) 作为数据驱动，在默认的 Prisma Schema 中使用 MySQL 作为数据源，
你可以通过编辑 `prisma/schema.prisma` 文件来更改其他数据库支持。

当前支持的数据库:

- MySQL 5.7+ 或者 MariaDB
  ```prisma
  /// ...
  datasource db {
    provider = "mysql"
  }
  /// ...
  ```
- PostgreSQL
  ```prisma
  /// ...
  datasource db {
    provider = "postgresql"
  }
  /// ...
  ```

> 只有 MySQL 5.7 及更新版本和 PostgreSQL 支持 `json` 类型，或者使用 MariaDB 数据库。驱动选择 `mysql`。

## License

BSD 3-Clause License.

Copyright (c) 2021, [Odroe Inc.](https://odroe.com) All rights reserved.
