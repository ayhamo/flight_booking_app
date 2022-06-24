import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoText extends StatelessWidget {
  final String type;
  final String text;

  const InfoText({Key? key, required this.type, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$type: ',
          style: TextStyle(
            color: Colors.blueGrey[300],
            fontSize: 16,
          ),
        ),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.blueGrey[100],
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }
}

class BottomBarColumn extends StatelessWidget {
  final String heading;
  final String s1;
  final String? s1URL;
  final String s2;
  final String? s2URL;
  final String s3;
  final String? s3URL;

  const BottomBarColumn({
    Key? key,
    required this.heading,
    required this.s1,
    this.s1URL,
    required this.s2,
    this.s2URL,
    required this.s3,
    this.s3URL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(
              color: Colors.blueGrey[300],
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Text(
              s1,
              style: TextStyle(
                color: Colors.blueGrey[100],
                fontSize: 14,
              ),
            ),
            onTap: () async {
              await launchUrl(Uri.parse(s1URL!));
            },
          ),
          const SizedBox(height: 5),
          InkWell(
            child: Text(
              s2,
              style: TextStyle(
                color: Colors.blueGrey[100],
                fontSize: 14,
              ),
            ),
            onTap: () async {
              await launchUrl(Uri.parse(s2URL!));
            },
          ),
          const SizedBox(height: 5),
          InkWell(
            child: Text(
              s3,
              style: TextStyle(
                color: Colors.blueGrey[100],
                fontSize: 14,
              ),
            ),
            onTap: () async {
              await launchUrl(Uri.parse(s3URL!));
            },
          ),
        ],
      ),
    );
  }
}
