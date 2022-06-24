import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  int id;
  @JsonKey(name: "name")
  String firstName;
  String email;
  String password;
  String lastName;

  User(
      {required this.id,
      required this.firstName,
      required this.email,
      required this.password,
      required this.lastName});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
