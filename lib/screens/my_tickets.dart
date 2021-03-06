import 'dart:convert';
import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../home_widgets/top_bar_contents.dart';
import '../Data.dart';

// ignore: unused_import
import '../Models/FlightTicketDetails.dart';
import '../api_controller.dart';
import '../home_widgets/responsive.dart';

class MyTickets extends StatefulWidget {
  const MyTickets({Key? key}) : super(key: key);

  @override
  MyTicketsState createState() => MyTicketsState();
}

class MyTicketsState extends State<MyTickets> {
  var rng = Random();
  DateFormat stringFormat = DateFormat("yyyy-MM-ddThh:mm:ss");
  DateFormat timeFormat = DateFormat("hh:mm");

  bool loading = true;
  bool noFlights = false;
  late Response response;

  Future _getTickets() async {
    Future.delayed(Duration(seconds: rng.nextInt(15)));
    //  String json = r'''
    // [
    //   {
    //     "ticket": {
    //       "id": 2,
    //       "ticketContentId": 2,
    //       "ownerId": 2,
    //       "price": 2,
    //       "quantity": 1,
    //       "cabinType": "Economy",
    //       "companyName": "lair1",
    //       "from": "Bangladesh",
    //       "to": "Turkey",
    //       "departureDate": "2023-04-23",
    //       "landingDate": "2023-04-23"
    //     },
    //     "passengers": [
    //       {
    //         "id": 7,
    //         "ticketId": 2,
    //         "passangerInfo": "Ayham Treter",
    //         "birthDate": "2012-04-23T18:25:43.511"
    //       },
    //       {
    //         "id": 7,
    //         "ticketId": 2,
    //         "passangerInfo": "Ayham Treter",
    //         "birthDate": "2012-04-23T18:25:43.511"
    //       },
    //       {
    //         "id": 7,
    //         "ticketId": 2,
    //         "passangerInfo": "Ayham Treter",
    //         "birthDate": "2012-04-23T18:25:43.511"
    //       }
    //     ]
    //   }
    // ]''';
    //  var jsonList = jsonDecode(json) as List<dynamic>;
    //  Data.userFlights = FlightTicketDetails.parseFlightDetails(jsonList);
    //  setState(() {
    //    loading = false;
    //  });
    if (Data.userFlights.isEmpty) {
      setState(() {
        loading = false;
        noFlights = true;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
    // try {
    //   response =
    //       await ApiController.get("/Ticket/ViewTicket?userId=${Data.user?.id}");
    //   if (response.statusCode == 200) {
    //     if (response.data.toString() == "{}") {
    //       setState(() {
    //         loading = false;
    //         noFlights = true;
    //       });
    //     } else {
    //       setState(() {
    //         Data.userFlights =
    //             FlightTicketDetails.parseFlightDetails(response.data);
    //
    //         loading = false;
    //       });
    //     }
    //   }
    // } on Exception catch (e) {
    //   Data.apiError(context, e.toString());
    //   if (kDebugMode) {
    //     print(e);
    //   }
    // }
  }

  @override
  void initState() {
    _getTickets();
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
                            itemCount: Data.userFlights.length,
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            itemBuilder: (context, index) {
                              return ticketView(index);
                            }))));
  }

  Widget ticketView(int index) {
    DateTime date = DateFormat('yyyy-MM-dd')
        .parse(Data.userFlights[index].ticket.departureDate);
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
                      Data.userFlights[index].ticket.from,
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
                      Data.userFlights[index].ticket.to,
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
                          "${Data.userFlights[index].ticket.from} Airport",
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        )),
                    Text(
                      Data.userFlights[index].ticket.cabinType,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                        width: 100,
                        child: Text(
                          "${Data.userFlights[index].ticket.to} Airport",
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
                          "# Of people: ",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          "${Data.userFlights[index].ticket.quantity}",
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
            child: Column(
              children: [
                Row(
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
                        Text("  ${Data.userFlights[index].ticket.companyName}",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey))
                      ],
                    ),
                    Row(
                      children: [
                        Text("\u0024 ${Data.userFlights[index].ticket.price}",
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ],
                    ),
                  ],
                ),
                if (Data.userFlights[index].passengers.isEmpty) ...[
                  const SizedBox()
                ] else ...[
                  const Center(
                      child: Text("Passengers",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black))),
                  GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 90,
                          childAspectRatio:
                              ResponsiveWidget.isSmallScreen(context) ? 2 : 10),
                      itemCount: Data.userFlights[index].passengers.length,
                      itemBuilder: (BuildContext ctx, i) {
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            Data.userFlights[index].passengers[i].getInfo(),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }),
                ],
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 40),
            child: Image.asset(
              "assets/images/qr.png",
              width: 200,
              height: 200,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 8, 40, 0),
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
                              decoration:
                                  BoxDecoration(color: Colors.grey[800]),
                            ),
                          )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(bool isDep, int index) {
    if (isDep) {
      return Data.userFlights[index].ticket.departureDate; //.substring(11, 16);
    } else {
      return Data.userFlights[index].ticket.landingDate; //.substring(11, 16);
    }
  }
}
