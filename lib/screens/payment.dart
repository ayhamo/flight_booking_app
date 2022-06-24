import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../Data.dart';
import '../Models/selected_flight.dart';
import '../api_controller.dart';
import '../home_widgets/responsive.dart';
import '../home_widgets/top_bar_contents.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  PaymentState createState() => PaymentState();
}

enum PaymentType { cash, visa }

class PaymentState extends State<Payment> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var date = DateTime.now();
  DateTime birthDate = DateTime.now();

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final birthController = TextEditingController();

  List<TextEditingController> passengersFirstNameControllers = [];
  List<TextEditingController> passengersLastNameControllers = [];
  List<TextEditingController> passengersBirthControllers = [];

  PaymentType pt = PaymentType.cash;
  bool showVisa = false;

  late Response response;
  int loggedInID = -1;

  @override
  void initState() {
    date = DateFormat('yyyy-MM-dd').parse(Data.selectedFlight.depDate);
    Data.user != null
        ? firstnameController.text = Data.user!.firstName
        : firstnameController.text = Data.company!.name;

    if (Data.user != null) {
      lastnameController.text = Data.user!.lastName;
    }

    Data.user != null
        ? emailController.text = Data.user!.email
        : emailController.text = Data.company!.email;

    Data.user != null
        ? loggedInID = Data.user!.id
        : loggedInID = Data.company!.id;

    for (int i = 0; i < (int.parse(Data.selectedFlight.numPpl)) - 1; i++) {
      passengersFirstNameControllers.add(TextEditingController());
      passengersLastNameControllers.add(TextEditingController());
      passengersBirthControllers.add(TextEditingController());
    }
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
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 80,
                  left: ResponsiveWidget.isSmallScreen(context)
                      ? screenSize.width / 20
                      : screenSize.width / 10,
                  right: ResponsiveWidget.isSmallScreen(context)
                      ? screenSize.width / 20
                      : screenSize.width / 10,
                ),
                child: flightView(),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                    "Your Total Price: \$${(Data.selectedFlight.price + 250) * int.parse(Data.selectedFlight.numPpl)}\n     (Including Taxes)",
                    style: const TextStyle(
                        fontFamily: 'Montserrat', fontSize: 21.0)),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 16),
                      const Text(
                        'Buyer Information',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 21.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 2) - 20,
                            child: TextFormField(
                              readOnly: true,
                              controller: firstnameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'First Name',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 2) - 20,
                            child: TextFormField(
                              readOnly: true,
                              controller: lastnameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Last Name',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 2) - 20,
                            child: TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter your E-mail',
                                labelText: "E-mail",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an E-mail';
                                }
                                if (!EmailValidator.validate(value)) {
                                  return 'Please enter a valid E-mail';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 2) - 20,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter your Phone Number',
                                labelText: 'Phone Number',
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 10) {
                                  return 'Please enter a valid Phone';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 2) - 20,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter your Passport Number',
                                labelText: "Passport Number",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a Passport Number';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 2) - 20,
                            child: TextFormField(
                              readOnly: true,
                              onTap: () {
                                _selectDate(context, false, -1);
                              },
                              controller: birthController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Press to Select BirthDate',
                                labelText: "Birth Date",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a Birth Date';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: const Center(
                              child: Text("Other Passengers Info",
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 21.0)))),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: int.parse(Data.selectedFlight.numPpl) - 1,
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    child: Center(
                                        child: Text("Passenger ${index + 1}",
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0)))),
                                Row(
                                  children: [
                                    SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width /
                                                  2) -
                                              20,
                                      child: TextFormField(
                                        controller:
                                            passengersFirstNameControllers[
                                                index],
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter your First Name',
                                          labelText: 'First Name',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter Your First Name';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width /
                                                  2) -
                                              20,
                                      child: TextFormField(
                                        controller:
                                            passengersLastNameControllers[
                                                index],
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter your Last Name',
                                          labelText: 'Last Name',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter Your Last Name';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width /
                                                  2) -
                                              20,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText:
                                              'Enter your Passport Number',
                                          labelText: "Passport Number",
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a Passport Number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width /
                                                  2) -
                                              20,
                                      child: TextFormField(
                                        controller:
                                            passengersBirthControllers[index],
                                        readOnly: true,
                                        onTap: () {
                                          _selectDate(context, true, index);
                                        },
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Press to Select BirthDate',
                                          labelText: "Birth Date",
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a Birth Date';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const Center(
                            child: Text("Payment Type",
                                style: TextStyle(
                                    fontFamily: 'Montserrat', fontSize: 21.0))),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 70),
                            width: (MediaQuery.of(context).size.width / 2) - 30,
                            child: ListTile(
                              title: const Text('Cash'),
                              leading: Radio(
                                value: PaymentType.cash,
                                groupValue: pt,
                                onChanged: (PaymentType? value) {
                                  setState(() {
                                    pt = value!;
                                    showVisa = false;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 2) - 60,
                            child: ListTile(
                              title: const Text('Visa'),
                              leading: Radio(
                                value: PaymentType.visa,
                                groupValue: pt,
                                onChanged: (PaymentType? value) {
                                  setState(() {
                                    pt = value!;
                                    showVisa = true;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      showVisa
                          ? Row(
                              children: [
                                SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width / 2) -
                                          20,
                                  child: TextFormField(
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Enter Credit Card No.',
                                        labelText: 'Credit Card Number'),
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.length != 16) {
                                        return 'Please enter Correct Credit Card number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width / 2) -
                                          20,
                                  child: TextFormField(
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'On the back of the card',
                                        labelText: 'CCV'),
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.length != 3) {
                                        return 'Please enter correct CCV';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 20),
                          height: 65.0,
                          width: 120.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: InkWell(
                            child: const Center(
                              child: Text(' Confirm\nPurchase',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0)),
                            ),
                            onTap: () async {
                              if (!(_formKey.currentState!.validate())) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Please fill the required info!")));
                              } else {
                                try {
                                  EasyLoading.show(status: 'Please Wait...');
                                  response = await ApiController.get(
                                      "/Ticket/BuyTicket?ticketContentId=${Data.selectedFlight.id}&userId=$loggedInID&cabinType=${Data.selectedFlight.cClass}&quantity=${Data.selectedFlight.numPpl}");
                                  if (response.statusCode == 200) {
                                    if (response.data["Message"] !=
                                        "Purchase Completed") {
                                      Data.apiError(context, null);
                                    } else {
                                      for (int i = 0;
                                          i <
                                              (int.parse(Data
                                                      .selectedFlight.numPpl) -
                                                  1);
                                          i++) {
                                        await ApiController.get(
                                            "/Ticket/getpassenger?ticketContentId=${Data.selectedFlight.id}&name=${passengersFirstNameControllers[i].text}&Surname=${passengersLastNameControllers[i].text}&birthDate=${passengersBirthControllers[i].text}T00%3A00%3A00");
                                      }
                                      await EasyLoading.showSuccess(
                                          'Thanks for waiting!');
                                      EasyLoading.dismiss();
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ButtonBarTheme(
                                            data: const ButtonBarThemeData(
                                                alignment:
                                                    MainAxisAlignment.center),
                                            child: AlertDialog(
                                              title: const Icon(
                                                Icons
                                                    .check_circle_outline_rounded,
                                                color: Colors.green,
                                                size: 50,
                                              ),
                                              content: const Text(
                                                  'Thank you for your Booking\n PNR: J32E4A',
                                                  textAlign: TextAlign.center),
                                              actions: <Widget>[
                                                TextButton(
                                                    onPressed: () {
                                                      Data.selectedFlight =
                                                          SelectedFlight
                                                              .resetFlight();
                                                      context.go("/");
                                                    },
                                                    child: const Text('OK',
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color: Colors
                                                                .lightGreen))),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  }

                                  setState(() {});
                                } on Exception catch (e) {
                                  Data.apiError(context, e.toString());
                                  if (kDebugMode) {
                                    print(e);
                                  }
                                }
                              }
                            },
                          )),
                    ],
                  ),
                ),
              )
            ])));
  }

  _selectDate(BuildContext context, bool passInfo, index) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: passInfo ? DateTime.now() : birthDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (selected != null && selected != birthDate) {
      setState(() {
        birthDate = selected;
        passInfo
            ? passengersBirthControllers[index].text = formatDate(selected)
            : birthController.text =
                "${selected.day}/${selected.month}/${selected.year}";
      });
    }
  }

  String formatDate(DateTime bd) {
    String m = "${bd.month}";
    String d = "${bd.day}";
    if (bd.day < 10) {
      d = "0${bd.day}";
    }
    if (bd.month < 10) {
      m = "0${bd.month}";
    }
    return "${bd.year}-$m-$d";
  }

  Widget flightView() {
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
                      Data.selectedFlight.fromCode,
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
                      Data.selectedFlight.toCode,
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
                          Data.selectedFlight.from,
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        )),
                    Text(
                      Data.selectedFlight.cClass,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                        width: 100,
                        child: Text(
                          Data.selectedFlight.to,
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
                      Data.selectedFlight.depTime,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      Data.selectedFlight.landingTime,
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
                          "# Of People : ",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          Data.selectedFlight.numPpl,
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
                    Text("  ${Data.selectedFlight.companyName}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey))
                  ],
                ),
                Row(
                  children: [
                    Text("\u0024 ${Data.selectedFlight.price}",
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    const SizedBox(width: 5),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
