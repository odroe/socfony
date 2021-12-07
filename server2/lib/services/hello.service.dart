import 'package:grpc/grpc.dart';
import 'package:server2/src/database.dart';
import 'package:server2/src/protobuf/google/protobuf/wrappers.pb.dart';
import 'package:server2/src/protobuf/socfony.pbgrpc.dart';

class HelloService extends HelloServiceBase {
  @override
  Future<StringValue> sayHello(ServiceCall call, StringValue request) async {
    final database = await mysql();
    final results = await database.query(
      'SELECT * FROM User WHERE name = ? limit 1',
      ['socfony'],
    );
    final result = results.single.fields;

    print(result);

    final response = StringValue()..value = 'Hello ${request.value}';
    database.close();

    return response;
  }
}