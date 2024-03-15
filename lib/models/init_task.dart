import 'package:json_annotation/json_annotation.dart';

part 'init_task.g.dart';

@JsonSerializable()
class InitTask {
  final int floorId;
  final int genderId;
  final int washroomId;

  InitTask({
    required this.floorId,
    required this.genderId,
    required this.washroomId,
  });

  factory InitTask.fromJson(Map<String, dynamic> json) => _$InitTaskFromJson(json);

  Map<String, dynamic> toJson() => _$InitTaskToJson(this);
}
