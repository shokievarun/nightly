import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:nightly/controller/main_controller.dart';

import 'package:nightly/models/restaurant.dart';
import 'package:nightly/utils/constants/color_constants.dart';
import 'package:nightly/utils/constants/dimensions.dart';

// ignore: must_be_immutable
class RestaurantCard extends StatefulWidget {
  Restaurant restaurant;
  bool isSlide;
  RestaurantCard(this.restaurant, this.isSlide, {Key? key}) : super(key: key);

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  final MainController _mainController = Get.find();
  RxString name = "".obs;
  RxDouble price = 0.0.obs;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_mainController.userModel == null) {
          context.go('/restaurant/login');
        } else {
          context
              .go('/restaurant/menu', extra: {"restaurant": widget.restaurant});
        }
      },
      child: Card(
        color: Colors.white,
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          // height: 330,
          //  color: Colors.pink,
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                        height: 200.0,
                        autoPlay: widget.isSlide,
                        viewportFraction: 1,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        pauseAutoPlayOnTouch: false,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (indexValue, b) {
                          name.value = widget.restaurant.categories![0]
                              .menuItems![indexValue].name!;
                          price.value = widget.restaurant.categories![0]
                              .menuItems![indexValue].price!;
                        }),
                    items: widget.restaurant.categories![0].menuItems!
                        .map((menuItem) {
                      name.value = menuItem.name!;
                      price.value = menuItem.price!;
                      // return Builder(
                      //   builder: (BuildContext context) {
                      return SizedBox(
                        width: Dimensions.screenWidth,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the border radius as needed
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://api.pizzahut.io/v1/content/en-in/in-1/images/pizza/momo-mia-veg.5f34ea52c10db4a56881051692a618ca.1.jpg",
                            fit: BoxFit.fitWidth,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            cacheManager: DefaultCacheManager(),
                          ),
                        ),
                      );

                      //  },
                      // );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Icon(
                      //   Icons.location_on_outlined,
                      //   size: 35,
                      // ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.restaurant.name ?? "",
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: ColorConstants.appBackgroundTheme,
                                fontSize: Dimensions.fontSize16,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.restaurant.location ?? "",
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: Dimensions.fontSize16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _mainController.openWhatsapp(
                                          number: widget.restaurant.mobile,
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
                                        ),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    const Text("Chat")
                                  ],
                                ),
                                const SizedBox(width: 50),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _mainController.launchCaller(
                                          widget.restaurant.mobile!,
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
                                        ),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    const Text("Call")
                                  ],
                                ),
                                const SizedBox(width: 50),
                                Text(widget.restaurant.isOpen!
                                    ? "Opened"
                                    : "Closed"),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _mainController.launchMap(
                                widget.restaurant.latlng!.latitude,
                                widget.restaurant.latlng!.longitude,
                                widget.restaurant.location!,
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 30,
                              height: 30,
                              child: SvgPicture.asset(
                                'assets/images/send.svg',
                                width: 25,
                                height: 25,
                              ),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Text("${widget.restaurant.distance!.toInt()} kms")
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Obx(
                () => Positioned(
                  top: 8.0,
                  left: 8.0,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    color: Colors.black.withOpacity(0.6),
                    child: Text(
                      '${name.value}  \$${price.value.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
