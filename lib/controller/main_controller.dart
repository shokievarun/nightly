import 'dart:io';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:nightly/features/login/user_model.dart';
import 'package:nightly/model/latlng.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:location/location.dart' as loc;
import 'package:nightly/utils/constants/color_constants.dart';
import 'package:nightly/utils/logging/app_logger.dart';
import 'package:url_launcher/url_launcher.dart';

class MainController extends GetxController {
  LatLng currentLatLng = LatLng(13.027966, 77.540916);
  RxString currentLocation = "Dubai".obs;
  RxDouble latitude = 13.027966.obs;
  RxDouble longitude = 77.540916.obs;
  RxBool isLoaderActive = false.obs;
  RxBool isLoadingList = false.obs;
  RxBool isLocationEnabled = false.obs;

  static bool isLocationPermitted = false;
  RxBool isServiceLocationEnabled = false.obs;
  loc.PermissionStatus? _permissionGranted;
  loc.Location location = loc.Location();

  setServiceLocationEnabled() async {
    isServiceLocationEnabled.value = await location.serviceEnabled();

    if (!isServiceLocationEnabled.value) {
      await location.requestService();
    }
  }

  UserModel? userModel;

  final userBox = Hive.box<UserModel>('users');

  void saveUserFromJson(dynamic jsonData) {
//  final jsonData = json.decode(jsonStr);
    final user = UserModel(
      accessToken: jsonData['accessToken'],
      id: jsonData['user']['_id'],
      name: jsonData['user']['name'],
      email: jsonData['user']['email'],
      number: jsonData['user']['number'],
    );
    userModel = user;
    userBox.put('user', user);
  }

  UserModel? getUser() {
    return userBox.get('user');
  }

  void deleteUser() {
    userModel = null;
    userBox.delete('user');
  }

  setLocationPermissionEnabled() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted != loc.PermissionStatus.denied &&
        _permissionGranted != loc.PermissionStatus.deniedForever) {
      isLocationEnabled.value = true;
      await location.requestPermission();
    } else {
      isLocationEnabled.value = false;
    }
  }

  Future<bool> saveCurrentLocation() async {
    try {
      loc.LocationData position = await getCurrentLocationData();

      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude!, position.longitude!,
          localeIdentifier: "en");
      currentLatLng = LatLng(position.latitude!, position.longitude!);
      var cnt = 0;

      if (placemarks[0].subLocality != null &&
          placemarks[0].subLocality != "Unnamed" &&
          cnt < 2) {
        currentLocation.value = placemarks[0].subLocality.toString();
        cnt++;
      }
      if (placemarks[0].locality != null &&
          placemarks[0].locality != "Unnamed" &&
          cnt < 2 &&
          !currentLocation.value.contains(placemarks[0].locality.toString())) {
        currentLocation.value = (cnt == 1
            ? "${currentLocation.value}, ${placemarks[0].locality}"
            : placemarks[0].locality!);
        cnt++;
      }
      if (placemarks[0].subAdministrativeArea != null &&
          placemarks[0].subAdministrativeArea != "Unnamed" &&
          cnt < 2 &&
          !currentLocation.value
              .contains(placemarks[0].subAdministrativeArea.toString())) {
        currentLocation.value = (cnt == 1
            ? "${currentLocation.value}, ${placemarks[0].subAdministrativeArea}"
            : placemarks[0].subAdministrativeArea!);
        cnt++;
      }
      if (placemarks[0].administrativeArea != null &&
          placemarks[0].administrativeArea == "Unnamed" &&
          cnt < 2 &&
          currentLocation.value
              .contains(placemarks[0].administrativeArea.toString())) {
        currentLocation.value = (cnt == 1
            ? "${currentLocation.value}, ${placemarks[0].administrativeArea}"
            : placemarks[0].administrativeArea!);
        cnt++;
      }
      if (placemarks[0].country != null &&
          placemarks[0].country != "Unnamed") {}

      List<String> locationList = currentLocation.value.split(",");
      currentLocation.value = locationList.last;

      latitude.value = position.latitude!;
      longitude.value = position.longitude!;
    } catch (err) {
      snackBar("Error", err.toString());
      Logger.error("@ saveCurrent location " + err.toString());
    }
    return true;
  }

  //Future<loc.LocationData>
  requestPermissionAgain() async {
    isLocationEnabled.value = false;
    isServiceLocationEnabled.value = false;

    loc.LocationData _locationData;

    isServiceLocationEnabled.value = await location.serviceEnabled();
    _permissionGranted = await location.hasPermission();
    Logger.info("location service value: ${isServiceLocationEnabled.value}");
    Logger.info("app location value: $_permissionGranted");
    if (isServiceLocationEnabled.value) {
      if (_permissionGranted != loc.PermissionStatus.denied &&
          _permissionGranted != loc.PermissionStatus.deniedForever) {
        isLocationEnabled.value = true;
        Future.delayed(const Duration(milliseconds: 1000), () async {
          _locationData = await location.getLocation();
          return _locationData;
        });
      } else {
        _permissionGranted = await location.requestPermission();

        if (_permissionGranted == loc.PermissionStatus.denied ||
            _permissionGranted == loc.PermissionStatus.deniedForever) {
          return Future.error('APP Location permission are disabled.');
        } else {
          isLocationEnabled.value = true;
          Future.delayed(const Duration(milliseconds: 1000), () async {
            _locationData = await location.getLocation();
            return _locationData;
          });
        }
      }
    } else {
      return Future.error('GPS Location services are disabled.');
    }
  }

  Future<loc.LocationData> getCurrentLocationData() async {
    isLocationEnabled.value = false;
    isServiceLocationEnabled.value = false;

    loc.LocationData _locationData;

    isServiceLocationEnabled.value = await location.serviceEnabled();
    _permissionGranted = await location.hasPermission();
    Logger.info("location service value: ${isServiceLocationEnabled.value}");
    Logger.info("app location value: $_permissionGranted");
    if (isServiceLocationEnabled.value) {
      if (_permissionGranted != loc.PermissionStatus.denied &&
          _permissionGranted != loc.PermissionStatus.deniedForever) {
        isLocationEnabled.value = true;
        _locationData = await location.getLocation();
        return _locationData;
      } else {
        _permissionGranted = await location.requestPermission();

        if (_permissionGranted == loc.PermissionStatus.denied ||
            _permissionGranted == loc.PermissionStatus.deniedForever) {
          return Future.error('APP Location permission are disabled.');
        } else {
          isLocationEnabled.value = true;
          _locationData = await location.getLocation();
          return _locationData;
        }
      }
    } else {
      await location.requestService();
      return await requestPermissionAgain();
      // return Future.error('GPS Location services are disabled.');
    }
  }

  // requestLocationService(loc.Location location) async {
  //   try {
  //     if (Platform.isIOS) {
  //       bool isLocationSericeRequested = await LocalDB.getData(
  //         "bool",
  //         "isLocationServiceRequested",
  //       );
  //       if (isLocationSericeRequested == null ||
  //           isLocationSericeRequested == false) {
  //         bool loc1 = await Permission.locationWhenInUse.request().isGranted;

  //         Logger.info("loc1: " + loc1.toString());
  //         await LocalDB.setData("bool", "isLocationServiceRequested", true);
  //       } else if (isLocationSericeRequested == true) {
  //         await location.requestService();
  //       }
  //     }
  //   } catch (e) {
  //     Logger.error("ERROR @requestLocationService : e: " + e.toString());
  //   }
  // }

  void snackBar(String title, String subTitle) {
    Get.snackbar(title, subTitle,
        backgroundColor: ColorConstants.appBackgroundTheme,
        colorText: ColorConstants.appTheme,
        snackPosition: SnackPosition.BOTTOM);
  }

  launchMap(double lat, double lng, String loc) async {
    try {
      var isValid = await MapLauncher.isMapAvailable(MapType.google);
      if (isValid != null && isValid) {
        await MapLauncher.showMarker(
            mapType: MapType.google,
            coords: Coords(13.0399748, 77.51834839999992),
            title: "shopify",
            description: loc,
            zoom: 50);
      } else {
        snackBar("Error", "Could not connect try after sometime");
      }
    } catch (err) {
      snackBar("Error", "Could not connect try after sometime");
      Logger.error("@ map launch: " + err.toString());
    }

    // if (await MapLauncher.isMapAvailable(MapType.google)) {
    //   await MapLauncher.showDirections(
    //       mapType: MapType.google,
    //       destination: Coords(13.0399748, 77.51834839999992),
    //       origin: Coords(
    //           _mainController.latitude.value, _mainController.longitude.value),
    //       originTitle: "Your Location",
    //       destinationTitle: "nightly",
    //       directionsMode: DirectionsMode.driving);
    // }
  }

  Future<bool> isOnline() async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      }
    } on SocketException catch (_) {
      isOnline = false;
    }
    return isOnline;
  }

  Future<void> launchInBrowser(Uri url) async {
    try {
      if (await isOnline()) {
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          snackBar("Error", "Could not connect");
        }
      } else {
        snackBar("No Internet", "Check your connectivity");
      }
    } catch (err) {
      snackBar("Error", "Could not connect try after sometime");
      Logger.error("@brower tap: " + err.toString());
    }
  }

  launchCaller(String url) async {
    final Uri _url = Uri.parse("tel://$url");
    try {
      if (await canLaunchUrl(_url)) {
        await launchUrl(_url);
      } else {
        snackBar("Error", "Could not dial");
      }
    } catch (e) {
      snackBar("Error", "Could not dial");
      Logger.error("@phone tap: " + e.toString());
    }
  }

  void openWhatsapp({String? number}) async {
    try {
      var whatsappURL = Uri.parse("https://wa.me/$number");
      //    if (await canLaunchUrl(whatsappURL)) {
      await launchUrl(whatsappURL, mode: LaunchMode.externalApplication);
      // } else {
      //   snackBar("Error", 'Whatsapp not installed');
      // }
    } catch (e) {
      snackBar("Error", 'Whatsapp not installed');
      Logger.error("@whatsapp tap: " + e.toString());
    }
  }
}
