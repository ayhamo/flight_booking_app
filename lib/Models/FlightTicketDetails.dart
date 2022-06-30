// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

import 'Passenger.dart';
import 'Ticket.dart';

part 'FlightTicketDetails.g.dart';

@JsonSerializable()
class FlightTicketDetails {
  Ticket ticket;
  List<Passenger> passengers;

  FlightTicketDetails({
    required this.ticket,
    required this.passengers,
  });

  // we have 2 ways, either we create higher class with a list of FlightTicketDetails, or we can handle it in here using below method
  static List<FlightTicketDetails> parseFlightDetails(List<dynamic> json) =>
      json
          .cast<Map<String, dynamic>>()
          .map((e) => FlightTicketDetails.fromJson(e))
          .toList();

  factory FlightTicketDetails.fromJson(Map<String, dynamic> json) =>
      _$FlightTicketDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$FlightTicketDetailsToJson(this);
}
