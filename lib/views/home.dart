import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightly/controller/home_controller.dart';
import 'package:nightly/utils/constants/color_constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    // Get.put(RestaurantListController());
    _homeController.checkLocationPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: ColorConstants.appBackgroundTheme,
          width: 100,
          height: 60,
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              _homeController.navigateToRestaurantListScreen();
            },
            child: const Text(
              "RestaurantsList",
              style: TextStyle(color: ColorConstants.appTheme),
            ),
          ),
        ),
      ),
    );
  }
}
