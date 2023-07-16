import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightly/controller/main_controller.dart';
import 'package:nightly/models/restaurant.dart';
import 'package:nightly/repositries/restaurant_services.dart';
import 'package:nightly/utils/constants/color_constants.dart';
import 'package:nightly/utils/constants/dimensions.dart';
import 'package:nightly/utils/constants/text_constants.dart';
import 'package:nightly/utils/logging/app_logger.dart';

enum SortOptions {
  rating,
  lowToHigh,
  highToLow,
  cost,
  distance,
  popularity,
  experience
}

class RestaurantListController extends GetxController {
  SortOptions sortBy = SortOptions.distance;
  SortOptions sortByHighToLow = SortOptions.highToLow;
  RxList<Restaurant> restaurants = <Restaurant>[].obs;
  final MainController _mainController = Get.find();
  RxBool isLoadingList = false.obs;
  int pageStart = 0;
  int pageSize = 50;
  List<String> emptyListOfString = <String>[];
  RxBool isOnline = false.obs;

  checkOnline() async {
    isOnline.value = await _mainController.isOnline();
  }

  fetchRestaurants(bool isFromRefresh) async {
    checkOnline();
    isFromRefresh ? 0 : _mainController.isLoaderActive.value = true;
    _mainController.isLoadingList.value = true;
    try {
      await _mainController.saveCurrentLocation();
    } catch (err) {
      _mainController.isLoaderActive.value = false;
      _mainController.isLoadingList.value = false;
      Logger.error("@save current location:" + err.toString());
    }

    if (isOnline.value) {
      try {
        final response = await RestaurantService().getRestaurants();

        if (response['statusCode'] == 200) {
          await Restaurant.fromJsonToList(response['data'])
              .then((restaurants) async {
            //  _hasMore = cooks.length >= _pageSize;

            // if (offset == 0) {
            //   this.cooks.clear();
            // }
            if (restaurants.isNotEmpty) {
              this.restaurants.addAll(restaurants);
            }
            _mainController.isLoaderActive.value = false;
            _mainController.isLoadingList.value = false;
          });
        } else {
          _mainController.isLoaderActive.value = false;
          _mainController.isLoadingList.value = false;
        }
        // }
        // ).catchError((err) {
        //   _mainController.isLoaderActive.value = false;
        //   _mainController.isLoadingList.value = false;
        //   AppLogger.error("@while getting restaurants:" + err.toString());
        // });
      } catch (err) {
        _mainController.isLoaderActive.value = false;
        _mainController.isLoadingList.value = false;
        Logger.error("@fetch cooks:" + err.toString());
      }
    } else {
      _mainController.isLoaderActive.value = false;
      _mainController.isLoadingList.value = false;
    }
  }

  Container getAppLocationWidget() {
    // return Container();
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Icon(
              Icons.location_on_outlined,
              color: ColorConstants.appTheme,
              size: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              TextConstants.locationAccessTxt,
              style: TextStyle(fontSize: 15, color: ColorConstants.appTheme),
            ),
            Text(
              TextConstants.needLocationTxt,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                  fontSize: Dimensions.fontSize16,
                  color: ColorConstants.appTheme),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () async {
                // AppSettings.openAppSettings();
              },
              child: Container(
                height: 5,
                width: 65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: ColorConstants.appTheme),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(
                      width: 2,
                    ),
                    Icon(
                      Icons.location_city,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(TextConstants.allowLocationAccessTxt),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Container getGPSWidget() {
    // return Container();
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 2,
            ),
            const Icon(
              Icons.location_on_outlined,
              color: ColorConstants.appTheme,
              size: 8,
            ),
            const SizedBox(
              height: 2,
            ),
            const Text(
              "Device Location is OFF",
              style: TextStyle(fontSize: 15, color: ColorConstants.appTheme),
            ),
            Text(
              TextConstants.needLocationTxt,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: Dimensions.fontSize16,
                  color: ColorConstants.appTheme),
            ),
            SizedBox(
              height: Platform.isAndroid ? 2 : 4,
            ),
            Visibility(
              visible: Platform.isAndroid,
              child: GestureDetector(
                onTap: () async {
                  // if (Platform.isAndroid) {
                  //   await AppSettings.openLocationSettings();
                  // } else if (Platform.isIOS) {
                  //   await AppSettings.openDeviceSettings(asAnotherTask: true);
                  // }
                },
                child: Container(
                  height: 5,
                  width: 65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: ColorConstants.appTheme),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 2,
                      ),
                      Icon(Icons.location_city),
                      SizedBox(
                        width: 2,
                      ),
                      Text("Turn ON Device Location"),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: Platform.isIOS,
              child: Text(
                "To Turn ON Device Location",
                style: TextStyle(
                  fontSize: Dimensions.fontSize16,
                ),
              ),
            ),
            Visibility(
              visible: Platform.isIOS,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(
                      fontSize: Dimensions.fontSize16,
                      fontFamily: 'Poppins',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: "Go to ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.fontSize16,
                              fontWeight: FontWeight.normal)),
                      TextSpan(
                          text: "Settings > Privacy > Location Services",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.fontSize16,
                              fontWeight: FontWeight.bold)),
                    ]),
              ),
            )
          ],
        ));
  }
}
