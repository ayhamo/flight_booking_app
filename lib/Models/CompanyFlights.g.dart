// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CompanyFlights.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyFlights _$CompanyFlightsFromJson(Map<String, dynamic> json) =>
    CompanyFlights(
      id: json['id'] as int,
      companyId: json['companyId'] as int,
      from: json['from'] as String,
      to: json['to'] as String,
      departureDate: json['departureDate'] as String,
      landingDate: json['landingDate'] as String,
      economyPrice: json['ticketContentEconomyPrice'] as int,
    );

Map<String, dynamic> _$CompanyFlightsToJson(CompanyFlights instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'from': instance.from,
      'to': instance.to,
      'departureDate': instance.departureDate,
      'landingDate': instance.landingDate,
      'ticketContentEconomyPrice': instance.economyPrice,
    };
