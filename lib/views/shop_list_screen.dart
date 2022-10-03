// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightly/controller/shop_list_controller.dart';
import 'package:nightly/utils/constants/color_constants.dart';

class ShopListScreen extends StatefulWidget {
  @override
  State<ShopListScreen> createState() => _ShopListScreenState();
}

class _ShopListScreenState extends State<ShopListScreen> {
  ShopListController _shopListController;
  @override
  void initState() {
    _shopListController = Get.put(ShopListController());
    _shopListController.fetchShops();
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
        backgroundColor: ColorConstants.appBackgroundTheme,
        title: const Text("nightly"),
      ),
      backgroundColor: ColorConstants.appBackgroundTheme,
      body: _shopListController.commonListView(),
    );
  }
}
