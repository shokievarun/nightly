// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nightly/controller/main_controller.dart';
import 'package:nightly/model/shop.dart';
import 'package:nightly/utils/constants/color_constants.dart';
import 'package:nightly/utils/constants/size_constants.dart';
import 'package:sizer/sizer.dart';

class ShopCard extends StatefulWidget {
  Shop shop;
  ShopCard(this.shop, {Key key}) : super(key: key);

  @override
  State<ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  final MainController _mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // _mainController.launchMap(widget.shop.latlng.latitude,
          //     widget.shop.latlng.longitude, widget.shop.location);
        },
        child: Card(
            color: Colors.white,
            elevation: 0,
            margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 0.w),
            child: Container(
              padding: EdgeInsets.only(
                  left: 10.sp, right: 10.sp, top: 10.sp, bottom: 10.sp),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 35.sp,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(
                          //   height: 1.h,
                          // ),
                          Text(
                            widget.shop.name ?? "",
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: ColorConstants.appBackgroundTheme,
                              // fontFamily: 'PoppinsBold',
                              fontSize: SizeConstants.headerSize,
                            ),
                          ),
                          Row(children: [
                            Expanded(
                              child: Text(
                                widget.shop.location ?? "",
                                style: TextStyle(
                                  //  fontFamily: 'Poppins',
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: SizeConstants.subHeaderSize,
                                ),
                              ),
                            ),
                          ]),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(children: [
                            Column(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      _mainController.openWhatsapp(
                                        number: widget.shop.mobile,
                                      );
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 30.sp,
                                      height: 30.sp,
                                      child: SvgPicture.asset(
                                        'assets/images/whatsapp.svg',
                                        width: 22.sp,
                                        height: 22.sp,
                                        //   color: ColorConstants.appTheme,
                                      ),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        // color: ColorConstants.appBackgroundTheme
                                      ),
                                    )),
                                Text("Chat")
                              ],
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      _mainController.launchCaller(
                                        widget.shop.mobile,
                                      );
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 30.sp,
                                      height: 30.sp,
                                      child: SvgPicture.asset(
                                        'assets/images/telephone.svg',
                                        width: 24.sp,
                                        height: 24.sp,
                                        //  color: ColorConstants.appTheme,
                                      ),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        //  color: ColorConstants.appBackgroundTheme
                                      ),
                                    )),
                                Text("Call")
                              ],
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(widget.shop.status ? "Opened" : "Close"),
                          ])
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              _mainController.launchMap(
                                  widget.shop.latlng.latitude,
                                  widget.shop.latlng.longitude,
                                  widget.shop.location);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 30.sp,
                              height: 30.sp,
                              child: SvgPicture.asset(
                                'assets/images/send.svg',
                                width: 25.sp,
                                height: 25.sp,
                                // color: ColorConstants.appTheme,
                              ),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                //   color: ColorConstants.appBackgroundTheme
                              ),
                            )),
                        Text("${widget.shop.distance.toInt()} kms")
                      ],
                    ),
                  ]),
            )));
  }
}
