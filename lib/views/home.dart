import 'package:flutter/material.dart';
import 'package:nightly/controller/home_controller.dart';
import 'package:nightly/utils/constants/color_constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController? _homeController;

  @override
  void initState() {
    _homeController = HomeController();
    // Get.put(ShopListController());
    _homeController!.checkLocationPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            _homeController!.navigateToShopListScreen(context);
          },
          child: Container(
            color: ColorConstants.appBackgroundTheme,
            width: 300,
            height: 60,
            alignment: Alignment.center,
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
