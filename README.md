Socfony 是一款完全开源的应用程序。程序中具有完备的社交功能，例如动态、圈子、好友、私信等。使用 Socfony 可以快速搭建一个社交 App，并且在此基础上添加功能也非常轻松。

## 快速开始

下载当前仓库代码:
```sh
git clone https://github.com/socfony/server
```

### 安装依赖

```sh
dart pub get
```

### 启动服务

```sh
dart run bin/server.dart
```

## 使用 Docker 运行

```sh
docker build . -t socfony
docker run -it -p 8080:8080 socfony
```

## 开发

如果你需要在程序中进行开发，并期望监听更改的文件，文件更改后自动重启服务。请使用下面命令：

```sh
dart run bin/dev.watch.dart
```
