import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx/webviewx.dart';

import '../home_widgets/top_bar_contents.dart';
import '../home_widgets/web_scrollbar.dart';
import '../Data.dart';
import '../home_widgets/bottom_bar.dart';
import '../home_widgets/responsive.dart';

class EditFlight extends StatefulWidget {
  const EditFlight({Key? key}) : super(key: key);

  @override
  EditFlightState createState() => EditFlightState();
}

class EditFlightState extends State<EditFlight> {
  late WebViewXController webViewController;
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    webViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.400
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: TopBarContents(opacity: _opacity, addPage: true),
      ),
      body: WebScrollbar(
        color: Colors.blueGrey,
        backgroundColor: Colors.blueGrey.withOpacity(0.3),
        width: 10,
        heightFraction: 0.3,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: screenSize.height * 0.45,
                    width: screenSize.width,
                    child: Image.asset(
                      'assets/images/cover.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenSize.height * 0.25,
                      left: ResponsiveWidget.isSmallScreen(context)
                          ? screenSize.width / 12
                          : screenSize.width / 10,
                      right: ResponsiveWidget.isSmallScreen(context)
                          ? screenSize.width / 12
                          : screenSize.width / 10,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          margin: const EdgeInsets.only(bottom: 10),
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Icon(
                                Icons.warning,
                                color: Colors.yellow,
                              ),
                              Text(
                                "  Your Flight ID is: ${Data.flightID}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Icon(
                                Icons.warning,
                                color: Colors.yellow,
                              ),
                            ],
                          ),
                        ),
                        WebViewX(
                          javascriptMode: JavascriptMode.unrestricted,
                          onWebViewCreated: (controller) {
                            webViewController = controller;
                            webViewController.loadContent(
                              "https://app.vectary.com/p/1i68M8Ewi02jPD9mYZqw60",
                              SourceType.url,
                            );
                          },
                          // onWebViewCreated: (controller) {
                          //   webViewController = controller;
                          //   webViewController.loadContent(
                          //       "http://localhost:5007/swagger/index.html#/Flight/Flight_Update",
                          //       SourceType.url);
                          // },
                          width: screenSize.width,
                          height: screenSize.height / 1.5,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: screenSize.height / 80),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
                color: Theme.of(context).bottomAppBarColor,
                child: ResponsiveWidget.isSmallScreen(context)
                    ? Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              BottomBarColumn(
                                heading: 'ABOUT',
                                s1: 'Contact Us',
                                s1URL: "https://twitter.com/",
                                s2: 'About Us',
                                s3: 'Careers',
                              ),
                              BottomBarColumn(
                                heading: 'HELP',
                                s1: 'Payment',
                                s1URL: "https://twitter.com/",
                                s2: 'Cancellation',
                                s3: 'FAQ',
                              ),
                              BottomBarColumn(
                                heading: 'SOCIAL',
                                s1: 'Twitter',
                                s1URL: "https://twitter.com/",
                                s2: 'Facebook',
                                s3: 'YouTube',
                              ),
                            ],
                          ),
                          Container(
                            color: Colors.blueGrey,
                            width: double.maxFinite,
                            height: 1,
                          ),
                          const SizedBox(height: 20),
                          const InfoText(
                            type: 'Email',
                            text: 'ascend@gmail.com',
                          ),
                          const SizedBox(height: 5),
                          const InfoText(
                            type: 'Address',
                            text: 'Earth, Turkey',
                          ),
                          const SizedBox(height: 20),
                          Container(
                            color: Colors.blueGrey,
                            width: double.maxFinite,
                            height: 1,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Copyright © 2020 | ASCEND',
                            style: TextStyle(
                              color: Colors.blueGrey[300],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const BottomBarColumn(
                                heading: 'ABOUT',
                                s1: 'Contact Us',
                                s1URL:
                                    "https://www.turkishairlines.com/en-tr/any-questions/get-in-touch/",
                                s2: 'About Us',
                                s2URL:
                                    "https://www.turkishairlines.com/en-tr/press-room/about-us/",
                                s3: 'Careers',
                                s3URL: "https://careers.turkishairlines.com",
                              ),
                              const BottomBarColumn(
                                heading: 'HELP',
                                s1: 'Payment',
                                s1URL:
                                    "https://www.turkishairlines.com/en-tr/any-questions/what-payment-methods-are-available-for-payment/",
                                s2: 'Cancellation',
                                s2URL:
                                    "https://www.turkishairlines.com/en-tr/any-questions/am-i-entitled-to-cancel-or-change-my-ticket-or-to-receive-a-discount-or-a-refund/",
                                s3: 'FAQ',
                                s3URL:
                                    "https://www.turkishairlines.com/en-tr/any-questions/index.html",
                              ),
                              const BottomBarColumn(
                                heading: 'SOCIAL',
                                s1: 'Twitter',
                                s1URL: "https://twitter.com/",
                                s2: 'Facebook',
                                s2URL: "https://www.facebook.com/",
                                s3: 'YouTube',
                                s3URL: "https://www.youtube.com/",
                              ),
                              Container(
                                color: Colors.blueGrey,
                                width: 2,
                                height: 150,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  InfoText(
                                    type: 'Email',
                                    text: 'ascend@gmail.com',
                                  ),
                                  SizedBox(height: 5),
                                  InfoText(
                                    type: 'Address',
                                    text: 'Earth, Turkey',
                                  )
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.blueGrey,
                              width: double.maxFinite,
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Copyright © 2021 | ASCEND',
                            style: TextStyle(
                              color: Colors.blueGrey[300],
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 5),
                          InkWell(
                            onTap: () async => await launchUrl(Uri.parse(
                                //"http://localhost:5007/swagger/index.html#/Master/Master_Login"
                                "https://app.vectary.com/p/1i68M8Ewi02jPD9mYZqw60")),
                            child: const Text(
                              'Master Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
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
