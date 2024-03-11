// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Performer _$PerformerFromJson(Map<String, dynamic> json) => Performer(
      id: json['id'] as int,
      userFirstName: json['userFirstName'] as String?,
      userLastName: json['userLastName'] as String?,
    );

Map<String, dynamic> _$PerformerToJson(Performer instance) => <String, dynamic>{
      'id': instance.id,
      'userFirstName': instance.userFirstName,
      'userLastName': instance.userLastName,
    };
