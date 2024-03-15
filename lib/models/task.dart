import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  final int id;
  final int taskIssuedUserId;
  final int taskAssignedUserId;
  final int taskCategoryId;
  final int taskFloor;
  final int taskWashroom;
  final int gender;
  final int taskRate;
  final int taskStatus;
  final String? description;
  final String? supDescription;
  final String? video;
  final String? supVideo;
  final int isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String category;
  final String issuedFname;
  final String issuedLname;
  final String assignedFname;
  final String assignedLname;

  Task({
    required this.id,
    required this.taskIssuedUserId,
    required this.taskAssignedUserId,
    required this.taskCategoryId,
    required this.taskFloor,
    required this.taskWashroom,
    required this.gender,
    required this.taskRate,
    required this.taskStatus,
    this.description,
    this.supDescription,
    this.video,
    this.supVideo,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.issuedFname,
    required this.issuedLname,
    required this.assignedFname,
    required this.assignedLname,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
