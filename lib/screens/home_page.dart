import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home_widgets/carousel.dart';
import '../home_widgets/featured_tiles.dart';
import '../home_widgets/flight_selection.dart';
import '../home_widgets/top_bar_contents.dart';
import '../home_widgets/web_scrollbar.dart';
import '../home_widgets/bottom_bar.dart';
import '../home_widgets/responsive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: TopBarContents(opacity: _opacity, addPage: false),
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
                  Column(
                    children: [
                      FlightSelection(screenSize: screenSize),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: const Text('Our Partners',
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      FeaturedTiles(screenSize: screenSize),
                    ],
                  )
                ],
              ),
              ResponsiveWidget.isSmallScreen(context)
                  ? Container(
                      padding: EdgeInsets.only(
                        top: screenSize.height / 20,
                        bottom: screenSize.height / 20,
                      ),
                      width: screenSize.width,
                      // color: Colors.black,
                      child: const Text(
                        'Destinations diversity',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.only(
                        top: screenSize.height / 10,
                        bottom: screenSize.height / 15,
                      ),
                      width: screenSize.width,
                      // color: Colors.black,
                      child: const Text(
                        'Destinations diversity',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              const DestinationCarousel(),
              SizedBox(height: screenSize.height / 10),
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
                            text: 'Sile, Turkey',
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
                                    text: 'Sile, Turkey',
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
                                "http://localhost:5007/swagger/index.html#/Master/Master_Login")),
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
