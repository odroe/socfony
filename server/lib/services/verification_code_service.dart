import 'package:grpc/grpc.dart';
import 'package:mysql1/mysql1.dart';
import 'package:proto/google/protobuf/wrappers.pb.dart';
import 'package:proto/google/protobuf/empty.pb.dart';
import 'package:proto/socfony.pbgrpc.dart';
import 'package:server/database/database.dart';

class VerificationCodeService extends VerificationCodeServiceBase {
  @override
  Future<Empty> send(ServiceCall call, StringValue request) async {
    final String phone = request.value;
    final MySqlConnection connection = await getDatabaseConnection();

    connection.query(
        'SELECT * FROM users WHERE phone = ?', [phone]);

    return Empty();
  }

  @override
  Future<Empty> sendByAuthenticatedUser(ServiceCall call, Empty request) {
    // TODO: implement sendByAuthenticatedUser
    throw UnimplementedError();
  }
}
