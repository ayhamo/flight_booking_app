import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Data.dart';
import '../api_controller.dart';
import '../home_widgets/responsive.dart';

class RestPass extends StatefulWidget {
  final int id;
  final int type; // 0 for end user ,1 for company
  const RestPass({Key? key, required this.id, required this.type})
      : super(key: key);

  @override
  State<RestPass> createState() => _RestPassState();
}

class _RestPassState extends State<RestPass> {
  final _formKey = GlobalKey<FormState>();
  final passController = TextEditingController();
  late Response response;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color(0xFF8A2387),
                  Color(0xFFE94057),
                  Colors.blueAccent
                ])),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 15),
                  height: 180,
                  width: 180,
                  child: Image.asset("images/logo.png"),
                ),
                Container(
                  margin: const EdgeInsets.only(),
                  height: 60,
                  width: 180,
                  child: Image.asset("images/logo_name.png"),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: ResponsiveWidget.isSmallScreen(context) ||
                          ResponsiveWidget.isMediumScreen(context)
                      ? const EdgeInsets.fromLTRB(70, 10, 70, 10)
                      : const EdgeInsets.fromLTRB(350, 10, 350, 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 15, bottom: 5),
                          child: const Text(
                            "Rest Password",
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Text(
                          "Please Type New Password",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            obscureText: true,
                            controller: passController,
                            decoration: const InputDecoration(
                              labelText: "Pass",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter new Password';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                          child: GestureDetector(
                              child: Container(
                                  width: 270,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            const Color(0xFF8A2387),
                                            const Color(0xFFE94057),
                                            Colors.blue.shade900
                                          ])),
                                  child: const Center(
                                    child: Text(
                                      "Rest Password",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                              onTap: () async {
                                if ((_formKey.currentState!.validate())) {
                                  try {
                                    response = await ApiController.post(widget
                                                .type ==
                                            0
                                        ? "/User/ChangePassword?id=${widget.id}&password=${passController.text}"
                                        : "/Company/ChangePassword?id=${widget.id}&password=${passController.text}");
                                    if (response.statusCode == 200) {
                                      if (response.data["message"] ==
                                          "Password Changed Successfully.") {
                                        showDialog<void>(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                  'ALERT',
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                ),
                                                content: Text(
                                                    '${response.data["message"]}',
                                                    style: const TextStyle(
                                                        fontSize: 17)),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('LOGIN!'),
                                                    onPressed: () {
                                                      Router.neglect(
                                                          context,
                                                          () => context.go(
                                                              '/userLogin'));
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
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
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ))));
  }
}
