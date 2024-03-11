import 'package:json_annotation/json_annotation.dart';
import 'package:supervisor/models/task_type.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  final int? floorId;
  final int? genderId;
  final int? washroomId;
  final List<TaskType>? tasks;

  Task({
    this.floorId,
    this.genderId,
    this.washroomId,
    this.tasks,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
