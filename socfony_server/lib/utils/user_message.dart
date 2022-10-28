import 'package:socfonyapis/socfonyapis.dart';

import '../prisma.dart' as prisma;

/// Prisma user model to gRPC user message
Future<User> convertPrismaToUser(prisma.User user) async {
  final prisma.UserProfile profile = await _findOrCreateUserProfile(user.id);

  return User(
    id: user.id,
    login: user.login,
    createdAt: Timestamp.fromDateTime(user.createdAt),
    updatedAt: Timestamp.fromDateTime(profile.updatedAt),
    bio: profile.bio,
    avatar: profile.avatar,
    birthday: profile.birthday,
    sex: convertPrismaToUserSex(profile.sex),
  );
}

/// Convert prisma user sex to gRPC user sex enum.
User_Sex convertPrismaToUserSex(prisma.UserSex sex) {
  return User_Sex.values.firstWhere(
    (element) => element.name.toLowerCase() == sex.name.toLowerCase(),
    orElse: () => User_Sex.unknown,
  );
}

/// Find or create user profile.
Future<prisma.UserProfile> _findOrCreateUserProfile(String userId) async {
  final prisma.UserProfile? profile = await prisma.client.userProfile
      .findUnique(where: prisma.UserProfileWhereUniqueInput(userId: userId));
  if (profile != null) return profile;

  return prisma.client.userProfile.create(
    data: prisma.UserProfileCreateInput(
      user: prisma.UserCreateNestedOneWithoutProfileInput(
        connect: prisma.UserWhereUniqueInput(id: userId),
      ),
    ),
  );
}
