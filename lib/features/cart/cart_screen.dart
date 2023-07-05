import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightly/controller/main_controller.dart';
import 'package:nightly/features/restaurant/models.dart';

class CartScreen extends StatefulWidget {
  CartRestaurant cartRestaurant;
  CartScreen(this.cartRestaurant);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  MainController _mainController = Get.find();
  void increaseQuantity(item) {
    _mainController.onAdd(item, widget.cartRestaurant.id,
        widget.cartRestaurant.name, widget.cartRestaurant.image);
    setState(() {});
  }

  void decreaseQuantity(item) {
    _mainController.onRemove(item, widget.cartRestaurant.id,
        widget.cartRestaurant.name, widget.cartRestaurant.image);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: widget.cartRestaurant.menuItems.isEmpty
          ? Center(
              child: Text('No items in the cart.'),
            )
          : ListView.builder(
              itemCount: widget.cartRestaurant.menuItems.length,
              itemBuilder: (context, index) {
                // CartItem item = cartItems[index];
                return ListTile(
                  title: Text(widget.cartRestaurant.menuItems[index].name!),
                  subtitle: Text(
                      'Quantity: ${widget.cartRestaurant.menuItems[index].count!}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => decreaseQuantity(
                            widget.cartRestaurant.menuItems[index]),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => increaseQuantity(
                            widget.cartRestaurant.menuItems[index]),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}