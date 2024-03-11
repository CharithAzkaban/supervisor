// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      floorId: json['floorId'] as int?,
      genderId: json['genderId'] as int?,
      washroomId: json['washroomId'] as int?,
      tasks: (json['tasks'] as List<dynamic>?)
          ?.map((e) => TaskType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'floorId': instance.floorId,
      'genderId': instance.genderId,
      'washroomId': instance.washroomId,
      'tasks': instance.tasks,
    };
