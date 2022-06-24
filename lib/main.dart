import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

import 'Data.dart';
import 'LogIn/company_login.dart';
import 'LogIn/user_login.dart';
import 'Password/forget_pass.dart';
import 'Password/rest_password.dart';
import 'api_controller.dart';
import 'Register/company_register.dart';
import 'Register/user_register.dart';
import 'screens/account_management.dart';
import 'screens/add_flight.dart';
import 'screens/edit_flight.dart';
import 'screens/flight_management.dart';
import 'screens/flight_search.dart';
import 'screens/home_page.dart';
import 'screens/my_tickets.dart';
import 'screens/payment.dart';

Future<void> main() async {
  ApiController.initializeAPIController();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        backgroundColor: Colors.white,
        cardColor: Colors.blueGrey[50],
        primaryTextTheme: TextTheme(
          button: TextStyle(
            color: Colors.blueGrey,
            decorationColor: Colors.blueGrey[300],
          ),
          subtitle2: TextStyle(
            color: Colors.blueGrey[900],
          ),
          subtitle1: const TextStyle(
            color: Colors.black,
          ),
          headline1: TextStyle(color: Colors.blueGrey[800]),
        ),
        bottomAppBarColor: Colors.blueGrey[900],
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        brightness: Brightness.light,
      ),
    );
  }

  /// In Go route, we have push and go, push would be mainly use if we use any pop in redirected page, if not, we use go **/
  final GoRouter _router = GoRouter(
    initialLocation: '/',
    //urlPathStrategy: UrlPathStrategy.path, // This is making the whole app reloading if we change the link
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(
            'Error, No route defined for ${state.error}\nplease head to the main page by removing any path from link'),
      ),
    ),
    routes: <GoRoute>[
      GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) =>
              const HomePage(),
          routes: [
            GoRoute(
                path: 'searchFlight',
                redirect: (_) => Data.user == null && Data.company == null
                    ? '/userLogin'
                    : null,
                builder: (BuildContext context, GoRouterState state) {
                  final from = state.queryParams['from'] as String;
                  final fromCode = state.queryParams['fromCode'] as String;
                  final to = state.queryParams['to'] as String;
                  final toCode = state.queryParams['toCode'] as String;
                  final depDate = state.queryParams['depDate'] as String;
                  final numPpl = state.queryParams['numOfPpl'] as String;
                  final cClass = state.queryParams['class'] as String;
                  return FlightSearch(
                    from: from,
                    fromCode: fromCode,
                    to: to,
                    toCode: toCode,
                    depDate: depDate,
                    numPpl: numPpl,
                    cClass: cClass,
                  );
                }),
            GoRoute(
                redirect: (_) {
                  if (Data.selectedFlight.id == -1) {
                    return '/';
                  } else if (Data.user == null && Data.company == null) {
                    return '/userLogin';
                  } else {
                    return null;
                  }
                },
                path: 'payment',
                builder: (BuildContext context, GoRouterState state) =>
                    const Payment()),
            GoRoute(
              path: 'userLogin',
              builder: (BuildContext context, GoRouterState state) =>
                  const UserLogin(),
            ),
            GoRoute(
              path: 'userRegister',
              builder: (BuildContext context, GoRouterState state) =>
                  const UserRegister(),
            ),
            GoRoute(
              path: 'companyLogin',
              builder: (BuildContext context, GoRouterState state) =>
                  const CompanyLogin(),
            ),
            GoRoute(
              path: 'companyRegister',
              builder: (BuildContext context, GoRouterState state) =>
                  const CompanyRegister(),
            ),
            GoRoute(
              path: 'accountManagement',
              redirect: (_) =>
                  Data.user == null && Data.company == null ? '/' : null,
              builder: (BuildContext context, GoRouterState state) =>
                  const AccountManagement(),
            ),
            GoRoute(
                path: 'flightManagement',
                redirect: (_) => Data.company == null ? '/companyLogin' : null,
                builder: (BuildContext context, GoRouterState state) {
                  return const FlightManagement();
                }),
            GoRoute(
                path: 'editFlight',
                redirect: (_) => Data.company == null ? '/companyLogin' : null,
                builder: (BuildContext context, GoRouterState state) {
                  return const EditFlight();
                }),
            GoRoute(
              path: 'forgetPass',
              builder: (BuildContext context, GoRouterState state) =>
                  const ForgetPass(),
              routes: [
                GoRoute(
                    path: ':id/:type',
                    builder: (BuildContext context, GoRouterState state) {
                      int type = int.parse(state.params['type']!);
                      int id = int.parse(state.params['id']!);
                      return RestPass(id: id, type: type);
                    })
              ],
            ),
            GoRoute(
              path: 'addFlight',
              redirect: (_) => Data.company == null ? '/' : null,
              builder: (BuildContext context, GoRouterState state) =>
                  const AddFlight(),
            ),
            GoRoute(
              path: 'myTickets',
              redirect: (_) => Data.user == null ? '/' : null,
              builder: (BuildContext context, GoRouterState state) =>
                  const MyTickets(),
            ),
          ]),
    ],
  );
}
