import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  final int floorId;
  final int genderId;
  final int washroomId;

  Task({
    required this.floorId,
    required this.genderId,
    required this.washroomId,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
