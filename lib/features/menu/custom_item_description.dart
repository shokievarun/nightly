import 'package:flutter/material.dart';
import 'package:nightly/features/menu/food_type.dart';
import 'package:nightly/utils/constants/app_colors.dart';
import 'package:nightly/utils/constants/app_styles.dart';
import 'package:nightly/utils/constants/dimensions.dart';

class CustomItemDescription extends StatelessWidget {
  const CustomItemDescription(
      {required this.itemIsVeg,
      required this.itemName,
      required this.itemDescription,
      required this.height,
      Key? key})
      : super(key: key);
  final bool itemIsVeg;
  final String itemName;
  final String itemDescription;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: Dimensions.height8),
        Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: height, //Get.height * 0.26,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  padding: const EdgeInsets.only(left: 4.0, right: 4, top: 4),
                  child: Container(
                    color: AppColors.kGrey,
                    height: 1,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.all(Dimensions.height3),
                      child: Text(
                        itemDescription,
                        style: AppTextStyles.kOpenSans40014Black.copyWith(
                          fontSize: Dimensions.fontSize12,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
