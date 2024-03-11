// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      userTypeId: json['userTypeId'] as int?,
      userFirstName: json['userFirstName'] as String?,
      userLastName: json['userLastName'] as String?,
      userMobile: json['userMobile'] as String?,
      userEmail: json['userEmail'] as String?,
      userImage: json['userImage'] as String?,
      userBirthdate: json['userBirthdate'] == null
          ? null
          : DateTime.parse(json['userBirthdate'] as String),
      userAddress: json['userAddress'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'userTypeId': instance.userTypeId,
      'userFirstName': instance.userFirstName,
      'userLastName': instance.userLastName,
      'userMobile': instance.userMobile,
      'userEmail': instance.userEmail,
      'userImage': instance.userImage,
      'userBirthdate': instance.userBirthdate?.toIso8601String(),
      'userAddress': instance.userAddress,
    };
