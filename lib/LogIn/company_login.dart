import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Data.dart';
import '../Models/Company.dart';
import '../api_controller.dart';
import '../home_widgets/responsive.dart';

class CompanyLogin extends StatefulWidget {
  const CompanyLogin({Key? key}) : super(key: key);

  @override
  State<CompanyLogin> createState() => _CompanyLoginState();
}

class _CompanyLoginState extends State<CompanyLogin> {
  final _formKey = GlobalKey<FormState>();
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
                          "Company Login Portal",
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text(
                        "Please Login To The Company Account",
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
                      TextButton(
                          onPressed: () {
                            context.go('/forgetPass');
                          },
                          child: const Text("Forget Password?",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.orange,
                                  height: 2))),
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
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                          onTap: () async {
                            if ((_formKey.currentState!.validate())) {
                              try {
                                String email =
                                    emailController.text.replaceAll("@", "%40");
                                response = await ApiController.post(
                                    "/Company/login?email=$email&password=${passController.text}");
                                if (response.statusCode == 200) {
                                  if (response.data["message"] ==
                                      "Account Not Found Or Pending approval.") {
                                    Data.apiError(
                                        context, response.data["message"]);
                                  } else {
                                    Data.company =
                                        Company.fromJson(response.data);
                                    Router.neglect(
                                        context, () => context.go('/'));
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
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () => context.push('/userLogin'),
                                  child: const Text(" End-User? \nLogin Here!",
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
                                  onPressed: () => context.push('/userLogin'),
                                  child: const Text(
                                      "No account? \n   Register! ",
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
