import 'package:mysql1/mysql1.dart';

final ConnectionSettings databaseOptions = ConnectionSettings(
  host: 'localhost',
  port: 3306,
  user: 'root',
  db: 'socfony',
);

Future<MySqlConnection> getDatabaseConnection() async => await MySqlConnection.connect(databaseOptions);
