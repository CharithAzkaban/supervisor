import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final int? userTypeId;
  final String? userFirstName;
  final String? userLastName;
  final String? userMobile;
  final String? userEmail;
  final String? userImage;
  final DateTime? userBirthdate;
  final String? userAddress;

  User({
    required this.id,
    this.userTypeId,
    this.userFirstName,
    this.userLastName,
    this.userMobile,
    this.userEmail,
    this.userImage,
    this.userBirthdate,
    this.userAddress,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
