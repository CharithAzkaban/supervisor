import 'package:json_annotation/json_annotation.dart';

part 'task_type.g.dart';

@JsonSerializable()
class TaskType {
  final int id;
  final String? taskTypeName;

  TaskType({
    required this.id,
    this.taskTypeName,
  });

  factory TaskType.fromJson(Map<String, dynamic> json) =>
      _$TaskTypeFromJson(json);

  Map<String, dynamic> toJson() => _$TaskTypeToJson(this);
}
