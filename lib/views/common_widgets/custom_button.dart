import 'package:flutter/material.dart';
import 'package:nightly/utils/constants/app_colors.dart';
import 'package:nightly/utils/constants/app_styles.dart';
import 'package:nightly/utils/constants/dimensions.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.buttonTitle,
    required this.onPressed,
    this.imageIconUrl = '',
    this.enabled = true,
    this.isSecondaryButton = false,
    this.enablePadding = false,
    this.padding,
    this.color,
    this.isShadow = false,
    this.maxLines = 1,
    this.isOrderPage = false,
    Key? key,
  }) : super(key: key);

  final String buttonTitle;
  final Function() onPressed;
  final bool enabled;
  final String imageIconUrl;
  final bool isSecondaryButton;
  final bool enablePadding;
  final Color? color;
  final EdgeInsets? padding;
  final bool isShadow;
  final int maxLines;
  final bool isOrderPage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: key,
      onTap: enabled ? onPressed : () {},
      child: Container(
        height: Dimensions.buttonHeight52,
        width: double.infinity,
        margin: enablePadding
            ? EdgeInsets.symmetric(horizontal: Dimensions.width20)
            : EdgeInsets.zero,
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: Dimensions.width20),
        decoration: BoxDecoration(
          boxShadow: isShadow
              ? [
                  const BoxShadow(
                    offset: Offset(2, 2),
                    blurRadius: 12,
                    color: Color.fromRGBO(0, 0, 0, 0.16),
                  )
                ]
              : [],
          color: color ??
              (enabled
                  ? isSecondaryButton
                      ? AppColors.kGrey
                      : AppColors.kYellowPrimary
                  : isSecondaryButton
                      ? AppColors.kGrey.withOpacity(0.2)
                      : AppColors.kYellowSecondary),
          borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageIconUrl.isNotEmpty
                ? SizedBox(
                    height: Dimensions.height20,
                    width: Dimensions.width20,
                    child: Image.asset(imageIconUrl),
                  )
                : const SizedBox(),
            imageIconUrl.isNotEmpty && isOrderPage == false
                ? SizedBox(
                    width: Dimensions.width12,
                  )
                : const SizedBox(),
            Flexible(
              child: Center(
                child: Text(
                  buttonTitle,
                  textAlign: TextAlign.center,
                  style: enabled
                      ? isSecondaryButton
                          ? AppTextStyles.kRoboto60016Grey
                          : AppTextStyles.kRoboto60016Black
                      : AppTextStyles.kRoboto60016Grey,
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
