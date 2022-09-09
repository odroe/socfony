// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prisma_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AggregateUser _$AggregateUserFromJson(Map<String, dynamic> json) =>
    AggregateUser(
      $avg: json['_avg'] == null
          ? null
          : UserAvgAggregateOutputType.fromJson(
              json['_avg'] as Map<String, dynamic>),
      $sum: json['_sum'] == null
          ? null
          : UserSumAggregateOutputType.fromJson(
              json['_sum'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : UserMinAggregateOutputType.fromJson(
              json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : UserMaxAggregateOutputType.fromJson(
              json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AggregateUserToJson(AggregateUser instance) =>
    <String, dynamic>{
      '_avg': instance.$avg?.toJson(),
      '_sum': instance.$sum?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

UserGroupByOutputType _$UserGroupByOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserGroupByOutputType(
      id: json['id'] as String,
      phone: json['phone'] as String,
      name: json['name'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String?,
      birthday: json['birthday'] as int?,
      registeredAt: DateTime.parse(json['registeredAt'] as String),
      $avg: json['_avg'] == null
          ? null
          : UserAvgAggregateOutputType.fromJson(
              json['_avg'] as Map<String, dynamic>),
      $sum: json['_sum'] == null
          ? null
          : UserSumAggregateOutputType.fromJson(
              json['_sum'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : UserMinAggregateOutputType.fromJson(
              json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : UserMaxAggregateOutputType.fromJson(
              json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserGroupByOutputTypeToJson(
        UserGroupByOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'name': instance.name,
      'gender': _$GenderEnumMap[instance.gender],
      'avatar': instance.avatar,
      'bio': instance.bio,
      'birthday': instance.birthday,
      'registeredAt': instance.registeredAt.toIso8601String(),
      '_avg': instance.$avg?.toJson(),
      '_sum': instance.$sum?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

const _$GenderEnumMap = {
  Gender.woman: 'woman',
  Gender.man: 'man',
  Gender.unknown: 'unknown',
};

AggregateAccessToken _$AggregateAccessTokenFromJson(
        Map<String, dynamic> json) =>
    AggregateAccessToken(
      $min: json['_min'] == null
          ? null
          : AccessTokenMinAggregateOutputType.fromJson(
              json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : AccessTokenMaxAggregateOutputType.fromJson(
              json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AggregateAccessTokenToJson(
        AggregateAccessToken instance) =>
    <String, dynamic>{
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

AccessTokenGroupByOutputType _$AccessTokenGroupByOutputTypeFromJson(
        Map<String, dynamic> json) =>
    AccessTokenGroupByOutputType(
      token: json['token'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      expiredAt: DateTime.parse(json['expiredAt'] as String),
      refreshExpiredAt: DateTime.parse(json['refreshExpiredAt'] as String),
      ownerId: json['ownerId'] as String,
      $min: json['_min'] == null
          ? null
          : AccessTokenMinAggregateOutputType.fromJson(
              json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : AccessTokenMaxAggregateOutputType.fromJson(
              json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccessTokenGroupByOutputTypeToJson(
        AccessTokenGroupByOutputType instance) =>
    <String, dynamic>{
      'token': instance.token,
      'createdAt': instance.createdAt.toIso8601String(),
      'expiredAt': instance.expiredAt.toIso8601String(),
      'refreshExpiredAt': instance.refreshExpiredAt.toIso8601String(),
      'ownerId': instance.ownerId,
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

AggregateOneTimePassword _$AggregateOneTimePasswordFromJson(
        Map<String, dynamic> json) =>
    AggregateOneTimePassword(
      $min: json['_min'] == null
          ? null
          : OneTimePasswordMinAggregateOutputType.fromJson(
              json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : OneTimePasswordMaxAggregateOutputType.fromJson(
              json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AggregateOneTimePasswordToJson(
        AggregateOneTimePassword instance) =>
    <String, dynamic>{
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

OneTimePasswordGroupByOutputType _$OneTimePasswordGroupByOutputTypeFromJson(
        Map<String, dynamic> json) =>
    OneTimePasswordGroupByOutputType(
      secret: json['secret'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      expiredAt: DateTime.parse(json['expiredAt'] as String),
      $min: json['_min'] == null
          ? null
          : OneTimePasswordMinAggregateOutputType.fromJson(
              json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : OneTimePasswordMaxAggregateOutputType.fromJson(
              json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OneTimePasswordGroupByOutputTypeToJson(
        OneTimePasswordGroupByOutputType instance) =>
    <String, dynamic>{
      'secret': instance.secret,
      'phone': instance.phone,
      'password': instance.password,
      'createdAt': instance.createdAt.toIso8601String(),
      'expiredAt': instance.expiredAt.toIso8601String(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

AggregateMoment _$AggregateMomentFromJson(Map<String, dynamic> json) =>
    AggregateMoment(
      $avg: json['_avg'] == null
          ? null
          : MomentAvgAggregateOutputType.fromJson(
              json['_avg'] as Map<String, dynamic>),
      $sum: json['_sum'] == null
          ? null
          : MomentSumAggregateOutputType.fromJson(
              json['_sum'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : MomentMinAggregateOutputType.fromJson(
              json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : MomentMaxAggregateOutputType.fromJson(
              json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AggregateMomentToJson(AggregateMoment instance) =>
    <String, dynamic>{
      '_avg': instance.$avg?.toJson(),
      '_sum': instance.$sum?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

MomentGroupByOutputType _$MomentGroupByOutputTypeFromJson(
        Map<String, dynamic> json) =>
    MomentGroupByOutputType(
      id: json['id'] as String,
      title: json['title'] as String?,
      contents: json['contents'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      favoritesCount: json['favoritesCount'] as int,
      commentsCount: json['commentsCount'] as int,
      authorId: json['authorId'] as String,
      $avg: json['_avg'] == null
          ? null
          : MomentAvgAggregateOutputType.fromJson(
              json['_avg'] as Map<String, dynamic>),
      $sum: json['_sum'] == null
          ? null
          : MomentSumAggregateOutputType.fromJson(
              json['_sum'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : MomentMinAggregateOutputType.fromJson(
              json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : MomentMaxAggregateOutputType.fromJson(
              json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MomentGroupByOutputTypeToJson(
        MomentGroupByOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'contents': instance.contents,
      'images': instance.images,
      'createdAt': instance.createdAt.toIso8601String(),
      'favoritesCount': instance.favoritesCount,
      'commentsCount': instance.commentsCount,
      'authorId': instance.authorId,
      '_avg': instance.$avg?.toJson(),
      '_sum': instance.$sum?.toJson(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

AggregateUserFavoriteMoment _$AggregateUserFavoriteMomentFromJson(
        Map<String, dynamic> json) =>
    AggregateUserFavoriteMoment(
      $min: json['_min'] == null
          ? null
          : UserFavoriteMomentMinAggregateOutputType.fromJson(
              json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : UserFavoriteMomentMaxAggregateOutputType.fromJson(
              json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AggregateUserFavoriteMomentToJson(
        AggregateUserFavoriteMoment instance) =>
    <String, dynamic>{
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

UserFavoriteMomentGroupByOutputType
    _$UserFavoriteMomentGroupByOutputTypeFromJson(Map<String, dynamic> json) =>
        UserFavoriteMomentGroupByOutputType(
          userId: json['userId'] as String,
          momentId: json['momentId'] as String,
          favoriteAt: DateTime.parse(json['favoriteAt'] as String),
          $min: json['_min'] == null
              ? null
              : UserFavoriteMomentMinAggregateOutputType.fromJson(
                  json['_min'] as Map<String, dynamic>),
          $max: json['_max'] == null
              ? null
              : UserFavoriteMomentMaxAggregateOutputType.fromJson(
                  json['_max'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$UserFavoriteMomentGroupByOutputTypeToJson(
        UserFavoriteMomentGroupByOutputType instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'momentId': instance.momentId,
      'favoriteAt': instance.favoriteAt.toIso8601String(),
      '_min': instance.$min?.toJson(),
      '_max': instance.$max?.toJson(),
    };

AffectedRowsOutput _$AffectedRowsOutputFromJson(Map<String, dynamic> json) =>
    AffectedRowsOutput(
      count: json['count'] as int,
    );

Map<String, dynamic> _$AffectedRowsOutputToJson(AffectedRowsOutput instance) =>
    <String, dynamic>{
      'count': instance.count,
    };

UserCountOutputType _$UserCountOutputTypeFromJson(Map<String, dynamic> json) =>
    UserCountOutputType(
      accessTokens: json['accessTokens'] as int,
      publishedMoments: json['publishedMoments'] as int,
      favoritedMoments: json['favoritedMoments'] as int,
    );

Map<String, dynamic> _$UserCountOutputTypeToJson(
        UserCountOutputType instance) =>
    <String, dynamic>{
      'accessTokens': instance.accessTokens,
      'publishedMoments': instance.publishedMoments,
      'favoritedMoments': instance.favoritedMoments,
    };

UserCountAggregateOutputType _$UserCountAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserCountAggregateOutputType(
      id: json['id'] as int,
      phone: json['phone'] as int,
      name: json['name'] as int,
      gender: json['gender'] as int,
      avatar: json['avatar'] as int,
      bio: json['bio'] as int,
      birthday: json['birthday'] as int,
      registeredAt: json['registeredAt'] as int,
      $all: json['_all'] as int,
    );

Map<String, dynamic> _$UserCountAggregateOutputTypeToJson(
        UserCountAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'name': instance.name,
      'gender': instance.gender,
      'avatar': instance.avatar,
      'bio': instance.bio,
      'birthday': instance.birthday,
      'registeredAt': instance.registeredAt,
      '_all': instance.$all,
    };

UserAvgAggregateOutputType _$UserAvgAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserAvgAggregateOutputType(
      birthday: (json['birthday'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserAvgAggregateOutputTypeToJson(
        UserAvgAggregateOutputType instance) =>
    <String, dynamic>{
      'birthday': instance.birthday,
    };

UserSumAggregateOutputType _$UserSumAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserSumAggregateOutputType(
      birthday: json['birthday'] as int?,
    );

Map<String, dynamic> _$UserSumAggregateOutputTypeToJson(
        UserSumAggregateOutputType instance) =>
    <String, dynamic>{
      'birthday': instance.birthday,
    };

UserMinAggregateOutputType _$UserMinAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserMinAggregateOutputType(
      id: json['id'] as String?,
      phone: json['phone'] as String?,
      name: json['name'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String?,
      birthday: json['birthday'] as int?,
      registeredAt: json['registeredAt'] == null
          ? null
          : DateTime.parse(json['registeredAt'] as String),
    );

Map<String, dynamic> _$UserMinAggregateOutputTypeToJson(
        UserMinAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'name': instance.name,
      'gender': _$GenderEnumMap[instance.gender],
      'avatar': instance.avatar,
      'bio': instance.bio,
      'birthday': instance.birthday,
      'registeredAt': instance.registeredAt?.toIso8601String(),
    };

UserMaxAggregateOutputType _$UserMaxAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    UserMaxAggregateOutputType(
      id: json['id'] as String?,
      phone: json['phone'] as String?,
      name: json['name'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String?,
      birthday: json['birthday'] as int?,
      registeredAt: json['registeredAt'] == null
          ? null
          : DateTime.parse(json['registeredAt'] as String),
    );

Map<String, dynamic> _$UserMaxAggregateOutputTypeToJson(
        UserMaxAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'name': instance.name,
      'gender': _$GenderEnumMap[instance.gender],
      'avatar': instance.avatar,
      'bio': instance.bio,
      'birthday': instance.birthday,
      'registeredAt': instance.registeredAt?.toIso8601String(),
    };

AccessTokenCountAggregateOutputType
    _$AccessTokenCountAggregateOutputTypeFromJson(Map<String, dynamic> json) =>
        AccessTokenCountAggregateOutputType(
          token: json['token'] as int,
          createdAt: json['createdAt'] as int,
          expiredAt: json['expiredAt'] as int,
          refreshExpiredAt: json['refreshExpiredAt'] as int,
          ownerId: json['ownerId'] as int,
          $all: json['_all'] as int,
        );

Map<String, dynamic> _$AccessTokenCountAggregateOutputTypeToJson(
        AccessTokenCountAggregateOutputType instance) =>
    <String, dynamic>{
      'token': instance.token,
      'createdAt': instance.createdAt,
      'expiredAt': instance.expiredAt,
      'refreshExpiredAt': instance.refreshExpiredAt,
      'ownerId': instance.ownerId,
      '_all': instance.$all,
    };

AccessTokenMinAggregateOutputType _$AccessTokenMinAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    AccessTokenMinAggregateOutputType(
      token: json['token'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      expiredAt: json['expiredAt'] == null
          ? null
          : DateTime.parse(json['expiredAt'] as String),
      refreshExpiredAt: json['refreshExpiredAt'] == null
          ? null
          : DateTime.parse(json['refreshExpiredAt'] as String),
      ownerId: json['ownerId'] as String?,
    );

Map<String, dynamic> _$AccessTokenMinAggregateOutputTypeToJson(
        AccessTokenMinAggregateOutputType instance) =>
    <String, dynamic>{
      'token': instance.token,
      'createdAt': instance.createdAt?.toIso8601String(),
      'expiredAt': instance.expiredAt?.toIso8601String(),
      'refreshExpiredAt': instance.refreshExpiredAt?.toIso8601String(),
      'ownerId': instance.ownerId,
    };

AccessTokenMaxAggregateOutputType _$AccessTokenMaxAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    AccessTokenMaxAggregateOutputType(
      token: json['token'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      expiredAt: json['expiredAt'] == null
          ? null
          : DateTime.parse(json['expiredAt'] as String),
      refreshExpiredAt: json['refreshExpiredAt'] == null
          ? null
          : DateTime.parse(json['refreshExpiredAt'] as String),
      ownerId: json['ownerId'] as String?,
    );

Map<String, dynamic> _$AccessTokenMaxAggregateOutputTypeToJson(
        AccessTokenMaxAggregateOutputType instance) =>
    <String, dynamic>{
      'token': instance.token,
      'createdAt': instance.createdAt?.toIso8601String(),
      'expiredAt': instance.expiredAt?.toIso8601String(),
      'refreshExpiredAt': instance.refreshExpiredAt?.toIso8601String(),
      'ownerId': instance.ownerId,
    };

OneTimePasswordCountAggregateOutputType
    _$OneTimePasswordCountAggregateOutputTypeFromJson(
            Map<String, dynamic> json) =>
        OneTimePasswordCountAggregateOutputType(
          secret: json['secret'] as int,
          phone: json['phone'] as int,
          password: json['password'] as int,
          createdAt: json['createdAt'] as int,
          expiredAt: json['expiredAt'] as int,
          $all: json['_all'] as int,
        );

Map<String, dynamic> _$OneTimePasswordCountAggregateOutputTypeToJson(
        OneTimePasswordCountAggregateOutputType instance) =>
    <String, dynamic>{
      'secret': instance.secret,
      'phone': instance.phone,
      'password': instance.password,
      'createdAt': instance.createdAt,
      'expiredAt': instance.expiredAt,
      '_all': instance.$all,
    };

OneTimePasswordMinAggregateOutputType
    _$OneTimePasswordMinAggregateOutputTypeFromJson(
            Map<String, dynamic> json) =>
        OneTimePasswordMinAggregateOutputType(
          secret: json['secret'] as String?,
          phone: json['phone'] as String?,
          password: json['password'] as String?,
          createdAt: json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
          expiredAt: json['expiredAt'] == null
              ? null
              : DateTime.parse(json['expiredAt'] as String),
        );

Map<String, dynamic> _$OneTimePasswordMinAggregateOutputTypeToJson(
        OneTimePasswordMinAggregateOutputType instance) =>
    <String, dynamic>{
      'secret': instance.secret,
      'phone': instance.phone,
      'password': instance.password,
      'createdAt': instance.createdAt?.toIso8601String(),
      'expiredAt': instance.expiredAt?.toIso8601String(),
    };

OneTimePasswordMaxAggregateOutputType
    _$OneTimePasswordMaxAggregateOutputTypeFromJson(
            Map<String, dynamic> json) =>
        OneTimePasswordMaxAggregateOutputType(
          secret: json['secret'] as String?,
          phone: json['phone'] as String?,
          password: json['password'] as String?,
          createdAt: json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
          expiredAt: json['expiredAt'] == null
              ? null
              : DateTime.parse(json['expiredAt'] as String),
        );

Map<String, dynamic> _$OneTimePasswordMaxAggregateOutputTypeToJson(
        OneTimePasswordMaxAggregateOutputType instance) =>
    <String, dynamic>{
      'secret': instance.secret,
      'phone': instance.phone,
      'password': instance.password,
      'createdAt': instance.createdAt?.toIso8601String(),
      'expiredAt': instance.expiredAt?.toIso8601String(),
    };

MomentCountOutputType _$MomentCountOutputTypeFromJson(
        Map<String, dynamic> json) =>
    MomentCountOutputType(
      favorites: json['favorites'] as int,
    );

Map<String, dynamic> _$MomentCountOutputTypeToJson(
        MomentCountOutputType instance) =>
    <String, dynamic>{
      'favorites': instance.favorites,
    };

MomentCountAggregateOutputType _$MomentCountAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    MomentCountAggregateOutputType(
      id: json['id'] as int,
      title: json['title'] as int,
      contents: json['contents'] as int,
      images: json['images'] as int,
      createdAt: json['createdAt'] as int,
      favoritesCount: json['favoritesCount'] as int,
      commentsCount: json['commentsCount'] as int,
      authorId: json['authorId'] as int,
      $all: json['_all'] as int,
    );

Map<String, dynamic> _$MomentCountAggregateOutputTypeToJson(
        MomentCountAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'contents': instance.contents,
      'images': instance.images,
      'createdAt': instance.createdAt,
      'favoritesCount': instance.favoritesCount,
      'commentsCount': instance.commentsCount,
      'authorId': instance.authorId,
      '_all': instance.$all,
    };

MomentAvgAggregateOutputType _$MomentAvgAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    MomentAvgAggregateOutputType(
      favoritesCount: (json['favoritesCount'] as num?)?.toDouble(),
      commentsCount: (json['commentsCount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MomentAvgAggregateOutputTypeToJson(
        MomentAvgAggregateOutputType instance) =>
    <String, dynamic>{
      'favoritesCount': instance.favoritesCount,
      'commentsCount': instance.commentsCount,
    };

MomentSumAggregateOutputType _$MomentSumAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    MomentSumAggregateOutputType(
      favoritesCount: json['favoritesCount'] as int?,
      commentsCount: json['commentsCount'] as int?,
    );

Map<String, dynamic> _$MomentSumAggregateOutputTypeToJson(
        MomentSumAggregateOutputType instance) =>
    <String, dynamic>{
      'favoritesCount': instance.favoritesCount,
      'commentsCount': instance.commentsCount,
    };

MomentMinAggregateOutputType _$MomentMinAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    MomentMinAggregateOutputType(
      id: json['id'] as String?,
      title: json['title'] as String?,
      contents: json['contents'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      favoritesCount: json['favoritesCount'] as int?,
      commentsCount: json['commentsCount'] as int?,
      authorId: json['authorId'] as String?,
    );

Map<String, dynamic> _$MomentMinAggregateOutputTypeToJson(
        MomentMinAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'contents': instance.contents,
      'createdAt': instance.createdAt?.toIso8601String(),
      'favoritesCount': instance.favoritesCount,
      'commentsCount': instance.commentsCount,
      'authorId': instance.authorId,
    };

MomentMaxAggregateOutputType _$MomentMaxAggregateOutputTypeFromJson(
        Map<String, dynamic> json) =>
    MomentMaxAggregateOutputType(
      id: json['id'] as String?,
      title: json['title'] as String?,
      contents: json['contents'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      favoritesCount: json['favoritesCount'] as int?,
      commentsCount: json['commentsCount'] as int?,
      authorId: json['authorId'] as String?,
    );

Map<String, dynamic> _$MomentMaxAggregateOutputTypeToJson(
        MomentMaxAggregateOutputType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'contents': instance.contents,
      'createdAt': instance.createdAt?.toIso8601String(),
      'favoritesCount': instance.favoritesCount,
      'commentsCount': instance.commentsCount,
      'authorId': instance.authorId,
    };

UserFavoriteMomentCountAggregateOutputType
    _$UserFavoriteMomentCountAggregateOutputTypeFromJson(
            Map<String, dynamic> json) =>
        UserFavoriteMomentCountAggregateOutputType(
          userId: json['userId'] as int,
          momentId: json['momentId'] as int,
          favoriteAt: json['favoriteAt'] as int,
          $all: json['_all'] as int,
        );

Map<String, dynamic> _$UserFavoriteMomentCountAggregateOutputTypeToJson(
        UserFavoriteMomentCountAggregateOutputType instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'momentId': instance.momentId,
      'favoriteAt': instance.favoriteAt,
      '_all': instance.$all,
    };

UserFavoriteMomentMinAggregateOutputType
    _$UserFavoriteMomentMinAggregateOutputTypeFromJson(
            Map<String, dynamic> json) =>
        UserFavoriteMomentMinAggregateOutputType(
          userId: json['userId'] as String?,
          momentId: json['momentId'] as String?,
          favoriteAt: json['favoriteAt'] == null
              ? null
              : DateTime.parse(json['favoriteAt'] as String),
        );

Map<String, dynamic> _$UserFavoriteMomentMinAggregateOutputTypeToJson(
        UserFavoriteMomentMinAggregateOutputType instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'momentId': instance.momentId,
      'favoriteAt': instance.favoriteAt?.toIso8601String(),
    };

UserFavoriteMomentMaxAggregateOutputType
    _$UserFavoriteMomentMaxAggregateOutputTypeFromJson(
            Map<String, dynamic> json) =>
        UserFavoriteMomentMaxAggregateOutputType(
          userId: json['userId'] as String?,
          momentId: json['momentId'] as String?,
          favoriteAt: json['favoriteAt'] == null
              ? null
              : DateTime.parse(json['favoriteAt'] as String),
        );

Map<String, dynamic> _$UserFavoriteMomentMaxAggregateOutputTypeToJson(
        UserFavoriteMomentMaxAggregateOutputType instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'momentId': instance.momentId,
      'favoriteAt': instance.favoriteAt?.toIso8601String(),
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      phone: json['phone'] as String,
      name: json['name'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String?,
      birthday: json['birthday'] as int?,
      registeredAt: DateTime.parse(json['registeredAt'] as String),
      accessTokens: (json['accessTokens'] as List<dynamic>?)
          ?.map((e) => AccessToken.fromJson(e as Map<String, dynamic>))
          .toList(),
      publishedMoments: (json['publishedMoments'] as List<dynamic>?)
          ?.map((e) => Moment.fromJson(e as Map<String, dynamic>))
          .toList(),
      favoritedMoments: (json['favoritedMoments'] as List<dynamic>?)
          ?.map((e) => UserFavoriteMoment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'name': instance.name,
      'gender': _$GenderEnumMap[instance.gender],
      'avatar': instance.avatar,
      'bio': instance.bio,
      'birthday': instance.birthday,
      'registeredAt': instance.registeredAt.toIso8601String(),
      'accessTokens': instance.accessTokens?.map((e) => e.toJson()).toList(),
      'publishedMoments':
          instance.publishedMoments?.map((e) => e.toJson()).toList(),
      'favoritedMoments':
          instance.favoritedMoments?.map((e) => e.toJson()).toList(),
    };

AccessToken _$AccessTokenFromJson(Map<String, dynamic> json) => AccessToken(
      token: json['token'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      expiredAt: DateTime.parse(json['expiredAt'] as String),
      refreshExpiredAt: DateTime.parse(json['refreshExpiredAt'] as String),
      ownerId: json['ownerId'] as String,
      owner: json['owner'] == null
          ? null
          : User.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccessTokenToJson(AccessToken instance) =>
    <String, dynamic>{
      'token': instance.token,
      'createdAt': instance.createdAt.toIso8601String(),
      'expiredAt': instance.expiredAt.toIso8601String(),
      'refreshExpiredAt': instance.refreshExpiredAt.toIso8601String(),
      'ownerId': instance.ownerId,
      'owner': instance.owner?.toJson(),
    };

OneTimePassword _$OneTimePasswordFromJson(Map<String, dynamic> json) =>
    OneTimePassword(
      secret: json['secret'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      expiredAt: DateTime.parse(json['expiredAt'] as String),
    );

Map<String, dynamic> _$OneTimePasswordToJson(OneTimePassword instance) =>
    <String, dynamic>{
      'secret': instance.secret,
      'phone': instance.phone,
      'password': instance.password,
      'createdAt': instance.createdAt.toIso8601String(),
      'expiredAt': instance.expiredAt.toIso8601String(),
    };

Moment _$MomentFromJson(Map<String, dynamic> json) => Moment(
      id: json['id'] as String,
      title: json['title'] as String?,
      contents: json['contents'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      favoritesCount: json['favoritesCount'] as int,
      commentsCount: json['commentsCount'] as int,
      authorId: json['authorId'] as String,
      author: json['author'] == null
          ? null
          : User.fromJson(json['author'] as Map<String, dynamic>),
      favorites: (json['favorites'] as List<dynamic>?)
          ?.map((e) => UserFavoriteMoment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MomentToJson(Moment instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'contents': instance.contents,
      'images': instance.images,
      'createdAt': instance.createdAt.toIso8601String(),
      'favoritesCount': instance.favoritesCount,
      'commentsCount': instance.commentsCount,
      'authorId': instance.authorId,
      'author': instance.author?.toJson(),
      'favorites': instance.favorites?.map((e) => e.toJson()).toList(),
    };

UserFavoriteMoment _$UserFavoriteMomentFromJson(Map<String, dynamic> json) =>
    UserFavoriteMoment(
      userId: json['userId'] as String,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      momentId: json['momentId'] as String,
      moment: json['moment'] == null
          ? null
          : Moment.fromJson(json['moment'] as Map<String, dynamic>),
      favoriteAt: DateTime.parse(json['favoriteAt'] as String),
    );

Map<String, dynamic> _$UserFavoriteMomentToJson(UserFavoriteMoment instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'user': instance.user?.toJson(),
      'momentId': instance.momentId,
      'moment': instance.moment?.toJson(),
      'favoriteAt': instance.favoriteAt.toIso8601String(),
    };
