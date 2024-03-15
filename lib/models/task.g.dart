// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as int,
      taskIssuedUserId: json['taskIssuedUserId'] as int,
      taskAssignedUserId: json['taskAssignedUserId'] as int,
      taskCategoryId: json['taskCategoryId'] as int,
      taskFloor: json['taskFloor'] as int,
      taskWashroom: json['taskWashroom'] as int,
      gender: json['gender'] as int,
      taskRate: json['taskRate'] as int,
      taskStatus: json['taskStatus'] as int,
      description: json['description'] as String?,
      supDescription: json['supDescription'] as String?,
      video: json['video'] as String?,
      supVideo: json['supVideo'] as String?,
      isActive: json['isActive'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      category: json['category'] as String,
      issuedFname: json['issuedFname'] as String,
      issuedLname: json['issuedLname'] as String,
      assignedFname: json['assignedFname'] as String,
      assignedLname: json['assignedLname'] as String,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'taskIssuedUserId': instance.taskIssuedUserId,
      'taskAssignedUserId': instance.taskAssignedUserId,
      'taskCategoryId': instance.taskCategoryId,
      'taskFloor': instance.taskFloor,
      'taskWashroom': instance.taskWashroom,
      'gender': instance.gender,
      'taskRate': instance.taskRate,
      'taskStatus': instance.taskStatus,
      'description': instance.description,
      'supDescription': instance.supDescription,
      'video': instance.video,
      'supVideo': instance.supVideo,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'category': instance.category,
      'issuedFname': instance.issuedFname,
      'issuedLname': instance.issuedLname,
      'assignedFname': instance.assignedFname,
      'assignedLname': instance.assignedLname,
    };
