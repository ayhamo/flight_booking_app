import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Data.dart';
import '../api_controller.dart';
import '../home_widgets/responsive.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({Key? key}) : super(key: key);

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  late Response response;
  String dropdownValue = 'End-User';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
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
                            "Forget Password",
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Text(
                          "Please Type You Email To rest Password",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
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
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: DropdownButton<String>(
                            items: <String>['End-User', 'Company']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 20,
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
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
                                    "Change Password",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                            onTap: () async {
                              if ((_formKey.currentState!.validate())) {
                                context.push(
                                    "/forgetPass/1/${dropdownValue == "End-User" ? 0 : 1}");
                                // try {
                                //   int id;
                                //   String email = emailController.text
                                //       .replaceAll("@", "%40");
                                //   response = await ApiController.post(dropdownValue ==
                                //           "End-User"
                                //       ? "/User/CheckUserMailExists?email=$email"
                                //       : "/Company/CheckCompanyMailExist?email=$email");
                                //   if (response.statusCode == 200) {
                                //     if (response.data["message"] ==
                                //         "Account Not Found.") {
                                //       Data.apiError(
                                //           context, response.data["message"]);
                                //     } else {
                                //       id = response.data["id"];
                                //       context.push(
                                //           "/forgetPass/$id/${dropdownValue == "End-User" ? 0 : 1}");
                                //     }
                                //   }
                                //
                                //   setState(() {});
                                // } on Exception catch (e) {
                                //   Data.apiError(context, e.toString());
                                //   if (kDebugMode) {
                                //     print(e);
                                //   }
                                // }
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: TextButton(
                              onPressed: () => context.push('/userLogin'),
                              child: const Text("Return Here!",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.orange))),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ))));
  }
}
