import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../home_widgets/responsive.dart';

class FlightSelection extends StatefulWidget {
  const FlightSelection({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  FlightSelectionState createState() => FlightSelectionState();
}

enum TripType {
  oneway,
  //roundtrip
}

Map<TripType, String> _tripTypes = {
  TripType.oneway: 'ONE WAY',
  // TripType.roundtrip: 'ROUND TRIP',
};

class FlightSelectionState extends State<FlightSelection> {
  TripType _selectedTrip = TripType.oneway;

  String from = "From";
  String fromCode = "";
  String fromAirport = "";

  String to = "To";
  String toCode = "";
  String toAirport = "";

  List<String> excludeArr = [];

  DateTime depDate = DateTime.now();

  //DateTime retDate = DateTime.now().add(const Duration(days: 2));

  int pplCount = 1;

  List<String> cabinClasses = [
    "Economy\nCLASS",
    "Business\nCLASS",
    "First\nCLASS"
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: widget.screenSize.height * 0.25,
        left: ResponsiveWidget.isSmallScreen(context)
            ? widget.screenSize.width / 12
            : widget.screenSize.width / 5,
        right: ResponsiveWidget.isSmallScreen(context)
            ? widget.screenSize.width / 12
            : widget.screenSize.width / 5,
      ),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_tripTypes.length, (index) {
                  return buildTripTypeSelector(
                      _tripTypes.keys.elementAt(index));
                }),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(24),
              ),
              onPressed: () {
                showCountryPicker(
                  context: context,
                  exclude: excludeArr,
                  showPhoneCode: false,
                  onSelect: (Country country) {
                    setState(() {
                      excludeArr = [];
                      excludeArr.add(country.countryCode);
                      from = country.name;
                      fromAirport =
                          "${country.displayNameNoCountryCode} International Airport";
                      fromCode = country.countryCode;
                    });
                  },
                );
              },
              child: buildAirportSelector(true, Icons.flight_takeoff),
            ),
            Container(height: 1, color: Colors.black26),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(24),
              ),
              onPressed: () {
                showCountryPicker(
                  context: context,
                  exclude: excludeArr,
                  showPhoneCode: false,
                  onSelect: (Country country) {
                    setState(() {
                      excludeArr = [];
                      excludeArr.add(country.countryCode);
                      to = country.name;
                      toAirport =
                          "${country.displayNameNoCountryCode} International Airport";
                      toCode = country.countryCode;
                    });
                  },
                );
              },
              child: buildAirportSelector(false, Icons.flight_land),
            ),
            Container(height: 1, color: Colors.black26),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    _selectDate(false, context);
                  },
                  child: buildDateSelector('DEPARTURE', depDate),
                ),
              ),
              // Expanded(
              //   child: TextButton(
              //     style: TextButton.styleFrom(
              //       backgroundColor: Colors.white,
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 24, vertical: 12),
              //     ),
              //     // onPressed: () {
              //     //   _selectDate(true, context);
              //     // },
              //     onPressed: _selectedTrip == TripType.roundtrip
              //         ? () {
              //       _selectDate(true, context);
              //     }
              //         : null,
              //     child: buildDateSelector('RETURN', retDate),
              //   ),
              // )
            ]),
            Container(height: 1, color: Colors.black26),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: buildTravellersView(),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    child: buildCabinView(),
                  ),
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 12),
                        blurRadius: 12,
                      ),
                    ],
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width * 2, 100)),
                  ),
                ),
                Center(
                  child: Material(
                    color: Colors.blue,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    elevation: 16,
                    child: InkWell(
                      onTap: () {
                        if (to != "To" && from != "From") {
                          context.push(
                              "/searchFlight?from=$from&fromCode=$fromCode&to=$to&toCode=$toCode&depDate=${formatDate()}&numOfPpl=$pplCount&class=${cabinClasses[index].replaceAll("\nCLASS", "")}"
                              );
                        } else {
                          showDialog<void>(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'ALERT',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  content: const Text(
                                      'You have to select From/To country field',
                                      style: TextStyle(fontSize: 17)),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK!'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                      splashColor: Colors.orange,
                      child: Container(
                        width: 100,
                        height: 100,
                        alignment: Alignment.center,
                        child: const Text(
                          'SEARCH',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatDate() {
    String m = "${depDate.month}";
    String d = "${depDate.day}";
    if (depDate.day < 10) {
      d = "0${depDate.day}";
    }
    if (depDate.month < 10) {
      m = "0${depDate.month}";
    }
    return "${depDate.year}-$m-$d";
  }

  Widget buildTripTypeSelector(TripType tripType) {
    var isSelected = _selectedTrip == tripType;
    return TextButton(
      onPressed: () {
        setState(() {
          _selectedTrip = tripType;
        });
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(left: 20, right: 26),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: isSelected ? Colors.blue : Colors.transparent,
      ),
      child: Row(
        children: <Widget>[
          if (isSelected)
            const Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
          Text(
            _tripTypes[tripType]!,
            style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget buildAirportSelector(bool dep, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              dep ? from : to,
              style: const TextStyle(fontSize: 24, color: Colors.black87),
            ),
            Text(
              dep ? fromAirport : toAirport,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ],
        ),
        Icon(icon),
      ],
    );
  }

  Widget buildDateSelector(String title, DateTime dateTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
        Row(
          children: <Widget>[
            Text(
              dateTime.day.toString().padLeft(2, '0'),
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${dateTime.month.toString()} / ${dateTime.year.toString()}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  DateFormat('EEEE').format(dateTime),
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  _selectDate(bool ret, BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: ret ? depDate.add(const Duration(days: 1)) : depDate,
      firstDate: ret ? depDate.add(const Duration(days: 1)) : DateTime.now(),
      lastDate: DateTime(2024),
    );
    // if (ret) {
    //   if (selected != null && selected != retDate) {
    //     setState(() {
    //       retDate = selected;
    //     });
    //   }
    // } else {
    if (selected != null && selected != depDate) {
      setState(() {
        depDate = selected;
      });
    }
    //}
  }

  Widget buildTravellersView() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'TRAVELLERS',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            Text(
              "$pplCount",
              style: const TextStyle(fontSize: 42, color: Color(0xFF607d8b)),
            ),
          ],
        ),
        const Spacer(),
        Column(
          children: [
            TextButton(
                onPressed: () {
                  setState(() {
                    pplCount++;
                  });
                },
                child: const Icon(Icons.add)),
            TextButton(
                onPressed: () {
                  setState(() {
                    if (pplCount > 1) {
                      pplCount--;
                    }
                  });
                },
                child: const Icon(Icons.remove))
          ],
        ),
      ],
    );
  }

  Widget buildCabinView() {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'CABIN CLASS',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            Text(
              cabinClasses[index].toUpperCase(),
              style: const TextStyle(fontSize: 24, color: Color(0xFF607d8b)),
            ),
          ],
        ),
        const Spacer(),
        Column(
          children: [
            TextButton(
                onPressed: () {
                  setState(() {
                    index++;
                    index %= cabinClasses.length;
                  });
                },
                child: const Icon(Icons.keyboard_arrow_up_outlined)),
            TextButton(
                onPressed: () {
                  setState(() {
                    index--;
                    index %= cabinClasses.length;
                  });
                },
                child: const Icon(Icons.keyboard_arrow_down_outlined)),
          ],
        ),
      ],
    );
  }
}
