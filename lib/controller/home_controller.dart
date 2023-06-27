import 'package:flutter/material.dart';
import 'package:nightly/controller/main_controller.dart';
import 'package:nightly/views/shop_list_screen.dart';

class HomeController {
  final MainController _mainController = MainController();
  checkLocationPermissions() async {
    await _mainController.setServiceLocationEnabled();
    await _mainController.setLocationPermissionEnabled();
  }

  navigateToShopListScreen(BuildContext context) async {
    // await checkLocationPermissions();
    // if (_mainController.isServiceLocationEnabled.value &&
    //     _mainController.isLocationEnabled.value) {
    // } else {
    //   _mainController.snackBar("Alert!", "Kindly turn on your location");
    // }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ShopListScreen()),
    );
  }
}
