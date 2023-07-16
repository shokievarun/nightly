import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:nightly/controller/main_controller.dart';

class HomeController extends GetxController {
  final MainController _mainController = Get.find();
  checkLocationPermissions() async {
    await _mainController.setServiceLocationEnabled();
    await _mainController.setLocationPermissionEnabled();
  }

  navigateToRestaurantListScreen(BuildContext context) async {
    context.go('/restaurant');
  }
}
