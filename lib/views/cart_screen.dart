import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightly/controller/main_controller.dart';
import 'package:nightly/repositries/order_service.dart';
import 'package:nightly/views/payment_screen.dart';
import 'package:nightly/models/models.dart';
import 'package:nightly/utils/constants/app_colors.dart';
import 'package:nightly/utils/constants/common_functions.dart';
import 'package:nightly/utils/constants/dimensions.dart';

// ignore: must_be_immutable
class CartScreen extends StatefulWidget {
  OrderModel orderModel;
  bool isFromHome;
  CartScreen(this.orderModel, this.isFromHome, {Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final MainController _mainController = Get.find();
  //String? selectedPaymentType;

  double get totalAmount {
    double amount = 0;
    for (var item in widget.orderModel.menuItems) {
      amount += (item.price ?? 0) * (item.count ?? 0);
    }
    return amount;
  }

  void increaseQuantity(item) {
    _mainController.onAdd(
      item,
      widget.orderModel.restaurantId,
      widget.orderModel.name,
      widget.orderModel.image,
    );
    setState(() {});
  }

  void decreaseQuantity(item) {
    _mainController.onRemove(
      item,
      widget.orderModel.restaurantId,
      widget.orderModel.name,
      widget.orderModel.image,
    );
    setState(() {});
  }

  void openPaymentSheet() async {
    Get.to(() => PaymentSelectionScreen());
    // String? result = await Get.to<String>(PaymentSelectionScreen());
    // if (result != null) {
    //   setState(() {
    //     selectedPaymentType = result;
    //   });
    // }
  }

  // void clearPaymentType() {
  //   setState(() {
  //     selectedPaymentType = null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: widget.orderModel.menuItems.isEmpty
            ? const Center(
                child: Text('No items in the cart.'),
              )
            : ListView.builder(
                itemCount: widget.orderModel.menuItems.length,
                itemBuilder: (context, index) {
                  var menuItem = widget.orderModel.menuItems[index];
                  double itemTotal =
                      (menuItem.price ?? 0) * (menuItem.count ?? 0);
                  return ListTile(
                    title: Text(menuItem.name!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Quantity: ${menuItem.count!}'),
                        Text('Price: \$${menuItem.price!.toStringAsFixed(2)}'),
                        Text('Item Total: \$${itemTotal.toStringAsFixed(2)}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => decreaseQuantity(menuItem),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => increaseQuantity(menuItem),
                        ),
                      ],
                    ),
                  );
                },
              ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.red, // Specify the desired color here
                width: 2.0, // Specify the desired width here
              ),
            ),
          ),
          height: Dimensions.screenHeight * 0.1,
          padding: const EdgeInsets.all(16),
          child: Obx(() => Row(
                children: [
                  if (_mainController.paymenttype.value == "")
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: openPaymentSheet,
                        icon: const Icon(Icons.payment),
                        label: const Text("Select Payment"),
                      ),
                    )
                  else
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Obx(
                            () => ElevatedButton.icon(
                              onPressed: openPaymentSheet,
                              icon: const Icon(Icons.payment),
                              label: Text(_mainController.paymenttype.value),
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () async {
                              OrderModel orderModel = widget.orderModel;
                              orderModel = orderModel.copyWith(
                                  userId: _mainController.userModel!.id,
                                  totalAmount: totalAmount,
                                  paymentType:
                                      _mainController.paymenttype.value);
                              bool isOrderPlaced =
                                  await orderService.placeOrder(orderModel);
                              if (isOrderPlaced) {
                                if (_mainController.cartMap
                                    .containsKey(orderModel.restaurantId)) {
                                  _mainController.cartMap
                                      .remove(orderModel.restaurantId);
                                  _mainController.cartMap.refresh();
                                }
                                if (widget.isFromHome) {
                                  Get.back();
                                } else {
                                  Get.back();
                                  Get.back();
                                }

                                showCustomStatusSnackBar(
                                    text: "Order Placed",
                                    backgroundColor: AppColors.kFoodGreen,
                                    iconPath: "");
                              }
                              // Perform checkout or payment logic here
                            },
                            child: Text(
                                'Checkout - \$${totalAmount.toStringAsFixed(2)}'),
                          ),
                        ],
                      ),
                    ),
                ],
              )),
        ));
  }
}
