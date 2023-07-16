import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nightly/controller/main_controller.dart';
import 'package:nightly/utils/constants/color_constants.dart';
import 'package:nightly/utils/constants/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    MainController _mainController = MainController();
    // Get.put(LifeCycleController());
    _mainController.userModel = _mainController.getUser();
    _mainController.getPendingOrder();
    _mainController.getLastSelectedPaymentType();
    Timer(const Duration(milliseconds: 1000), () {
      context.go('/restaurant');
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
              fontSize: Dimensions.fontSize16,
              //fontFamily: TextConstants.GOTHAM,
              color: ColorConstants.appTheme),
        )));
  }
}
