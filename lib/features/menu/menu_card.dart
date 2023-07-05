import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightly/controller/main_controller.dart';
import 'package:nightly/features/menu/item_card.dart';
import 'package:nightly/features/restaurant/models.dart';
import 'package:nightly/utils/constants/app_colors.dart';
import 'package:nightly/utils/constants/app_styles.dart';
import 'package:nightly/utils/constants/dimensions.dart';

class MenuCard extends StatelessWidget {
  MenuCard(
      {Key? key,
      required this.topIndex,
      required this.categoryName,
      required this.restaurantId,
      required this.menuItemsList,
      required this.restaurantName,
      required this.restaurantImageUrl})
      : super(key: key);

  final int topIndex;
  final String categoryName;
  final List<Menuitem> menuItemsList;
  final String restaurantId;
  final String restaurantName;
  final String restaurantImageUrl;
  final MainController _mainController = Get.find();
  @override
  Widget build(BuildContext context) {
    // Logger.info("subCategoryList $subCategoryList");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(right: Dimensions.width20),
          child: Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              // backgroundColor: Colors.red,
              // collapsedBackgroundColor: Colors.red,
              title: Container(
                height: 40,
                padding: EdgeInsets.only(left: Dimensions.width20),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(64, 244, 205, 161)
                            .withOpacity(0.4),
                        Colors.white,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: const [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Text(
                  categoryName,
                  style: AppTextStyles.kRoboto50014Black.copyWith(
                      fontSize: 18, color: AppColors.kBlack.withOpacity(0.8)),
                ),
              ),
              initiallyExpanded: true,
              tilePadding: EdgeInsets.zero,
              maintainState: true,
              childrenPadding: EdgeInsets.zero,
              children: [
                ...List.generate(
                  menuItemsList.length,
                  (index) {
                    return Obx(() => _mainController.rebuildPaymentSheet.value
                        ? getFirstFoodMenuCard(index, context)
                        : getFirstFoodMenuCard(index, context));
                  },
                ),

                //* For Subcategory
              ],
            ),
          ),
        ),
      ],
    );
  }

  Padding getFirstFoodMenuCard(int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.width20),
      child: FoodMenuCard(
        sCounterId: restaurantId,
        onImageTap: () {
          // showModalBottomSheet(
          //     shape: RoundedRectangleBorder(
          //         borderRadius: new BorderRadius.only(
          //             // Radius.circular(25.0)
          //             topLeft: const Radius.circular(25.0),
          //             topRight: const Radius.circular(25.0))),
          //     isScrollControlled: true,
          //     context: context,
          //     builder: (context) {
          //       return CustomizedImageBottomSheet(
          //         onAdd: () async {
          //           // bool isPreorderItemAvail = await isPreorderItemAreAvailable();
          //           // if (isPreorderItemAvail) {
          //           //   return;
          //           // }
          //           if (!(await isFoodCourtWithinRadius())) {
          //             return;
          //           }
          //           await addItem(index);
          //         },
          //         onRemove: () {
          //           removeItem(index);
          //         },
          //         itemCalories: menuItemsList[index].calories,
          //         enableImage: true,
          //         itemIsVeg: menuItemsList[index].isVeg,
          //         itemName: menuItemsList[index].name,
          //         itemDescription: menuItemsList[index].description,
          //         itemPrice: menuItemsList[index].price,
          //         itemImageUrl: menuItemsList[index].imageUrl,
          //         itemCount: menuItemsList[index].count,
          //         hideItemPrice: menuItemsList[index].hideitemprice,
          //       );
          //     });
        },
        itemIsVeg: menuItemsList[index].isVeg!,
        itemName: menuItemsList[index].name!,
        itemDescription: menuItemsList[index].description ?? "",
        itemPrice: menuItemsList[index].price!,
        itemImageUrl: menuItemsList[index].image!,
        itemCount: _mainController.getMenuItemCount(
            menuItemsList[index], restaurantId),
        onAdd: () async {
          // String restaurantId = r; // Replace this with the actual restaurantId
          _mainController.onAdd(menuItemsList[index], restaurantId,
              restaurantName, restaurantImageUrl);
          // _mainController.rebuildPaymentSheet.value =
          //     !_mainController.rebuildPaymentSheet.value;
        },
        onRemove: () {
          //  String restaurantId = menuItemsList[index]
          //   .parentId!; // Replace this with the actual restaurantId
          _mainController.onRemove(menuItemsList[index], restaurantId,
              restaurantName, restaurantImageUrl);
          // _mainController.rebuildPaymentSheet.value =
          //     !_mainController.rebuildPaymentSheet.value;
        },
      ),
    );
  }
}
