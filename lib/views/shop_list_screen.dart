// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightly/controller/main_controller.dart';
import 'package:nightly/controller/shop_list_controller.dart';
import 'package:nightly/utils/constants/color_constants.dart';
import 'package:nightly/utils/constants/size_constants.dart';
import 'package:nightly/utils/logging/app_logger.dart';
import 'package:nightly/views/common_widgets.dart/common_progress_indicator.dart';
import 'package:nightly/views/common_widgets.dart/custom_refresh.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

class ShopListScreen extends StatefulWidget {
  @override
  State<ShopListScreen> createState() => _ShopListScreenState();
}

class _ShopListScreenState extends State<ShopListScreen> {
  ShopListController _shopListController;
  MainController _mainController;
  RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    _mainController = Get.find();
    _shopListController = Get.put(ShopListController());
    // _shopListController = Get.find();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //  Future.delayed(const Duration(milliseconds: 2500), () {
      _shopListController.fetchShops(false);
      // });
    });
    super.initState();
  }

  @override
  void dispose() {
    // Get.delete<ShopListController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: ColorConstants.appBackgroundTheme,
          title: const Text("nightly"),
        ),
        backgroundColor: ColorConstants.appBackgroundTheme,
        body: Obx(
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
                        await _shopListController.fetchShops(true);
                        _refreshController.refreshCompleted();
                      },
                      child: Obx(
                        () => !_shopListController.isOnline.value
                            ? Center(
                                child: Container(
                                  padding: EdgeInsets.only(top: 15.h),
                                  child: Text(
                                    'No Internet! Check Connectivity',
                                    maxLines: 2,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: ColorConstants.appTheme,
                                      // fontFamily: 'Poppins',
                                      fontSize: SizeConstants.subHeaderSize,
                                    ),
                                  ),
                                ),
                              )
                            : _shopListController.commonListView(),
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
        ));
  }
}
