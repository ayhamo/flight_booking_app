// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FlightTicketDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightTicketDetails _$FlightTicketDetailsFromJson(Map<String, dynamic> json) =>
    FlightTicketDetails(
      ticket: Ticket.fromJson(json['ticket'] as Map<String, dynamic>),
      passengers: (json['passengers'] as List<dynamic>)
          .map((e) => Passenger.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FlightTicketDetailsToJson(
        FlightTicketDetails instance) =>
    <String, dynamic>{
      'ticket': instance.ticket,
      'passengers': instance.passengers,
    };
