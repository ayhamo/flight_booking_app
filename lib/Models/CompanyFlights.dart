// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

part 'CompanyFlights.g.dart';

@JsonSerializable()
class CompanyFlights {
  int id;
  int companyId;
  String from;
  String to;
  String departureDate;
  String landingDate;
  @JsonKey(name: "ticketContentEconomyPrice")
  int economyPrice;

  CompanyFlights({
    required this.id,
    required this.companyId,
    required this.from,
    required this.to,
    required this.departureDate,
    required this.landingDate,
    required this.economyPrice,
  });

  static List<CompanyFlights> parseFlights(List<dynamic> json) => json
      .cast<Map<String, dynamic>>()
      .map((e) => CompanyFlights.fromJson(e))
      .toList();

  factory CompanyFlights.fromJson(Map<String, dynamic> json) =>
      _$CompanyFlightsFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyFlightsToJson(this);
}
