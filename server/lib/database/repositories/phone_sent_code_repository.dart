import 'package:postgres/postgres.dart';

import '../connection.dart';
import '../models/phone_sent_code_model.dart';
import '_base_repository.dart';

class PhoneSentCodeRepository extends BaseRepository {
  const PhoneSentCodeRepository();

  /// Find a phone sent code.
  ///
  /// [phone] is the E.164 formated phone number.
  ///
  /// [connection] is the database connection.
  Future<PhoneSentCodeModel?> find(String phone,
      {PooledDatabaseConnection? connection}) async {
    final PooledDatabaseConnection conn = await getConnection(connection);
    final PostgreSQLResult result = await conn.query(
      'SELECT * FROM phone_sent_codes WHERE phone = @phone ORDER BY created_at DESC LIMIT 1',
      substitutionValues: {'phone': phone},
    );

    await conn.close();

    for (var element in result) {
      return PhoneSentCodeModel.fromJson(element.toColumnMap());
    }

    return null;
  }
}
