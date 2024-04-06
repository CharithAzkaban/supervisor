// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskCount _$TaskCountFromJson(Map<String, dynamic> json) => TaskCount(
      pending_status: json['pending_status'] as int,
      todo_status: json['todo_status'] as int,
      performer_completed_status: json['performer_completed_status'] as int,
      supervisor_completed: json['supervisor_completed'] as int,
      rejected_status: json['rejected_status'] as int,
    );

Map<String, dynamic> _$TaskCountToJson(TaskCount instance) => <String, dynamic>{
      'pending_status': instance.pending_status,
      'todo_status': instance.todo_status,
      'performer_completed_status': instance.performer_completed_status,
      'supervisor_completed': instance.supervisor_completed,
      'rejected_status': instance.rejected_status,
    };
