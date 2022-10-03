import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightly/controller/home_controller.dart';
import 'package:nightly/utils/constants/color_constants.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController _homeController;

  @override
  void initState() {
    _homeController = Get.put(HomeController());
    _homeController.checkLocationPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: ColorConstants.appBackgroundTheme,
          width: 30.w,
          height: 6.h,
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              _homeController.navigateToShopListScreen();
            },
            child: const Text(
              "ShopsList",
              style: TextStyle(color: ColorConstants.appTheme),
            ),
          ),
        ),
      ),
    );
  }
}
