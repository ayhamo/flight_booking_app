import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Data.dart';
import '../Models/Company.dart';
import '../Models/User.dart';
import '../api_controller.dart';
import '../home_widgets/responsive.dart';

class AccountManagement extends StatefulWidget {
  const AccountManagement({Key? key}) : super(key: key);

  @override
  State<AccountManagement> createState() => _AccountManagementState();
}

class _AccountManagementState extends State<AccountManagement> {
  final _formKey = GlobalKey<FormState>();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  late Response response;
  bool _isEnable = false;

  @override
  void initState() {
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
        ? passController.text = Data.user!.password
        : passController.text = Data.company!.password;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
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
                margin: const EdgeInsets.only(top: 5, bottom: 15),
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
                        child: Text(
                          Data.user != null
                              ? "Account Management"
                              : "Company Management",
                          style: const TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text(
                        "Click Edit To Update Your Data",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          enabled: _isEnable,
                          controller: firstnameController,
                          decoration: const InputDecoration(
                            labelText: "Name",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Data.user != null
                          ? SizedBox(
                              width: 250,
                              child: TextFormField(
                                enabled: _isEnable,
                                controller: lastnameController,
                                decoration: const InputDecoration(
                                  labelText: "Last Name",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a valid Last Name';
                                  }
                                  return null;
                                },
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          enabled: _isEnable,
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
                          enabled: _isEnable,
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
                      _isEnable == false
                          ? const SizedBox()
                          : Container(
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
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
                                        "Apply Changes",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                onTap: () async {
                                  if ((_formKey.currentState!.validate())) {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                              'ALERT',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            content: const Text(
                                                'Data Changed Successfully',
                                                style: TextStyle(fontSize: 17)),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('OK'),
                                                onPressed: () {
                                                  if (Data.user != null) {
                                                    User nuser = User(
                                                        id: Data.user!.id,
                                                        firstName:
                                                            firstnameController
                                                                .text,
                                                        email: emailController
                                                            .text,
                                                        password:
                                                            passController.text,
                                                        lastName:
                                                            lastnameController
                                                                .text);
                                                    Data.user = nuser;
                                                  } else {
                                                    Company ncompany = Company(
                                                      id: Data.company!.id,
                                                      name: firstnameController
                                                          .text,
                                                      email:
                                                          emailController.text,
                                                      password:
                                                          passController.text,
                                                    );
                                                    Data.company = ncompany;
                                                  }
                                                  Router.neglect(context,
                                                      () => context.go('/'));
                                                },
                                              ),
                                            ],
                                          );
                                        });

                                    // try {
                                    //   String email = emailController.text
                                    //       .replaceAll("@", "%40");
                                    //   response = await ApiController.post(Data
                                    //               .user !=
                                    //           null
                                    //       ? "/User/Update?userId=${Data.user?.id}&name=${firstnameController.text}&lastName=${lastnameController.text}&password=${passController.text}&email=$email"
                                    //       : "/Company/Update?companyId=${Data.company?.id}&name=${firstnameController.text}&email=$email&password=${passController.text}");
                                    //   if (response.statusCode == 200) {
                                    //     if (response.data["message"] !=
                                    //         "User informations Changed Successfully.") {
                                    //       Data.apiError(
                                    //           context, "An error occurred");
                                    //     } else {
                                    //       showDialog(
                                    //           barrierDismissible: false,
                                    //           context: context,
                                    //           builder: (BuildContext context) {
                                    //             return AlertDialog(
                                    //               title: const Text(
                                    //                 'ALERT',
                                    //                 style: TextStyle(
                                    //                     color: Colors.red),
                                    //               ),
                                    //               content: const Text(
                                    //                   'Data Changed Successfully',
                                    //                   style: TextStyle(
                                    //                       fontSize: 17)),
                                    //               actions: <Widget>[
                                    //                 TextButton(
                                    //                   child: const Text('OK'),
                                    //                   onPressed: () {
                                    //                     if (Data.user != null) {
                                    //                       User nuser = User(
                                    //                           id: Data.user!.id,
                                    //                           firstName:
                                    //                               firstnameController
                                    //                                   .text,
                                    //                           email:
                                    //                               emailController
                                    //                                   .text,
                                    //                           password:
                                    //                               passController
                                    //                                   .text,
                                    //                           lastName:
                                    //                               lastnameController
                                    //                                   .text);
                                    //                       Data.user = nuser;
                                    //                     } else {
                                    //                       Company ncompany =
                                    //                           Company(
                                    //                         id: Data
                                    //                             .company!.id,
                                    //                         name:
                                    //                             firstnameController
                                    //                                 .text,
                                    //                         email:
                                    //                             emailController
                                    //                                 .text,
                                    //                         password:
                                    //                             passController
                                    //                                 .text,
                                    //                       );
                                    //                       Data.company =
                                    //                           ncompany;
                                    //                     }
                                    //                     Router.neglect(
                                    //                         context,
                                    //                         () => context
                                    //                             .go('/'));
                                    //                   },
                                    //                 ),
                                    //               ],
                                    //             );
                                    //           });
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
                      _isEnable == true
                          ? const SizedBox()
                          : Container(
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isEnable = true;
                                    });
                                  },
                                  child: const Text("Edit",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.orange))),
                            ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: TextButton(
                            onPressed: () => context.go("/"),
                            child: const Text("  Return To\nHome Page",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.orange))),
                      ),
                      Data.company != null
                          ? Container(
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: TextButton(
                                  onPressed: () =>
                                      context.go("/flightManagement"),
                                  child: const Text("      Flight\nManagement",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.orange))),
                            )
                          : const SizedBox(),
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
