import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flight_booking_app/Models/Company.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Data.dart';
import '../api_controller.dart';
import '../home_widgets/responsive.dart';

class CompanyRegister extends StatefulWidget {
  const CompanyRegister({Key? key}) : super(key: key);

  @override
  State<CompanyRegister> createState() => _CompanyRegisterState();
}

class _CompanyRegisterState extends State<CompanyRegister> {
  final _formKey = GlobalKey<FormState>();
  final companyNameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  late Response response;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    companyNameController.dispose();
    emailController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
          onTap: () {
            context.go("/");
          },
          child: Container(
              width: ResponsiveWidget.isSmallScreen(context) ||
                      ResponsiveWidget.isMediumScreen(context)
                  ? 70
                  : 150,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF8A2387),
                        const Color(0xFFE94057),
                        Colors.blue.shade900
                      ])),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(fontSize: 25, color: Colors.white),
                  children: [
                    TextSpan(
                      text: "Skip\n",
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.bottom,
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ))),
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
                child: Image.asset("assets/images/logo.png"),
              ),
              Container(
                margin: const EdgeInsets.only(),
                height: 60,
                width: 180,
                child: Image.asset("assets/images/logo_name.png"),
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
                          "Register Company Account",
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text(
                        "Please Put Your Data To Create An Account",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          controller: companyNameController,
                          decoration: const InputDecoration(
                            labelText: "Company Name",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid company name';
                            }
                            return null;
                          },
                        ),
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
                        margin: const EdgeInsets.only(bottom: 15),
                        width: 250,
                        child: TextFormField(
                          controller: passController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: "Password",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid password';
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
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                          onTap: () async {
                            if ((_formKey.currentState!.validate())) {
                              Data.company = Company(
                                  id: 1,
                                  name: companyNameController.text,
                                  email: emailController.text,
                                  password: passController.text);
                              showDialog<void>(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'ALERT',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      content: const Text(
                                          'You Have Registered And Your \nRequest Is Pending Approval',
                                          style: TextStyle(fontSize: 17)),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('APPROVE ME'),
                                          onPressed: () {
                                            context.go('/');
                                          },
                                        ),
                                      ],
                                    );
                                  });
                              setState(() {});

                              //   try {
                              //     String email =
                              //         emailController.text.replaceAll("@", "%40");
                              //     // /Company/register?CompanyName=kkk&email=kkk%40k.com&password=123
                              //     response = await ApiController.post(
                              //         "/Company/register?CompanyName=${companyNameController.text}&email=$email"
                              //         "&password=${passController.text}");
                              //     if (response.statusCode == 200) {
                              //       if (response.data["message"] ==
                              //           "Email Already Taken.") {
                              //         Data.apiError(
                              //             context, response.data["message"]);
                              //       } else {
                              //         showDialog<void>(
                              //             context: context,
                              //             barrierDismissible: true,
                              //             builder: (BuildContext context) {
                              //               return AlertDialog(
                              //                 title: const Text(
                              //                   'ALERT',
                              //                   style: TextStyle(
                              //                       color: Colors.green),
                              //                 ),
                              //                 content: const Text(
                              //                     'You Have Registered And Your \nRequest Is Pending Approval',
                              //                     style: TextStyle(fontSize: 17)),
                              //                 actions: <Widget>[
                              //                   TextButton(
                              //                     child: const Text('OK'),
                              //                     onPressed: () {
                              //                       context.go('/companyLogin');
                              //                     },
                              //                   ),
                              //                 ],
                              //               );
                              //             });
                              //       }
                              //     }
                              //     setState(() {});
                              //   } on Exception catch (e) {
                              //     Data.apiError(context, e.toString());
                              //     if (kDebugMode) {
                              //       print(e);
                              //     }
                              //   }
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () =>
                                      context.push('/userRegister'),
                                  child: const Text(
                                      " End-User? \nRegister Here!",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.orange))),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: const Text("Or",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black)),
                              ),
                              TextButton(
                                  onPressed: () =>
                                      context.push('/companyLogin'),
                                  child: const Text(
                                      "Have an Account? \n      Login Here! ",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.orange))),
                            ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
