import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:nightly/controller/main_controller.dart';
import 'package:nightly/model/shop.dart';
import 'package:nightly/services/general_services.dart';
import 'package:nightly/utils/constants/color_constants.dart';
import 'package:nightly/utils/constants/size_constants.dart';
import 'package:nightly/utils/constants/text_constants.dart';
import 'package:nightly/utils/logging/app_logger.dart';
import 'package:nightly/views/common_widgets.dart/shop_card.dart';
import 'package:sizer/sizer.dart';

enum SortOptions {
  rating,
  lowToHigh,
  highToLow,
  cost,
  distance,
  popularity,
  experience
}

class ShopListController extends GetxController {
  SortOptions sortBy = SortOptions.distance;
  SortOptions sortByHighToLow = SortOptions.highToLow;
  RxList<Shop> shops = <Shop>[].obs;
  final MainController _mainController = Get.find();
  RxBool isLoadingList = false.obs;
  int pageStart = 0;
  int pageSize = 50;
  List<String> emptyListOfString = <String>[];

  fetchShops() async {
    _mainController.isLoaderActive.value = true;
    _mainController.isLoadingList.value = true;
    try {
      await _mainController.saveCurrentLocation();
    } catch (err) {
      _mainController.isLoaderActive.value = false;
      _mainController.isLoadingList.value = false;
      AppLogger.logError("@save current location:" + err.toString());
    }
    try {
      await GeneralService()
          .getShops(
              emptyListOfString,
              emptyListOfString,
              emptyListOfString,
              emptyListOfString,
              30,
              500,
              _mainController.latitude.value,
              _mainController.longitude.value,
              _mainController.currentLocation.value,
              0.0,
              pageStart,
              pageSize,
              sortBy.toString().split(".")[1],
              sortByHighToLow.toString().split(".")[1],
              "",
              emptyListOfString,
              emptyListOfString,
              emptyListOfString)
          .then((response) async {
        if (response['statusCode'] == 200) {
          await Shop.fromJsonToList(response['body']).then((shops) async {
            //  _hasMore = cooks.length >= _pageSize;

            // if (offset == 0) {
            //   this.cooks.clear();
            // }
            if (shops != null) {
              this.shops.addAll(shops);
            }
            _mainController.isLoaderActive.value = false;
            _mainController.isLoadingList.value = false;
          });
        } else {
          _mainController.isLoaderActive.value = false;
          _mainController.isLoadingList.value = false;
          _mainController.snackBar(
              response['body']['msg'], 'Check your connectivity');
        }
      }).catchError((err) {
        _mainController.isLoaderActive.value = false;
        _mainController.isLoadingList.value = false;
        AppLogger.logError("@while getting shops:" + err.toString());
      });
    } catch (err) {
      _mainController.isLoaderActive.value = false;
      _mainController.isLoadingList.value = false;
      AppLogger.logError("@fetch cooks:" + err.toString());
    }
  }

  Widget commonListView() {
    return Obx(() => !_mainController.isServiceLocationEnabled.value &&
            !_mainController.isLoaderActive.value
        ? getGPSWidget()
        : shops.isEmpty
            ? Center(
                child: Obx(() => _mainController.isLoadingList.value
                    ? Container(
                        padding: EdgeInsets.only(top: 15.h),
                        child: const Text(
                          'Loading shops...',
                          style: TextStyle(color: ColorConstants.appTheme),
                        ),
                      )
                    : _mainController.isLocationEnabled.value
                        ? Container(
                            padding: EdgeInsets.only(top: 15.h),
                            child: const Text(
                              'No shops available..',
                              style: TextStyle(color: ColorConstants.appTheme),
                            ),
                          )
                        : getAppLocationWidget()))
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: shops.length,
                      itemBuilder: (context, index) {
                        return ShopCard(shops[index]);
                      },
                    ),
                  ),
                ],
              ));
  }

  Container getAppLocationWidget() {
    // return Container();
    return Container(
        padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 1.h,
            ),
            Icon(
              Icons.location_on_outlined,
              color: ColorConstants.appTheme,
              size: 8.h,
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              TextConstants.locationAccessTxt,
              style: TextStyle(fontSize: 15.sp, color: ColorConstants.appTheme),
            ),
            Text(
              TextConstants.needLocationTxt,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                  fontSize: SizeConstants.subHeaderSize,
                  color: ColorConstants.appTheme),
            ),
            SizedBox(
              height: 5.h,
            ),
            GestureDetector(
              onTap: () async {
                AppSettings.openAppSettings();
              },
              child: Container(
                height: 5.h,
                width: 65.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: ColorConstants.appTheme),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 2.w,
                    ),
                    const Icon(
                      Icons.location_city,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    const Text(TextConstants.allowLocationAccessTxt),
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
        padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Icon(
              Icons.location_on_outlined,
              color: ColorConstants.appTheme,
              size: 8.h,
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              "Device Location is OFF",
              style: TextStyle(fontSize: 15.sp, color: ColorConstants.appTheme),
            ),
            Text(
              TextConstants.needLocationTxt,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: SizeConstants.subHeaderSize,
                  color: ColorConstants.appTheme),
            ),
            SizedBox(
              height: Platform.isAndroid ? 2.h : 4.h,
            ),
            Visibility(
              visible: Platform.isAndroid,
              child: GestureDetector(
                onTap: () async {
                  if (Platform.isAndroid) {
                    await AppSettings.openLocationSettings();
                  } else if (Platform.isIOS) {
                    await AppSettings.openDeviceSettings(asAnotherTask: true);
                  }
                },
                child: Container(
                  height: 5.h,
                  width: 65.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: ColorConstants.appTheme),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 2.w,
                      ),
                      const Icon(Icons.location_city),
                      SizedBox(
                        width: 2.w,
                      ),
                      const Text("Turn ON Device Location"),
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
                  fontSize: SizeConstants.mediunSize,
                ),
              ),
            ),
            Visibility(
              visible: Platform.isIOS,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(
                      fontSize: SizeConstants.mediunSize,
                      fontFamily: 'Poppins',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: "Go to ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConstants.mediunSize,
                              fontWeight: FontWeight.normal)),
                      TextSpan(
                          text: "Settings > Privacy > Location Services",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConstants.mediunSize,
                              fontWeight: FontWeight.bold)),
                    ]),
              ),
            )
          ],
        ));
  }
}
