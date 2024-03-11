import 'package:json_annotation/json_annotation.dart';

part 'respo.g.dart';

@JsonSerializable()
class Respo {
  final bool success;
  final String? message;
  final dynamic data;

  Respo({
    this.success = false,
    this.message,
    this.data,
  });

  factory Respo.fromJson(Map<String, dynamic> json) => _$RespoFromJson(json);

  Map<String, dynamic> toJson() => _$RespoToJson(this);
}
