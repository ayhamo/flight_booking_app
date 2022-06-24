import 'package:flutter/material.dart';

//import 'Models/CompanyFlights.dart';
import 'Models/Company.dart';
import 'Models/selected_flight.dart';
import 'Models/CompanyFlights.dart';
import 'Models/Flight.dart';
import 'Models/FlightTicketDetails.dart';
import 'Models/User.dart';

class Data {
  static User? user;
  static Company? company;

  static List<Flight> flights = [];
  static List<CompanyFlights> companyFlights = [];
  static List<FlightTicketDetails> userFlights = [];

  static SelectedFlight selectedFlight =
      SelectedFlight.resetFlight(); //for payment gate

  static int flightID = -1; //for adding a new flight for company

  static Future<void> apiError(context, String? e) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'ALERT',
              style: TextStyle(color: Colors.red),
            ),
            content: Text(
                e == null
                    ? 'An Error have Occurred\nPlease Try Again Later'
                    : "A Fatal Problem With Server Has Occurred",
                style: const TextStyle(fontSize: 17)),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
