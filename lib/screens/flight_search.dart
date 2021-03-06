import 'dart:convert';
import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../home_widgets/top_bar_contents.dart';
import '../Data.dart';
import '../Models/Flight.dart';
import '../Models/selected_flight.dart';
import '../api_controller.dart';
import '../home_widgets/responsive.dart';

class FlightSearch extends StatefulWidget {
  final String from;
  final String fromCode;
  final String to;
  final String toCode;
  final String depDate;
  final String numPpl;
  final String cClass;

  const FlightSearch(
      {required this.from,
      required this.fromCode,
      required this.to,
      required this.toCode,
      required this.depDate,
      required this.numPpl,
      required this.cClass,
      Key? key})
      : super(key: key);

  @override
  FlightSearchState createState() => FlightSearchState();
}

class FlightSearchState extends State<FlightSearch> {
  var date = DateTime.now();
  var rng = Random();
  DateFormat stringFormat = DateFormat("yyyy-MM-ddThh:mm:ss");
  DateFormat timeFormat = DateFormat("hh:mm");

  bool loading = true;
  bool noFlights = false;
  late Response response;

  Future _searchFlights() async {
    //TODO ABLE TO ADD MORE FLIGHTS HERE
    String json = r'''  
    [
      {
        "id": 2,
        "flightId": 1,
        "companyName": "Turkish Airlines",
        "economyCapacity": 100,
        "economyPrice": 500,
        "bussinesCapacity": 20,
        "bussinesPrice": 1500,
        "firstClassCapacity": 10,
        "firstClassPrice": 6000,
        "flightDepartureDate": "2023-04-23T10:25:43.511",
        "flightLandingDate": "2023-04-23T18:35:43.511"
      },
      {
        "id": 2,
        "flightId": 1,
        "companyName": "Qatar Airlines",
        "economyCapacity": 100,
        "economyPrice": 700,
        "bussinesCapacity": 20,
        "bussinesPrice": 2500,
        "firstClassCapacity": 10,
        "firstClassPrice": 9000,
        "flightDepartureDate": "2023-04-23T08:25:43.511",
        "flightLandingDate": "2023-04-23T17:35:43.511"
      }
    ]''';
    var rng = Random();
    var jsonList = jsonDecode(json) as List<dynamic>;
    Future.delayed(Duration(seconds: rng.nextInt(10)));

    try {
      // response = await ApiController.post(
      //     "/TicketContent/SearchOneFlight?from=${widget.from}&to=${widget.to}&DepartureDate=${widget.depDate}T00%3A00%3A00&numberOfSeat=${widget.numPpl}&cabinClass=${widget.cClass}");
      if (/*response.statusCode == 200*/ true) {
        List<dynamic> check = (/*response.data*/ jsonList) as List<dynamic>;
        if (/*check.isEmpty*/rng.nextInt(10) < 3) { //30% of doing condition
          setState(() {
            loading = false;
            noFlights = true;
          });
        } else {
          setState(() {
            Data.flights = Flight.parseFlights(/*response.data*/ jsonList);
            loading = false;
          });
        }
      }
    } on Exception catch (e) {
      Data.apiError(context, e.toString());
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    _searchFlights();
    date = DateFormat('yyyy-MM-dd').parse(widget.depDate);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 1000),
          child: const TopBarContents(opacity: 1, addPage: true),
        ),
        body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: loading
                ? Padding(
                    padding: const EdgeInsets.only(top: 250),
                    child: Center(
                      child: AvatarGlow(
                        glowColor: Colors.blue,
                        endRadius: 150.0,
                        duration: const Duration(milliseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        repeatPauseDuration: const Duration(milliseconds: 50),
                        child: Material(
                          // Replace this child with your own
                          elevation: 8.0,
                          shape: const CircleBorder(),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[100],
                            radius: 70.0,
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 90,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                      top: noFlights ? 120 : 80,
                      left: ResponsiveWidget.isSmallScreen(context)
                          ? screenSize.width / 20
                          : screenSize.width / 50,
                      right: ResponsiveWidget.isSmallScreen(context)
                          ? screenSize.width / 20
                          : screenSize.width / 50,
                    ),
                    child: noFlights
                        ? Stack(clipBehavior: Clip.none, children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              height: 155,
                              decoration: const BoxDecoration(
                                color: Color(0xFFC72C41),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 54,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Oh snap!",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white),
                                        ),
                                        Spacer(),
                                        Text(
                                          "We have No Flights Available For your destination\nGo Back and Try other Flights we Provide.",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20)),
                                child: SvgPicture.asset(
                                  "assets/images/bubbles.svg",
                                  height: 55,
                                  width: 50,
                                  color: const Color(0xFF801336),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -20,
                              left: 0,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/fail.svg",
                                    height: 70,
                                  ),
                                  Positioned(
                                    top: 10,
                                    child: SvgPicture.asset(
                                      "assets/images/close.svg",
                                      height: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ])
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: Data.flights.length,
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            itemBuilder: (context, index) {
                              return flightView(index);
                            }))));
  }

  Widget flightView(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24))),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      widget.fromCode,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.indigo.shade50,
                          borderRadius: BorderRadius.circular(20)),
                      child: SizedBox(
                        height: 8,
                        width: 8,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.indigo.shade400,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: <Widget>[
                            SizedBox(
                              height: 24,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Flex(
                                    direction: Axis.horizontal,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                        (constraints.constrainWidth() / 6)
                                            .floor(),
                                        (index) => SizedBox(
                                              height: 1,
                                              width: 3,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                    color:
                                                        Colors.grey.shade300),
                                              ),
                                            )),
                                  );
                                },
                              ),
                            ),
                            Center(
                                child: Transform.rotate(
                              angle: 1.5,
                              child: Icon(
                                Icons.local_airport,
                                color: Colors.indigo.shade300,
                                size: 24,
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.pink.shade50,
                          borderRadius: BorderRadius.circular(20)),
                      child: SizedBox(
                        height: 8,
                        width: 8,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.pink.shade400,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      widget.toCode,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink),
                    )
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                        width: 100,
                        child: Text(
                          widget.from,
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        )),
                    Text(
                      difference(index),
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                        width: 100,
                        child: Text(
                          widget.to,
                          textAlign: TextAlign.end,
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      formatDate(true, index),
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formatDate(false, index),
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "${date.day} ${DateFormat("MMMM").format(date)} ${date.year}",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Row(
                      children: <Widget>[
                        const Text(
                          "Flight No : ",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          "${rng.nextInt(100)}",
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 20,
                  width: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: Colors.grey.shade200),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Flex(
                          direction: Axis.horizontal,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                              (constraints.constrainWidth() / 10).floor(),
                              (index) => SizedBox(
                                    height: 1,
                                    width: 5,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade400),
                                    ),
                                  )),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                  width: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        color: Colors.grey.shade200),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.amber.shade50,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Icon(Icons.flight_takeoff,
                            color: Colors.amber)),
                    Text("  ${Data.flights[index].companyName}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey))
                  ],
                ),
                Row(
                  children: [
                    Text(
                        widget.cClass == "Economy"
                            ? "\u0024 ${Data.flights[index].economyPrice}"
                            : widget.cClass == "Bussines"
                                ? "\u0024 ${Data.flights[index].bussinesPrice}"
                                : "\u0024 ${Data.flights[index].firstClassPrice}",
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    const SizedBox(width: 5),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {
                          Data.selectedFlight = SelectedFlight(
                            id: Data.flights[index].id,
                            from: widget.from,
                            fromCode: widget.fromCode,
                            to: widget.to,
                            toCode: widget.toCode,
                            depTime: formatDate(true, index),
                            landingTime: formatDate(false, index),
                            depDate: widget.depDate,
                            numPpl: widget.numPpl,
                            companyName: Data.flights[index].companyName,
                            cClass: widget.cClass,
                            price: widget.cClass == "Economy"
                                ? Data.flights[index].economyPrice
                                : widget.cClass == "Bussines"
                                    ? Data.flights[index].bussinesPrice
                                    : Data.flights[index].firstClassPrice,
                          );
                          context.push("/payment");
                        },
                        child: const Text("Buy",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(bool isDep, int index) {
    if (isDep) {
      return Data.flights[index].flightDepartureDate.substring(11, 16);
    } else {
      return Data.flights[index].flightLandingDate.substring(11, 16);
    }
  }

  String difference(int index) {
    final depDate = stringFormat.parse(Data.flights[index].flightDepartureDate);
    final landDate = stringFormat.parse(Data.flights[index].flightLandingDate);
    final difference = landDate.difference(depDate).toString();
    return "${timeFormat.parse(difference).hour}H ${timeFormat.parse(difference).minute}M";
  }
}
