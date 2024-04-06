import 'package:json_annotation/json_annotation.dart';

part 'task_count.g.dart';

@JsonSerializable()
class TaskCount {
  final int pending_status;
  final int todo_status;
  final int performer_completed_status;
  final int supervisor_completed;
  final int rejected_status;

  TaskCount({
    required this.pending_status,
    required this.todo_status,
    required this.performer_completed_status,
    required this.supervisor_completed,
    required this.rejected_status,
  });

  factory TaskCount.fromJson(Map<String, dynamic> json) =>
      _$TaskCountFromJson(json);

  Map<String, dynamic> toJson() => _$TaskCountToJson(this);
}
