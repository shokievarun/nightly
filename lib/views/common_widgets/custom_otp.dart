import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightly/controller/login_controller.dart';
import 'package:nightly/utils/constants/app_colors.dart';
import 'package:nightly/utils/constants/app_strings.dart';
import 'package:nightly/utils/constants/dimensions.dart';
import 'package:pinput/pinput.dart';

import '../../utils/constants/app_styles.dart';
// import 'package:pinput/pinput.dart';

class CustomOtpField extends GetView<LoginController> {
  const CustomOtpField({
    required this.textController,
    required this.onChanged,
    required this.onOtpResend,
    required this.onComplete,
    this.height,
    this.enabled = true,
    this.showError = false,
    this.disableOtpResend = true,
    Key? key,
  }) : super(key: key);

  final TextEditingController textController;
  final double? height;
  final Function(String) onChanged;
  final bool enabled;
  final bool showError;
  final bool disableOtpResend;
  final void Function() onOtpResend;
  final void Function(String)? onComplete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OTP',
            style: enabled
                ? AppTextStyles.kOpenSans60016Black
                : AppTextStyles.kOpenSans60016Black
                    .copyWith(color: AppColors.kBlack.withOpacity(0.5)),
          ),
          SizedBox(height: Dimensions.height10),
          Pinput(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            length: 6,
            controller: textController,
            onChanged: onChanged,
            //autofocus: true,
            keyboardType: TextInputType.number,
            androidSmsAutofillMethod:
                AndroidSmsAutofillMethod.smsUserConsentApi,
            onCompleted: onComplete,
            defaultPinTheme: PinTheme(
                width: Dimensions.width35,
                height: Dimensions.height39,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.kBlack),
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          showError
              ? Padding(
                  padding: EdgeInsets.only(bottom: Dimensions.height10),
                  child: const Text(
                    AppStrings.kEnterValidOtp,
                    style: TextStyle(color: AppColors.kErrorRed),
                  ),
                )
              : const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: disableOtpResend ? null : onOtpResend,
                child: Text(
                  AppStrings.kResendOtp,
                  style: AppTextStyles.kRoboto50016Black.copyWith(
                      color: disableOtpResend
                          ? AppColors.kBlue.withOpacity(0.5)
                          : AppColors.kBlue),
                ),
              ),
              Obx(
                () => Text(
                  '00:' +
                      '${controller.currentTimerValue.value}'.padLeft(2, '0'),
                  style: AppTextStyles.kOpenSans40012Black.copyWith(
                      color: AppColors.kBlack.withOpacity(0.6), fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
