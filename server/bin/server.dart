import 'package:server/server.dart';

Future<void> main(List<String> args) async {
  await server.serve(port: 50051);
  print('Server listening on port ${server.port}...');
}
