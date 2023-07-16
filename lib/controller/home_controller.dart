import 'package:flutter/cupertino.dart';

import 'package:go_router/go_router.dart';
import 'package:nightly/controller/main_controller.dart';

class HomeController {
  final MainController _mainController = MainController();
  checkLocationPermissions() async {
    await _mainController.setServiceLocationEnabled();
    await _mainController.setLocationPermissionEnabled();
  }

  navigateToRestaurantListScreen(BuildContext context) async {
    context.go('/restaurant');
  }
}
