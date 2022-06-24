import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Data.dart';

class TopBarContents extends StatefulWidget {
  final double opacity;
  final bool addPage;

  const TopBarContents({required this.opacity, required this.addPage, Key? key})
      : super(key: key);

  @override
  TopBarContentsState createState() => TopBarContentsState();
}

class TopBarContentsState extends State<TopBarContents> {
  final List _isHovering = [
    //For animation when hovered
    false, //account management
    false, //LOGOUT
    false, //SIGN IN
    false, //SIGN UP
    false, //Add Flight Button
    false, //For viewing ticket
  ];
  String dropdownValue = 'One';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        color: Theme.of(context).bottomAppBarColor.withOpacity(widget.opacity),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'ASCEND',
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontSize: 22,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),
              Data.user == null && Data.company == null
                  ? Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                          Flexible(
                            child: InkWell(
                              onHover: (value) {
                                setState(() {
                                  value
                                      ? _isHovering[2] = true
                                      : _isHovering[2] = false;
                                });
                              },
                              onTap: () {
                                context.push('/userLogin');
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "SIGN IN",
                                    style: TextStyle(
                                      color: _isHovering[2]
                                          ? Colors.blue[200]
                                          : Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Visibility(
                                    maintainAnimation: true,
                                    maintainState: true,
                                    maintainSize: true,
                                    visible: _isHovering[2],
                                    child: Container(
                                      height: 2,
                                      width: 20,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: screenSize.width / 40),
                          Flexible(
                            child: InkWell(
                              onHover: (value) {
                                setState(() {
                                  value
                                      ? _isHovering[3] = true
                                      : _isHovering[3] = false;
                                });
                              },
                              onTap: () {
                                context.push('/userRegister');
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "SIGN UP",
                                    style: TextStyle(
                                      color: _isHovering[3]
                                          ? Colors.blue[200]
                                          : Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Visibility(
                                    maintainAnimation: true,
                                    maintainState: true,
                                    maintainSize: true,
                                    visible: _isHovering[3],
                                    child: Container(
                                      height: 2,
                                      width: 20,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]))
                  : Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Data.user != null
                              ? Flexible(
                                  child: InkWell(
                                    onHover: (value) {
                                      setState(() {
                                        value
                                            ? _isHovering[5] = true
                                            : _isHovering[5] = false;
                                      });
                                    },
                                    onTap: () {
                                      context.push('/myTickets');
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "My Tickets",
                                          style: TextStyle(
                                            color: _isHovering[5]
                                                ? Colors.blue[200]
                                                : Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Visibility(
                                          maintainAnimation: true,
                                          maintainState: true,
                                          maintainSize: true,
                                          visible: _isHovering[5],
                                          child: Container(
                                            height: 2,
                                            width: 20,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Flexible(
                                  child: InkWell(
                                      onHover: (value) {
                                        setState(() {
                                          value
                                              ? _isHovering[4] = true
                                              : _isHovering[4] = false;
                                        });
                                      },
                                      onTap: () => widget.addPage
                                          ? null
                                          : context.push("/addFlight"),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Add Flight",
                                            style: TextStyle(
                                              color: _isHovering[4]
                                                  ? Colors.blue[200]
                                                  : Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Visibility(
                                            maintainAnimation: true,
                                            maintainState: true,
                                            maintainSize: true,
                                            visible: _isHovering[4],
                                            child: Container(
                                              height: 2,
                                              width: 20,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ))),
                          SizedBox(width: screenSize.width / 90),
                          InkWell(
                            onHover: (value) {
                              setState(() {
                                value
                                    ? _isHovering[0] = true
                                    : _isHovering[0] = false;
                              });
                            },
                            onTap: () {
                              context.push(
                                  "/accountManagement"); //because we are using pop in that page
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  Data.user != null
                                      ? 'Account management'
                                      : 'Company management',
                                  style: TextStyle(
                                    color: _isHovering[0]
                                        ? Colors.blue[200]
                                        : Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Visibility(
                                  maintainAnimation: true,
                                  maintainState: true,
                                  maintainSize: true,
                                  visible: _isHovering[0],
                                  child: Container(
                                    height: 2,
                                    width: 20,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: screenSize.width / 90),
                          InkWell(
                            onHover: (value) {
                              setState(() {
                                value
                                    ? _isHovering[1] = true
                                    : _isHovering[1] = false;
                              });
                            },
                            onTap: () {
                              setState(() {
                                Data.user = null;
                                Data.company = null;
                                widget.addPage ? context.go("/") : null;
                              });
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Log Out',
                                  style: TextStyle(
                                    color: _isHovering[1]
                                        ? Colors.blue[200]
                                        : Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Visibility(
                                  maintainAnimation: true,
                                  maintainState: true,
                                  maintainSize: true,
                                  visible: _isHovering[1],
                                  child: Container(
                                    height: 2,
                                    width: 20,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
