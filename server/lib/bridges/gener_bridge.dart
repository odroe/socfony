import 'package:socfonyapis/socfonyapis.dart' as socfonyapis;

import '../prisma/prisma_client.dart' as prisma;

extension ModelGenderBridge on prisma.Gender {
  /// Convert to gRPC message.
  socfonyapis.Gender toGrpcMessage() {
    switch (this) {
      case prisma.Gender.woman:
        return socfonyapis.Gender.woman;
      case prisma.Gender.man:
        return socfonyapis.Gender.man;
      case prisma.Gender.unknown:
      default:
        return socfonyapis.Gender.unknown;
    }
  }
}

extension GrpcGenderBridge on socfonyapis.Gender {
  /// Convert to model enum.
  prisma.Gender toModel() {
    switch (this) {
      case socfonyapis.Gender.man:
        return prisma.Gender.man;
      case socfonyapis.Gender.woman:
        return prisma.Gender.woman;
      case socfonyapis.Gender.unknown:
      default:
        return prisma.Gender.unknown;
    }
  }
}
