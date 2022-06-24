// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Passenger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Passenger _$PassengerFromJson(Map<String, dynamic> json) => Passenger(
      id: json['id'] as int,
      ticketId: json['ticketId'] as int,
      passangerInfo: json['passangerInfo'] as String,
      birthDate: json['birthDate'] as String,
    );

Map<String, dynamic> _$PassengerToJson(Passenger instance) => <String, dynamic>{
      'id': instance.id,
      'ticketId': instance.ticketId,
      'passangerInfo': instance.passangerInfo,
      'birthDate': instance.birthDate,
    };
