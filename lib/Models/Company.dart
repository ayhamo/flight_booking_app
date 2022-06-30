// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

part 'Company.g.dart';

@JsonSerializable()
class Company {
  int id;
  String name;
  String email;
  String password;

  Company({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
