import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:nightly/controller/main_controller.dart';
import 'package:nightly/features/restaurant/models.dart';
import 'package:nightly/utils/logging/app_logger.dart';

class LifeCycleController extends FullLifeCycleController
    with FullLifeCycleMixin {
  MainController _mainController = Get.find();
  // Mandatory
  @override
  void onDetached() {
    _mainController.savependingOrder();
    Logger.info('LifeCycleController - onDetached called');
  }

  // Mandatory
  @override
  void onInactive() {
    _mainController.savependingOrder();
    Logger.info('LifeCycleController - onInative called');
  }

  // Mandatory
  @override
  void onPaused() {
    _mainController.savependingOrder();
    Logger.info('LifeCycleController - onPaused called');
  }

  // Mandatory
  @override
  Future<void> onResumed() async {
    Logger.info('LifeCycleController - onResumed called');
  }

  // Optional
  @override
  Future<bool> didPushRoute(String route) {
    Logger.info('LifeCycleController - the route $route will be open');
    return super.didPushRoute(route);
  }

  // Optional
  @override
  Future<bool> didPopRoute() {
    Logger.info('LifeCycleController - the current route will be closed');
    return super.didPopRoute();
  }

  // Optional
  @override
  void didChangeMetrics() {
    Logger.info('LifeCycleController - the window size did change');
    super.didChangeMetrics();
  }

  // Optional
  @override
  void didChangePlatformBrightness() {
    Logger.info('LifeCycleController - platform change ThemeMode');
    super.didChangePlatformBrightness();
  }
}