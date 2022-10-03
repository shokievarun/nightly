import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:nightly/controller/main_controller.dart';
import 'package:nightly/model/shop.dart';
import 'package:nightly/services/general_services.dart';
import 'package:nightly/utils/constants/color_constants.dart';
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

class ShopListController extends GetxController {
  SortOptions sortBy = SortOptions.distance;
  SortOptions sortByHighToLow = SortOptions.highToLow;
  RxList<Shop> shops = <Shop>[].obs;
  final MainController _mainController = Get.find();
  RxBool isLoadingList = false.obs;

  fetchShops() async {
    try {
      await _mainController.saveCurrentLocation();
    } catch (err) {
      AppLogger.logError("@save current location:" + err.toString());
    }
    try {
      await GeneralService()
          .getCooks(
              [],
              [],
              [],
              [],
              30,
              500,
              _mainController.latitude.value,
              _mainController.longitude.value,
              _mainController.currentLocation.value,
              0.0,
              0,
              50,
              sortBy.toString().split(".")[1],
              sortByHighToLow.toString().split(".")[1],
              "",
              [],
              [],
              [])
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
          });
        } else {
          _mainController.snackBar(
              response['body']['msg'], 'Check your connectivity');
        }
      }).catchError((err) {
        AppLogger.logError("@while getting shops:" + err.toString());
      });
    } catch (err) {
      AppLogger.logError("@fetch cooks:" + err.toString());
    }
  }

  Widget commonListView() {
    return Obx(() => !_mainController.isServiceLocationEnabled.value &&
            !_mainController.isLoaderActive.value
        ? getGPSWidget()
        : shops.isEmpty
            ? Center(
                child: Obx(() => isLoadingList.value
                    ? const Text('Loading shops...')
                    : _mainController.isLocationEnabled.value
                        ? const Text(
                            'No shops available..',
                            style: TextStyle(color: ColorConstants.appTheme),
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
    return Container();
    // return Container(
    //     padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,

    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         SizedBox(
    //           height: constraints.maxHeight * 0.1,
    //         ),
    //         Icon(
    //           LineAwesomeIcons.map_marker,
    //           color: ColorConstants.primaryYellowColor,
    //           size: 8.h,
    //         ),
    //         SizedBox(
    //           height: constraints.maxHeight * 0.02,
    //         ),
    //         TextBoldWidget(
    //           text: AppConstants.locationAccessTxt,
    //           fontSize: 15.sp,
    //         ),
    //         TextRegularWidget(
    //           text: AppConstants.needLocationTxt,
    //           fontSize: SizeConstants.subHeaderSize,
    //           maxLine: 2,
    //           textAlign: TextAlign.center,
    //         ),
    //         SizedBox(
    //           height: constraints.maxHeight * 0.05,
    //         ),
    //         GestureDetector(
    //           onTap: () async {
    //             AppSettings.openAppSettings();
    //           },
    //           child: Container(
    //             height: constraints.maxHeight * 0.05,
    //             width: constraints.maxWidth * 0.55,
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(40),
    //                 color: ColorConstants.primaryYellowColor),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: [
    //                 SizedBox(
    //                   width: constraints.maxWidth * 0.02,
    //                 ),
    //                 Icon(LineAwesomeIcons.crosshairs),
    //                 SizedBox(
    //                   width: constraints.maxWidth * 0.02,
    //                 ),
    //                 TextRegularWidget(
    //                     text: AppConstants.allowLocationAccessTxt),
    //               ],
    //             ),
    //           ),
    //         ),

    //       ],
    //     ));
  }

  Container getGPSWidget() {
    return Container();
    // return Container(
    //     padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,

    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         SizedBox(
    //           height: constraints.maxHeight * 0.1,
    //         ),
    //         Icon(
    //           LineAwesomeIcons.map_marker,
    //           color: ColorConstants.primaryYellowColor,
    //           size: 8.h,
    //         ),
    //         SizedBox(
    //           height: constraints.maxHeight * 0.02,
    //         ),
    //         TextBoldWidget(
    //           text: "Device Location is OFF",
    //           fontSize: 15.sp,
    //         ),
    //         TextRegularWidget(
    //           text: AppConstants.needLocationTxt,
    //           fontSize: SizeConstants.subHeaderSize,
    //           maxLine: 2,
    //           textAlign: TextAlign.center,
    //         ),
    //         SizedBox(
    //           height:Platform.isAndroid? constraints.maxHeight * 0.02:constraints.maxHeight * 0.0013,
    //         ),
    //         Visibility(
    //           visible: Platform.isAndroid,
    //           child: GestureDetector(
    //             onTap: () async {
    //               if (Platform.isAndroid) {
    //                 await AppSettings.openLocationSettings();
    //               } else if (Platform.isIOS) {
    //                 await AppSettings.openDeviceSettings(asAnotherTask: true);
    //               }
    //             },
    //             child: Container(
    //               height: constraints.maxHeight * 0.05,
    //               width: constraints.maxWidth * 0.65,
    //               decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(40),
    //                   color: ColorConstants.primaryYellowColor),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   SizedBox(
    //                     width: constraints.maxWidth * 0.02,
    //                   ),
    //                   Icon(LineAwesomeIcons.crosshairs),
    //                   SizedBox(
    //                     width: constraints.maxWidth * 0.02,
    //                   ),
    //                   TextRegularWidget(
    //                       text:
    //                       "Turn ON Device Location"
    //                       ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),

    //         Visibility(
    //           visible: Platform.isIOS,
    //           child: TextRegularWidget(
    //             text: "To Turn ON Device Location",
    //             fontSize: SizeConstants.mediunSize,
    //           ),
    //         ),
    //         Visibility(
    //           visible: Platform.isIOS,
    //           child: RichText(
    //             textAlign: TextAlign.center,
    //             text: TextSpan(
    //                 style: TextStyle(
    //                   fontSize: SizeConstants.mediunSize,
    //                   fontFamily: 'Poppins',
    //                 ),
    //                 children: <TextSpan>[
    //                   TextSpan(
    //                       text: "Go to ",
    //                       style: TextStyle(
    //                           color: Colors.black,
    //                           fontSize: SizeConstants.mediunSize,
    //                           fontWeight: FontWeight.normal)),
    //                   TextSpan(
    //                       text: "Settings > Privacy > Location Services",
    //                       style: TextStyle(
    //                           color: Colors.black,
    //                           fontSize: SizeConstants.mediunSize,
    //                           fontWeight: FontWeight.bold)),
    //                 ]),
    //           ),
    //         )
    //       ],
    //     ));
  }
}
