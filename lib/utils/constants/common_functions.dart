import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightly/utils/constants/app_colors.dart';
import 'package:nightly/utils/constants/app_styles.dart';
import 'package:nightly/utils/constants/dimensions.dart';

showCustomStatusSnackBar({
  required String text,
  required Color backgroundColor,
  required String iconPath,
  Color iconBackgroundColor = AppColors.kWhite,
  double? scale,
  double iconHeight = 10,
  double iconWidth = 10,
  double textFontSize = 12,
  Color textColor = AppColors.kWhite,
}) {
  return Get.showSnackbar(GetSnackBar(
    isDismissible: true,
    animationDuration: const Duration(milliseconds: 200),
    dismissDirection: DismissDirection.down,
    duration: const Duration(seconds: 2),
    maxWidth: Dimensions.width303,
    backgroundColor: backgroundColor,
    snackStyle: SnackStyle.FLOATING,
    borderRadius: Dimensions.radius8,
    margin: EdgeInsets.fromLTRB(
        Dimensions.width20, 0, Dimensions.width20, Dimensions.height40),
    messageText: Row(
      children: [
        SizedBox(
          height: Dimensions.height30,
          width: Dimensions.width31 - 1,
          child: CircleAvatar(
            backgroundColor: iconBackgroundColor,
            child: SizedBox(
              width: iconWidth,
              height: iconHeight,
              child: Image.asset(
                iconPath,
                scale: scale,
              ),
            ),
          ),
        ),
        SizedBox(width: Dimensions.width20),
        Flexible(
          child: Text(
            text,
            maxLines: 2,
            style: AppTextStyles.kOpenSans60014DarkGrey.copyWith(
                fontSize: textFontSize, color: textColor, height: 1.5),
          ),
        ),
      ],
    ),
  ));
}
