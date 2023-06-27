import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nightly/utils/constants/color_constants.dart';
import 'package:nightly/utils/constants/size_constants.dart';
import 'package:nightly/views/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1000), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConstants.contextHeight = MediaQuery.of(context).size.height;
    SizeConstants.contextWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: ColorConstants.appBackgroundTheme,
        body: Center(
            child: Text(
          "shopify",
          style: TextStyle(
              fontSize: SizeConstants.titleSize,
              //fontFamily: TextConstants.GOTHAM,
              color: ColorConstants.appTheme),
        )));
  }
}
