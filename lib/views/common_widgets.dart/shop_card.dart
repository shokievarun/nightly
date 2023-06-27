// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nightly/controller/main_controller.dart';
import 'package:nightly/model/shop.dart';
import 'package:nightly/utils/constants/color_constants.dart';
import 'package:nightly/utils/constants/size_constants.dart';

class ShopCard extends StatefulWidget {
  Shop shop;
  ShopCard(this.shop, {Key? key}) : super(key: key);

  @override
  State<ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  final MainController _mainController = MainController();
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
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
            child: Container(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 35,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(
                          //   height: 1,
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
                          const SizedBox(
                            height: 1,
                          ),
                          Row(children: [
                            Column(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      _mainController.openWhatsapp(
                                        number: widget.shop.mobile!,
                                      );
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 30,
                                      height: 30,
                                      child: SvgPicture.asset(
                                        'assets/images/whatsapp.svg',
                                        width: 22,
                                        height: 22,
                                        //   color: ColorConstants.appTheme,
                                      ),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        // color: ColorConstants.appBackgroundTheme
                                      ),
                                    )),
                                const Text("Chat")
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      _mainController.launchCaller(
                                        widget.shop.mobile!,
                                      );
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 30,
                                      height: 30,
                                      child: SvgPicture.asset(
                                        'assets/images/telephone.svg',
                                        width: 24,
                                        height: 24,
                                        //  color: ColorConstants.appTheme,
                                      ),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        //  color: ColorConstants.appBackgroundTheme
                                      ),
                                    )),
                                const Text("Call")
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(widget.shop.status! ? "Opened" : "Close"),
                          ])
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              _mainController.launchMap(
                                  widget.shop.latlng!.latitude,
                                  widget.shop.latlng!.longitude,
                                  widget.shop.location!,
                                  context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 30,
                              height: 30,
                              child: SvgPicture.asset(
                                'assets/images/send.svg',
                                width: 25,
                                height: 25,
                                // color: ColorConstants.appTheme,
                              ),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                //   color: ColorConstants.appBackgroundTheme
                              ),
                            )),
                        Text("${widget.shop.distance!.toInt()} kms")
                      ],
                    ),
                  ]),
            )));
  }
}
