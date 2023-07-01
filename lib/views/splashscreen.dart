import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightly/controller/main_controller.dart';
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
    Get.put(MainController());
    Timer(const Duration(milliseconds: 1000), () {
      Get.offAll(() => const Home());
    });
  }

  @override
  Widget build(BuildContext context) {
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
