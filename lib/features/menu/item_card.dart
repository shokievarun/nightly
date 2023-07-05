import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nightly/features/menu/counter_button.dart';
import 'package:nightly/features/menu/custom_item_description.dart';
import 'package:nightly/features/menu/food_type.dart';
import 'package:nightly/utils/constants/app_colors.dart';
import 'package:nightly/utils/constants/app_styles.dart';
import 'package:nightly/utils/constants/dimensions.dart';

class FoodMenuCard extends StatelessWidget {
  const FoodMenuCard({
    required this.onAdd,
    required this.onRemove,
    required this.itemIsVeg,
    required this.itemName,
    required this.itemPrice,
    required this.itemDescription,
    required this.itemImageUrl,
    required this.itemCount,
    this.index = 0,
    this.onImageTap,
    required this.sCounterId,
    Key? key,
  }) : super(key: key);

  final bool itemIsVeg;
  final String itemName;
  final num itemPrice;
  final String itemDescription;
  final String itemImageUrl;
  final int itemCount;
  final Function() onAdd;
  final Function() onRemove;
  final int index;
  final Function()? onImageTap;
  final String sCounterId;

  final String readmore = "Read More";
  String layoutBuilder(String itemDescription1, BuildContext context) {
    final span = TextSpan(text: itemDescription1);
    final tp =
        TextPainter(text: span, maxLines: 3, textDirection: TextDirection.ltr);
    tp.layout(
        maxWidth: MediaQuery.of(context).size.width *
            0.7); // equals the parent screen width

    if (tp.didExceedMaxLines) {
      return "Read";
    } else {
      return itemDescription1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height160 + 12,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.only(
          top: Dimensions.height20, bottom: Dimensions.height10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: AppColors.kBlack.withOpacity(0.1)))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FoodTypeTile(isVeg: itemIsVeg),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Dimensions.height4, bottom: Dimensions.height3),
                      child: Text(
                        itemName,
                        style: AppTextStyles.kRoboto50016Black
                            .copyWith(fontSize: Dimensions.fontSize15),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: Dimensions.height3),
                        child: Text(
                          '₹$itemPrice',
                          style: AppTextStyles.kOpenSans60016Black.copyWith(
                              fontSize: Dimensions.fontSize13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.kBlack.withOpacity(0.6)),
                        )),
                    layoutBuilder(itemDescription, context) == 'Read'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  itemDescription,
                                  maxLines: 3,
                                  style: AppTextStyles.kOpenSans40014Black
                                      .copyWith(
                                    fontSize: Dimensions.fontSize12,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  displayItemDescInBottomSheet(
                                      itemDescription, context, itemName);
                                },
                                child: Text(
                                  readmore,
                                  style: AppTextStyles.kOpenSans40014Black
                                      .copyWith(
                                    color: Colors.redAccent,
                                    fontSize: Dimensions.fontSize12,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Flexible(
                            child: Text(
                              itemDescription,
                              maxLines: 3,
                              style: AppTextStyles.kOpenSans40014Black.copyWith(
                                fontSize: Dimensions.fontSize12,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              Container(
                  width: Dimensions.foodTileWidth,
                  margin: EdgeInsets.only(left: Dimensions.width6),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      InkWell(
                        onTap: onImageTap,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius10),
                              child: Container(
                                height: Dimensions.height80,
                                width: Dimensions.width110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius10),
                                  color: Colors.grey.shade300,
                                ),
                                child: Container(
                                  height: Dimensions.height80,
                                  width: Dimensions.width110,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius10),
                                    border:
                                        Border.all(color: AppColors.kLightGrey),
                                    color: AppColors.kOrderSlot,
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/item_image_unavailable_1.png'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                //  CachedNetworkImage(
                                //   imageUrl: itemImageUrl,
                                //   fit: BoxFit.cover,
                                //   memCacheWidth: 135,
                                //   memCacheHeight: 180,
                                //   maxHeightDiskCache: 180,
                                //   maxWidthDiskCache: 135,
                                //   errorWidget: (context, url, error) {
                                //     // Logger.info("Error TO Load Image error : $error , url : $url");
                                //     return Container(
                                //       height: Dimensions.height80,
                                //       width: Dimensions.width110,
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(
                                //             Dimensions.radius10),
                                //         border: Border.all(
                                //             color: AppColors.kLightGrey),
                                //         color: AppColors.kOrderSlot,
                                //         image: const DecorationImage(
                                //           image: AssetImage(
                                //               'assets/images/item_image_unavailable_1.png'),
                                //           fit: BoxFit.contain,
                                //         ),
                                //       ),
                                //       child: const SizedBox(),
                                //     );
                                //   },
                                // ),
                              ),
                            ),
                            SizedBox(height: Dimensions.height15),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width14),
                            child: CounterButton(
                              count: '$itemCount',
                              onRemove: onRemove,
                              onAdd: onAdd,
                              onImagePage: false,
                            )),
                      ),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }

  displayItemDescInBottomSheet(
      String itemDescriptionText, BuildContext context, String itemName) {
    return showModalBottomSheet(
      isDismissible: true,
      useRootNavigator: true,
      enableDrag: false,
      constraints: BoxConstraints(maxHeight: Dimensions.screenHeight * 0.3),
      context: context,
      elevation: 2,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimensions.radius16),
        ),
      ),
      builder: (BuildContext context) {
        return CustomItemDescription(
            height: Dimensions.screenHeight * 0.25,
            itemIsVeg: itemIsVeg,
            itemName: itemName,
            itemDescription: itemDescription);
      },
    );
  }
}
