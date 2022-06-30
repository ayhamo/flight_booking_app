// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

part 'Ticket.g.dart';

@JsonSerializable()
class Ticket {
  int id;
  int ticketContentId;
  int ownerId;
  int price;
  int quantity;
  String cabinType;
  String companyName;
  String from;
  String to;
  String departureDate;
  String landingDate;

  Ticket({
    required this.id,
    required this.ticketContentId,
    required this.ownerId,
    required this.price,
    required this.quantity,
    required this.cabinType,
    required this.companyName,
    required this.from,
    required this.to,
    required this.departureDate,
    required this.landingDate,
  });

  static List<Ticket> parseTicket(List<dynamic> json) =>
      json.cast<Map<String, dynamic>>().map((e) => Ticket.fromJson(e)).toList();

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);
}
