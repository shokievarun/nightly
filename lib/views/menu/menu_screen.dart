import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:nightly/controller/main_controller.dart';

import 'package:nightly/views/menu/menu_card.dart';
import 'package:nightly/models/restaurant.dart';
import 'package:nightly/views/common_widgets/rounded_button.dart';
import 'package:nightly/utils/constants/dimensions.dart';

// ignore: must_be_immutable
class MenuScreen extends StatefulWidget {
  Restaurant restaurant;
  MenuScreen({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final MainController _mainController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_mainController.cartMap.containsKey(widget.restaurant.id)) {
        _mainController.cartMap[widget.restaurant.id!] = _mainController
            .cartMap[widget.restaurant.id]!
            .copyWith(lastOpenedDateTime: DateTime.now());
        _mainController.savePendingOrder();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomNavigationBar: _mainController.cartMap
                      .containsKey(widget.restaurant.id) &&
                  _mainController.getCartCount(widget.restaurant.id!) > 0
              ? Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.red, // Specify the desired color here
                        width: 2.0, // Specify the desired width here
                      ),
                    ),
                  ),
                  //    color: Colors.pink,
                  width: Dimensions.screenWidth,
                  height: Dimensions.screenHeight * 0.1,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                  "${_mainController.getCartCount(widget.restaurant.id!)} Items Added"),
                            ),
                            const Icon(Icons.arrow_drop_up)
                          ],
                        ),
                        RoundedButton(
                          title: 'Next Page',
                          onPressed: () {
                            // context.goNamed("sample",
                            //     pathParameters: {'id1': param1, 'id2': param2});
                            // context.go("/restaurant/menu/cart",
                            //     extra: _mainController
                            //         .cartMap[widget.restaurant.id]!);
                            context.go('/restaurant/menu/cart', extra: {
                              'restaurant': widget.restaurant,
                              'order':
                                  _mainController.cartMap[widget.restaurant.id]!
                            });

                            // Get.to(() => CartScreen(
                            //     _mainController.cartMap[widget.restaurant.id]!,
                            //     false));
                            // Handle button press event here
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => NextPage()),
                            // );
                          },
                        ),
                      ]),
                )
              : null,
          body: ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: widget.restaurant.categories == null
                ? 0
                : widget.restaurant.categories!.length,
            padding: const EdgeInsets.only(top: 50, bottom: 50),
            //  controller: widget.childController,
            itemBuilder: (context, topIndex) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MenuCard(
                    //  controller: controller,
                    topIndex: topIndex,
                    categoryName: widget.restaurant.categories![topIndex].name!,
                    menuItemsList:
                        widget.restaurant.categories![topIndex].menuItems!,

                    restaurantId: widget.restaurant.id!,
                    restaurantName: widget.restaurant.name ?? "",
                    restaurantImageUrl: widget.restaurant.image ?? "",
                    // preorderSlots: null,
                  ),
                ],
              );
            },
          ),
        ));
  }
}
