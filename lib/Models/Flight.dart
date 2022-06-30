// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

part 'Flight.g.dart';

@JsonSerializable()
class Flight {
  int id;
  int flightId;
  String companyName;
  int economyCapacity;
  int economyPrice;
  int bussinesCapacity;
  int bussinesPrice;
  int firstClassCapacity;
  int firstClassPrice;
  String flightDepartureDate;
  String flightLandingDate;

  Flight({
    required this.id,
    required this.flightId,
    required this.companyName,
    required this.economyCapacity,
    required this.economyPrice,
    required this.bussinesCapacity,
    required this.bussinesPrice,
    required this.firstClassCapacity,
    required this.firstClassPrice,
    required this.flightDepartureDate,
    required this.flightLandingDate,
  });

  static List<Flight> parseFlights(List<dynamic> json) =>
      json.cast<Map<String, dynamic>>().map((e) => Flight.fromJson(e)).toList();

  factory Flight.fromJson(Map<String, dynamic> json) => _$FlightFromJson(json);

  Map<String, dynamic> toJson() => _$FlightToJson(this);
}
