import 'package:mysql1/mysql1.dart';

final _settings = ConnectionSettings(
  host: '127.0.0.1',
  port: 3306,
  user: 'root',
  db: 'socfony',
);

Future<MySqlConnection> mysql() async {
  return await MySqlConnection.connect(_settings);
}
