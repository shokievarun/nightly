// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:nightly/controller/main_controller.dart';
import 'package:nightly/controller/restaurant_list_controller.dart';
import 'package:nightly/models/models.dart';
import 'package:nightly/models/restaurant.dart';
import 'package:nightly/utils/constants/color_constants.dart';
import 'package:nightly/utils/constants/dimensions.dart';
import 'package:nightly/views/common_widgets/common_progress_indicator.dart';
import 'package:nightly/views/common_widgets/custom_refresh.dart';
import 'package:nightly/views/restaurant/restaurant_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RestaurantListScreen extends StatefulWidget {
  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  final RestaurantListController _restaurantListController =
      Get.put(RestaurantListController());
  final ScrollController _scrollController = ScrollController();
  int _visibleIndex = 0;
  final MainController _mainController = Get.find();
  final RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    // _restaurantListController = Get.find();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //  Future.delayed(const Duration(milliseconds: 2500), () {
      _restaurantListController.fetchRestaurants(false);
      // });
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _visibleIndex = _calculateVisibleIndex();
    });
  }

  int _calculateVisibleIndex() {
    // final RenderBox renderBox = context.findRenderObject() as RenderBox;
    //final listViewHeight = renderBox.size.height;
    const itemHeight = 280; // Replace with the actual height of your list items
    final offset = _scrollController.offset;
    final index = (offset / itemHeight).floor();
    final visibleIndex =
        (offset % itemHeight) > (itemHeight / 2) ? index + 1 : index;
    return visibleIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        bottomNavigationBar: _mainController.cartMap.isNotEmpty &&
                _mainController.checkifCartHasZeroItemCount() > 0
            ? Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Colors.red, // Specify the desired color here
                      width: 2.0, // Specify the desired width here
                    ),
                  ),
                ),
                //    color: Colors.pink,
                width: Dimensions.screenWidth,
                height: Dimensions.screenHeight * 0.12,
                child: Stack(
                  children: [
                    for (int i =
                            _mainController.getLatestRestaurant().length - 1;
                        i >= 0;
                        i--)
                      if (_mainController.getCartCount(_mainController
                              .getLatestRestaurant()[i]
                              .restaurantId) >
                          0)
                        Container(
                          //  height: Dimensions.screenHeight * 0.1,
                          margin: EdgeInsets.only(
                              bottom: 10,
                              top: 15 - (i * 4),
                              right: 40 + (i * 12),
                              left: 40 + (i * 12)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.bottomSheet(
                                      Container(
                                          height: Dimensions.screenHeight,
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              for (int i = _mainController
                                                          .getLatestRestaurant()
                                                          .length -
                                                      1;
                                                  i >= 0;
                                                  i--)
                                                if (_mainController.getCartCount(
                                                        _mainController
                                                            .getLatestRestaurant()[
                                                                i]
                                                            .id) >
                                                    0)
                                                  Container(
                                                    //  height: Dimensions.screenHeight * 0.1,
                                                    // margin: EdgeInsets.only(
                                                    //     bottom: 10,
                                                    //     top: 10 + (i * 4),
                                                    //     right: 40 - (i * 12),
                                                    //     left: 40 - (i * 12)),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(
                                                            width: 10),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                _mainController
                                                                    .getLatestRestaurant()[
                                                                        i]
                                                                    .name,
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            16),
                                                              ),
                                                              Text(
                                                                _mainController
                                                                    .getCartCount(
                                                                        _mainController
                                                                            .getLatestRestaurant()[i]
                                                                            .id)
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            16),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            context.go(
                                                                "/restaurant/cart",
                                                                extra: {
                                                                  'order': _mainController
                                                                          .cartMap[
                                                                      _mainController
                                                                          .getLatestRestaurant()[
                                                                              i]
                                                                          .restaurantId]!,
                                                                  'restaurant':
                                                                      Restaurant()
                                                                });
                                                          },
                                                          child: const Text(
                                                              'View Cart'),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                            ],
                                          )),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _mainController
                                            .getLatestRestaurant()[i]
                                            .name,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        _mainController
                                            .getCartCount(_mainController
                                                .getLatestRestaurant()[i]
                                                .restaurantId)
                                            .toString(),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  context.go("/restaurant/cart", extra: {
                                    'order': _mainController.cartMap[
                                        _mainController
                                            .getLatestRestaurant()[i]
                                            .restaurantId]!,
                                    'restaurant': Restaurant()
                                  });
                                },
                                child: const Text('View Cart'),
                              ),
                            ],
                          ),
                        )
                  ],
                ))
            : null,
        appBar: AppBar(
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back, color: Colors.white),
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
          backgroundColor: ColorConstants.appBackgroundTheme,
          title: const Text("restaurantify"),
        ),
        backgroundColor: ColorConstants.appBackgroundTheme,
        body: WillPopScope(
            onWillPop: () async {
              // Show a confirmation dialog
              bool confirmExit = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Exit App'),
                    content: Text('Are you sure you want to exit?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop(
                              false); // Return false to indicate user doesn't want to exit
                        },
                      ),
                      TextButton(
                        child: Text('Yes'),
                        onPressed: () {
                          Navigator.of(context).pop(
                              true); // Return true to indicate user wants to exit
                        },
                      ),
                    ],
                  );
                },
              );

              // Return the user's choice
              return confirmExit ?? false;
            },
            child: Obx(
              () => Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: SmartRefresher(
                          controller: _refreshController,
                          enablePullDown: true,
                          header: const CustomRefresh(),
                          onRefresh: () async {
                            await _restaurantListController
                                .fetchRestaurants(true);
                            _refreshController.refreshCompleted();
                          },
                          child: Obx(
                            () => !_restaurantListController.isOnline.value
                                ? Center(
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Text(
                                        'No Internet! Check Connectivity',
                                        maxLines: 2,
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: ColorConstants.appTheme,
                                          // fontFamily: 'Poppins',
                                          fontSize: Dimensions.fontSize16,
                                        ),
                                      ),
                                    ),
                                  )
                                : commonListView(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  _mainController.isLoaderActive.value
                      ? const CommonProgressIndicator()
                      : Container()
                ],
              ),
            ))));
  }

  Widget commonListView() {
    return Obx(() => !_mainController.isServiceLocationEnabled.value &&
            !_mainController.isLoaderActive.value
        ? _restaurantListController.getGPSWidget()
        : _restaurantListController.restaurants.isEmpty
            ? Center(
                child: Obx(() => _mainController.isLoadingList.value
                    ? Container(
                        padding: const EdgeInsets.only(top: 15),
                        child: const Text(
                          'Loading restaurants...',
                          style: TextStyle(color: ColorConstants.appTheme),
                        ),
                      )
                    : _mainController.isLocationEnabled.value
                        ? Container(
                            padding: const EdgeInsets.only(top: 15),
                            child: const Text(
                              'No restaurants available..',
                              style: TextStyle(color: ColorConstants.appTheme),
                            ),
                          )
                        : _restaurantListController.getAppLocationWidget()))
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      controller: _scrollController,
                      itemCount: _restaurantListController.restaurants.length,
                      itemBuilder: (context, index) {
                        return RestaurantCard(
                            _restaurantListController.restaurants[index],
                            index == _visibleIndex);
                      },
                    ),
                  ),
                ],
              ));
  }
}
