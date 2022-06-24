// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      id: json['id'] as int,
      ticketContentId: json['ticketContentId'] as int,
      ownerId: json['ownerId'] as int,
      price: json['price'] as int,
      quantity: json['quantity'] as int,
      cabinType: json['cabinType'] as String,
      companyName: json['companyName'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      departureDate: json['departureDate'] as String,
      landingDate: json['landingDate'] as String,
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'id': instance.id,
      'ticketContentId': instance.ticketContentId,
      'ownerId': instance.ownerId,
      'price': instance.price,
      'quantity': instance.quantity,
      'cabinType': instance.cabinType,
      'companyName': instance.companyName,
      'from': instance.from,
      'to': instance.to,
      'departureDate': instance.departureDate,
      'landingDate': instance.landingDate,
    };
