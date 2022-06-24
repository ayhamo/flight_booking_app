// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Flight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flight _$FlightFromJson(Map<String, dynamic> json) => Flight(
      id: json['id'] as int,
      flightId: json['flightId'] as int,
      companyName: json['companyName'] as String,
      economyCapacity: json['economyCapacity'] as int,
      economyPrice: json['economyPrice'] as int,
      bussinesCapacity: json['bussinesCapacity'] as int,
      bussinesPrice: json['bussinesPrice'] as int,
      firstClassCapacity: json['firstClassCapacity'] as int,
      firstClassPrice: json['firstClassPrice'] as int,
      flightDepartureDate: json['flightDepartureDate'] as String,
      flightLandingDate: json['flightLandingDate'] as String,
    );

Map<String, dynamic> _$FlightToJson(Flight instance) => <String, dynamic>{
      'id': instance.id,
      'flightId': instance.flightId,
      'companyName': instance.companyName,
      'economyCapacity': instance.economyCapacity,
      'economyPrice': instance.economyPrice,
      'bussinesCapacity': instance.bussinesCapacity,
      'bussinesPrice': instance.bussinesPrice,
      'firstClassCapacity': instance.firstClassCapacity,
      'firstClassPrice': instance.firstClassPrice,
      'flightDepartureDate': instance.flightDepartureDate,
      'flightLandingDate': instance.flightLandingDate,
    };
