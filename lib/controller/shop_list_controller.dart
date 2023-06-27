import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:nightly/controller/main_controller.dart';
import 'package:nightly/model/shop.dart';
import 'package:nightly/services/general_services.dart';
import 'package:nightly/utils/constants/color_constants.dart';
import 'package:nightly/utils/constants/size_constants.dart';
import 'package:nightly/utils/constants/text_constants.dart';
import 'package:nightly/utils/logging/app_logger.dart';
import 'package:nightly/views/common_widgets.dart/shop_card.dart';

enum SortOptions {
  rating,
  lowToHigh,
  highToLow,
  cost,
  distance,
  popularity,
  experience
}

class ShopListController {
  SortOptions sortBy = SortOptions.distance;
  SortOptions sortByHighToLow = SortOptions.highToLow;
  List<Shop> shops = <Shop>[];
  final MainController _mainController = MainController();
  bool isLoadingList = false;
  int pageStart = 0;
  int pageSize = 50;
  List<String> emptyListOfString = <String>[];
  bool isOnline = false;

  checkOnline() async {
    isOnline = await _mainController.isOnline();
  }

  fetchShops(bool isFromRefresh) async {
    checkOnline();
    isFromRefresh ? 0 : _mainController.isLoaderActive = true;
    _mainController.isLoadingList = true;
    try {
      await _mainController.saveCurrentLocation();
    } catch (err) {
      _mainController.isLoaderActive = false;
      _mainController.isLoadingList = false;
      AppLogger.error("@save current location:" + err.toString());
    }

    if (isOnline) {
      try {
        await GeneralService()
            .getShops(
                emptyListOfString,
                emptyListOfString,
                emptyListOfString,
                emptyListOfString,
                30,
                500,
                _mainController.latitude,
                _mainController.longitude,
                _mainController.currentLocation,
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
              if (shops.isNotEmpty) {
                this.shops.addAll(shops);
              }
              _mainController.isLoaderActive = false;
              _mainController.isLoadingList = false;
            });
          } else {
            _mainController.isLoaderActive = false;
            _mainController.isLoadingList = false;
            // _mainController.snackBar(
            //     response['body']['msg'], 'Check your connectivity');
          }
        }).catchError((err) {
          _mainController.isLoaderActive = false;
          _mainController.isLoadingList = false;
          AppLogger.error("@while getting shops:" + err.toString());
        });
      } catch (err) {
        _mainController.isLoaderActive = false;
        _mainController.isLoadingList = false;
        AppLogger.error("@fetch cooks:" + err.toString());
      }
    } else {
      //  _mainController.snackBar("No Internet", 'Check your connectivity');
      _mainController.isLoaderActive = false;
      _mainController.isLoadingList = false;
    }
  }

  Widget commonListView() {
    return !_mainController.isServiceLocationEnabled &&
            !_mainController.isLoaderActive
        ? getGPSWidget()
        : shops.isEmpty
            ? Center(
                child: _mainController.isLoadingList
                    ? Container(
                        padding: const EdgeInsets.only(top: 15),
                        child: const Text(
                          'Loading shops...',
                          style: TextStyle(color: ColorConstants.appTheme),
                        ),
                      )
                    : _mainController.isLocationEnabled
                        ? Container(
                            padding: const EdgeInsets.only(top: 15),
                            child: const Text(
                              'No shops available..',
                              style: TextStyle(color: ColorConstants.appTheme),
                            ),
                          )
                        : getAppLocationWidget())
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
              );
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
              height: 1,
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
              TextConstants.locationAccessTxt,
              style: TextStyle(fontSize: 15, color: ColorConstants.appTheme),
            ),
            Text(
              TextConstants.needLocationTxt,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                  fontSize: SizeConstants.subHeaderSize,
                  color: ColorConstants.appTheme),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () async {
                AppSettings.openAppSettings();
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
                  fontSize: SizeConstants.subHeaderSize,
                  color: ColorConstants.appTheme),
            ),
            SizedBox(
              height: Platform.isAndroid ? 2 : 4,
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
