import 'dart:io';

import 'package:args/args.dart';
import 'package:server/server.dart';

void main(List<String> arguments) async {
  final ArgParser parser = ArgParser()
    // Add help flag
    ..addFlag('help', abbr: 'h', help: '查看帮助信息')
    // port
    ..addOption('port', abbr: 'p', defaultsTo: '8080', help: "运行端口")
    // address
    ..addOption('address', abbr: 'a', defaultsTo: InternetAddress.anyIPv4.address, help: "运行地址")
    // Datebase URI
    ..addOption('database', abbr: 'd', help: "数据库地址")
  ;

  final ArgResults argResults = parser.parse(arguments);
  if (argResults['help']) {
    print(parser.usage);
    exit(0);
  }

  await server.serve(
    port: int.parse(argResults['port']),
    address: argResults['address'],
  );

  print('Server listening on ${argResults['address']}:${server.port}');
}
