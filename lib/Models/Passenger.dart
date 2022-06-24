import 'package:json_annotation/json_annotation.dart';

part 'Passenger.g.dart';

@JsonSerializable()
class Passenger {
  int id;
  int ticketId;
  String passangerInfo;
  String birthDate;

  Passenger(
      {required this.id,
      required this.ticketId,
      required this.passangerInfo,
      required this.birthDate});

  //we do not the method parsePassengers as it's being handled by parent

  factory Passenger.fromJson(Map<String, dynamic> json) =>
      _$PassengerFromJson(json);

  Map<String, dynamic> toJson() => _$PassengerToJson(this);

  String getInfo() {
    var split = passangerInfo.split(" ");
    return "    ${split[0]} ${split[1]}\n${birthDate.substring(0, 10)}";
  }
}
