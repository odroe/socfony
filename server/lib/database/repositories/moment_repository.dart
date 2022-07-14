import 'package:betid/betid.dart';
import 'package:postgres/postgres.dart';

import '../connection.dart';
import '../models/moment_model.dart';
import '_base_repository.dart';

class MomentRepository extends BaseRepository {
  const MomentRepository();

  /// Create a moment
  Future<MomentModel> create({
    String? title,
    String? content,
    List<String>? images,
    required String userId,
    PooledDatabaseConnection? connection,
  }) async {
    /// content and images cannot both be empty
    assert((content?.isNotEmpty ?? false) || (images?.isNotEmpty ?? false));
    if ((content?.isEmpty ?? true) && (images?.isEmpty ?? true)) {
      throw ArgumentError('content and images cannot both be empty');
    }

    /// Get resolved connection
    final conn = await getConnection(connection);

    /// SQL set params
    final params = <String, dynamic>{
      'id': 64.betid,
      'userId': userId,
    };

    if (title != null && title.isNotEmpty) {
      params['title'] = title;
    }
    if (content != null && content.isNotEmpty) {
      params['content'] = content;
    }
    if (images != null && images.isNotEmpty) {
      params['images'] = images;
    }

    final PostgreSQLResult result = await conn.query(
      'INSERT INTO moments (id, userId, title, content, images) VALUES (@id, @userId, @title, @content, @images) RETURNING *',
      substitutionValues: params,
    );

    /// Get first row
    return MomentModel.fromJson(result.first.toColumnMap());
  }

  /// Find by id a moment.
  Future<MomentModel?> findById(String id,
      {PooledDatabaseConnection? connection}) async {
    /// Get resolved connection
    final PooledDatabaseConnection conn = await getConnection(connection);

    /// Query result in database.
    final PostgreSQLResult result = await conn.query(
      'SELECT * FROM moments WHERE id = @id LIMIT 1',
      substitutionValues: {'id': id},
    );

    /// Close connection.
    await conn.close();

    for (final PostgreSQLResultRow row in result) {
      return MomentModel.fromJson(row.toColumnMap());
    }

    return null;
  }

  /// Delete a moment.
  Future<void> delete(String id, {PooledDatabaseConnection? connection}) async {
    /// Get resolved connection
    final PooledDatabaseConnection conn = await getConnection(connection);

    /// Query result in database.
    final PostgreSQLResult result = await conn.query(
      'DELETE FROM moments WHERE id = @id',
      substitutionValues: {'id': id},
    );

    /// Close connection.
    await conn.close();
  }
}
