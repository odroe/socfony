import 'package:socfonyapis/socfonyapis.dart' as socfonyapis;

import '../prisma/prisma_client.dart' as prisma;
import '../utils/phone_number.dart';
import 'gener_bridge.dart';

extension ModelUserBridge on prisma.User {
  /// Convert prisma user to gRPC user message.
  socfonyapis.User toGrpcMessage({bool hidePhone = true}) {
    final socfonyapis.User message = socfonyapis.User()
      ..id = id
      ..gender = gender?.toGrpcMessage() ?? socfonyapis.Gender.unknown
      ..registeredAt = socfonyapis.Timestamp.fromDateTime(registeredAt);

    if (!hidePhone) message.phone = PhoneNumber(phone).desensitization;
    if (name != null) message.name = name!;
    if (avatar != null) message.avatar = avatar!;
    if (bio != null) message.bio = bio!;
    if (birthday != null) message.birthday = birthday!;

    return message;
  }
}
