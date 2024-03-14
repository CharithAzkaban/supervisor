// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskType _$TaskTypeFromJson(Map<String, dynamic> json) => TaskType(
      id: json['id'] as int,
      taskTypeName: json['taskTypeName'] as String?,
    );

Map<String, dynamic> _$TaskTypeToJson(TaskType instance) => <String, dynamic>{
      'id': instance.id,
      'taskTypeName': instance.taskTypeName,
    };
