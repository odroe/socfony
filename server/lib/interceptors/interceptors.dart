import 'package:grpc/grpc.dart';

import 'prisma_connector.dart';

/// gRPC interceptors.
const List<Interceptor> interceptors = <Interceptor>[prismaConnector];
