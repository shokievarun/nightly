import 'package:get/get.dart';
import 'package:nightly/controller/main_controller.dart';
import 'package:nightly/features/restaurant/restaurant_list_screen.dart';

class HomeController extends GetxController {
  final MainController _mainController = Get.find();
  checkLocationPermissions() async {
    await _mainController.setServiceLocationEnabled();
    await _mainController.setLocationPermissionEnabled();
  }

  navigateToRestaurantListScreen() async {
    // await checkLocationPermissions();
    // if (_mainController.isServiceLocationEnabled.value &&
    //     _mainController.isLocationEnabled.value) {
    Get.to(() => RestaurantListScreen());
    // } else {
    //   _mainController.snackBar("Alert!", "Kindly turn on your location");
    // }
  }
}
