import 'package:json_annotation/json_annotation.dart';

part 'performer.g.dart';

@JsonSerializable()
class Performer {
  final int id;
  final String? userFirstName;
  final String? userLastName;

  Performer({
    required this.id,
    this.userFirstName,
    this.userLastName,
  });

  factory Performer.fromJson(Map<String, dynamic> json) =>
      _$PerformerFromJson(json);

  Map<String, dynamic> toJson() => _$PerformerToJson(this);
}
