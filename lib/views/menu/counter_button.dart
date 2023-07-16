import 'package:flutter/material.dart';
import 'package:nightly/utils/constants/app_colors.dart';
import 'package:nightly/utils/constants/app_styles.dart';
import 'package:nightly/utils/constants/dimensions.dart';

class CounterButton extends StatelessWidget {
  const CounterButton(
      {Key? key,
      required this.count,
      required this.onRemove,
      required this.onAdd,
      required this.onImagePage,
      this.isEditable = true})
      : super(key: key);

  final String count;
  final Function() onRemove;
  final Function() onAdd;
  final bool onImagePage;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    // Logger.info("CounterButton $count");
    return Container(
      //height: 32,
      height: onImagePage ? 50 : 32,
      decoration: BoxDecoration(
        color: count != '0' ? AppColors.kCartSnackBarColor : AppColors.kWhite,
        border: Border.all(
            color: count != '0'
                ? AppColors.kCartSnackBarColor
                : AppColors.kYellowBorderColor),
        borderRadius: BorderRadius.circular(4),
      ),
      child: count == '0'
          ? InkWell(
              onTap: onAdd,
              child: Center(
                  child: Text(
                'ADD',
                style: AppTextStyles.kRoboto70014Black.copyWith(
                    color: AppColors.kOfferTextColor,
                    fontSize: Dimensions.fontSize14),
              )),
            )
          : Container(
              color: count != '0'
                  ? AppColors.kCartSnackBarColor
                  : isEditable
                      ? AppColors.kWhite
                      : AppColors.kDisabledGrey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: onRemove,
                      child: Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.remove,
                          size: Dimensions.height15,
                          color: count != '0'
                              ? AppColors.kWhite
                              : AppColors.kCartSnackBarColor,
                          //  color: AppColors.kBlack.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    count,
                    style: AppTextStyles.kRoboto70014Black.copyWith(
                        color: count != '0'
                            ? AppColors.kWhite
                            : AppColors.kCartSnackBarColor,
                        fontSize: Dimensions.fontSize14),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: onAdd,
                      child: Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.add,
                          size: Dimensions.height15,
                          color: count != '0'
                              ? AppColors.kWhite
                              : AppColors.kCartSnackBarColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
      // ),
    );
  }
}
