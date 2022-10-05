// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightly/controller/main_controller.dart';
import 'package:nightly/controller/shop_list_controller.dart';
import 'package:nightly/utils/constants/color_constants.dart';
import 'package:nightly/views/common_widgets.dart/common_progress_indicator.dart';

class ShopListScreen extends StatefulWidget {
  @override
  State<ShopListScreen> createState() => _ShopListScreenState();
}

class _ShopListScreenState extends State<ShopListScreen> {
  ShopListController _shopListController;
  MainController _mainController;
  @override
  void initState() {
    _mainController = Get.find();
    _shopListController = Get.put(ShopListController());
    // _shopListController = Get.find();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //  Future.delayed(const Duration(milliseconds: 2500), () {
      _shopListController.fetchShops();
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
              _shopListController.commonListView(),
              _mainController.isLoaderActive.value
                  ? const CommonProgressIndicator()
                  : Container()
            ],
          ),
        ));
  }
}
