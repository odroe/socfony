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

    clear(conn);

    for (final PostgreSQLResultRow element in result) {
      return PhoneSentCodeModel.fromJson(element.toColumnMap());
    }

    return null;
  }

  /// Create a phone sent code.
  Future<PhoneSentCodeModel> create({
    required String phone,
    required String code,
    required DateTime expiredAt,
    PooledDatabaseConnection? connection,
  }) async {
    final PooledDatabaseConnection conn = await getConnection(connection);
    final PostgreSQLResult result = await conn.query(
      'INSERT INTO phone_sent_codes (phone, code, expired_at) VALUES (@phone, @code, @expired_at:timestamptz) RETURNING *',
      substitutionValues: {
        'phone': phone,
        'code': code,
        'expired_at': expiredAt,
      },
    );

    await conn.close();
    for (final PostgreSQLResultRow element in result) {
      return PhoneSentCodeModel.fromJson(element.toColumnMap());
    }

    throw Exception('Failed to create a phone sent code.');
  }

  /// Delete a phone sent code.
  Future<void> delete(PhoneSentCodeModel phoneSentCode,
      {PooledDatabaseConnection? connection}) async {
    final PooledDatabaseConnection conn = await getConnection(connection);

    /// Delete phone sent code.
    await conn.execute(
        'DELETE FROM phone_sent_codes WHERE phone = @phone AND code = @code',
        substitutionValues: {
          'phone': phoneSentCode.phone,
          'code': phoneSentCode.code,
        });

    /// Clean up.
    clear(conn);
  }

  /// Clean up all expired phone sent codes.
  Future<void> clear([PooledDatabaseConnection? connection]) async {
    final PooledDatabaseConnection conn = await getConnection(connection);
    await conn.execute(
      'DELETE FROM phone_sent_codes WHERE expired_at < NOW()',
    );
    await conn.close();
  }
}
