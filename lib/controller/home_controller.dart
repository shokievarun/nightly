import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:nightly/controller/main_controller.dart';
import 'package:nightly/views/restaurant/restaurant_list_screen.dart';

class HomeController extends GetxController {
  final MainController _mainController = Get.find();
  checkLocationPermissions() async {
    await _mainController.setServiceLocationEnabled();
    await _mainController.setLocationPermissionEnabled();
  }

  navigateToRestaurantListScreen(BuildContext context) async {
    // await checkLocationPermissions();
    // if (_mainController.isServiceLocationEnabled.value &&
    //     _mainController.isLocationEnabled.value) {
    // Get.to(() => RestaurantListScreen());
    context.go('/restaurant');
    // } else {
    //   _mainController.snackBar("Alert!", "Kindly turn on your location");
    // }
  }
}
