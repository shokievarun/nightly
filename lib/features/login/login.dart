import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightly/features/login/login_controller.dart';
import 'package:nightly/utils/common_widgets/custom_button.dart';
import 'package:nightly/utils/common_widgets/custom_otp.dart';
import 'package:nightly/utils/common_widgets/custom_text_field.dart';
import 'package:nightly/utils/common_widgets/loader.dart';
import 'package:nightly/utils/common_widgets/tag_widget.dart';
import 'package:nightly/utils/constants/app_assets.dart';
import 'package:nightly/utils/constants/app_colors.dart';
import 'package:nightly/utils/constants/app_strings.dart';
import 'package:nightly/utils/constants/dimensions.dart';
import 'package:nightly/utils/constants/keys.dart';
import 'package:nightly/utils/logging/app_logger.dart';

import '../../utils/constants/app_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const route = '/login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = Get.put(LoginController());
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    controller.enablePhoneField.value = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingWrapper(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          key: controller.globalkey,
          body: Padding(
            padding: EdgeInsets.fromLTRB(Dimensions.width20,
                Dimensions.height57, Dimensions.width20, Dimensions.height10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TagWidget(
                          iconImageUrl: controller.tagWidgetTitle.value ==
                                  AppStrings.bFoodCourt
                              ? AppAssetUrls.kFoodCourtIcon
                              : controller.tagWidgetTitle.value ==
                                      AppStrings.kAccount
                                  ? AppAssetUrls.sProfile
                                  : controller.tagWidgetTitle.value ==
                                          AppStrings.kRestaurant
                                      ? AppAssetUrls.sRestaurant
                                      : controller.tagWidgetTitle.value ==
                                              AppStrings.kApartment
                                          ? AppAssetUrls.sApartment
                                          : AppAssetUrls.sHome,
                          title: controller.tagWidgetTitle.value,
                        ),
                        SizedBox(height: Dimensions.height20),
                        RichText(
                          text: TextSpan(
                            text: AppStrings.kAppWelcomeTitle,
                            style: AppTextStyles.kRoboto40030Black,
                            children: <TextSpan>[
                              TextSpan(
                                  text: AppStrings.kAppTitle,
                                  style: AppTextStyles.kRoboto60030Black),
                              controller.navigateToTab.value.isEmpty
                                  ? const TextSpan()
                                  : TextSpan(
                                      text: controller.navigateToTab.value,
                                      style: AppTextStyles.kRoboto40030Black
                                          .copyWith(height: 1.5)),
                            ],
                          ),
                        ),
                        Text(
                          AppStrings.kLetsGetStarted,
                          style: AppTextStyles.kOpenSans40016Grey
                              .copyWith(height: 2),
                        ),
                        SizedBox(height: Dimensions.height12),
                        CustomTextField(
                          selectedCountryCode: controller.selectedCode.value,
                          textFieldKey: const Key(AppKeys.kTextFieldKey),
                          phoneCodeKey: const Key(AppKeys.kPhoneCodeKey),
                          controller: _phoneController,
                          maxLength: 10,
                          hint: AppStrings.kEnterMobileNumber,
                          showPhoneCodes: true,
                          enabled: controller.enablePhoneField.value,
                          textInputType: TextInputType.phone,
                          readOnly: !controller.enablePhoneField.value,
                          onChanged: (String phoneText) async {
                            await controller.validatePhoneNumber(phoneText);
                          },
                        ),
                        controller.showNoWidget.value
                            ? const SizedBox()
                            : controller.isCustomerExist.value
                                ? const SizedBox()
                                : SizedBox(height: Dimensions.height12),
                        controller.showNoWidget.value
                            ? const SizedBox()
                            : controller.isCustomerExist.value
                                ? const SizedBox()
                                : CustomTextField(
                                    controller: _nameController,
                                    hint: AppStrings.kEnteYourName,
                                    showPhoneCodes: false,
                                    textInputType: TextInputType.name,
                                    readOnly: controller.otpSent.value,
                                    onChanged: (String name) {
                                      controller.validateName(name);
                                    },
                                  ),
                        controller.showNoWidget.value
                            ? const SizedBox()
                            : controller.isCustomerExist.value
                                ? const SizedBox()
                                : SizedBox(height: Dimensions.height12),
                        controller.showNoWidget.value
                            ? const SizedBox()
                            : controller.isCustomerExist.value
                                ? const SizedBox()
                                : CustomTextField(
                                    controller: _emailController,
                                    hint: AppStrings.kEnterYourEmail,
                                    showPhoneCodes: false,
                                    textInputType: TextInputType.emailAddress,
                                    readOnly: controller.otpSent.value,
                                    onChanged: (String emailText) {
                                      controller.validateEmail(emailText);
                                    },
                                  ),
                        controller.showNoWidget.value
                            ? const SizedBox()
                            : controller.isCustomerExist.value
                                ? const SizedBox()
                                : SizedBox(height: Dimensions.height8),
                        controller.showNoWidget.value
                            ? const SizedBox()
                            : controller.isCustomerExist.value
                                ? const SizedBox()
                                : Row(children: <Widget>[
                                    ValueBuilder<bool?>(
                                        initialValue: false,
                                        builder: (value, updateFn) => Obx(
                                              () => Checkbox(
                                                value: controller
                                                    .isPrivacyPolicyAccepted
                                                    .value,
                                                onChanged: (value) {
                                                  Logger.info('value $value');
                                                  controller
                                                      .isPrivacyPolicyAccepted
                                                      .value = value!;

                                                  Logger.info(
                                                      'value after $value');
                                                },
                                              ),
                                            )
                                        // onUpdate: (value) {
                                        //   Logger.info("bbbbab${value}");
                                        // },
                                        ),
                                    Expanded(
                                        child: Wrap(children: [
                                      const Text(
                                          "I have read and agree to the "),
                                      InkWell(
                                        onTap: () {
                                          // Get.to(() => privacypolicyscreen());
                                        },
                                        child: const Text("Privacy Policy ",
                                            style: TextStyle(
                                                color: AppColors.kBlue)),
                                      ),
                                      const Text("and "),
                                      InkWell(
                                        onTap: () {
                                          //    Get.to(() => termsandcondition());
                                        },
                                        child: const Text(
                                            "Terms and Conditions ",
                                            style: TextStyle(
                                                color: AppColors.kBlue)),
                                      ),
                                    ]))
                                  ]),
                        SizedBox(height: Dimensions.height12),
                        // controller.otpSent.value
                        // ?
                        CustomOtpField(
                            height: controller.otpSent.value ? null : 0,
                            key: const Key(AppKeys.kOtpFieldKey),
                            textController: controller.otpController,
                            onChanged: (String otpText) {
                              Logger.info("OTP PINPUT - $otpText");
                              controller.validateOtp(otpText);
                            },
                            showError: controller.showOtpInvalid.value,
                            disableOtpResend:
                                controller.currentTimerValue.value == 0
                                    ? false
                                    : true,
                            onOtpResend: () {
                              controller.otpController.clear();
                              controller.sendOtp(
                                  _phoneController.text.trim(), "");
                            },
                            onComplete: (String otpval) {
                              Logger.info("OTP PINPUT - $otpval");
                              controller.verifyOtp(
                                  _phoneController.text.trim(),
                                  otpval,
                                  _nameController.text.trim(),
                                  _emailController.text.trim(),
                                  controller.isPrivacyPolicyAccepted.value);
                            })
                        // : const SizedBox(),
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  key: const Key(AppKeys.kPrimaryButtonKey),
                  enabled: controller.isCustomerExist.isFalse
                      ?
                      //? Check if phone, name & email texts are validated during signup
                      controller.isPhoneValid.value &&
                          controller.isEmailValid.value &&
                          controller.isNameValid.value &&
                          controller.isEmailValid.value &&
                          controller.isPrivacyPolicyAccepted.value
                      :
                      //? Check if phone text is validated during login
                      controller.isPhoneValid.value,
                  buttonTitle: controller.otpSent.value
                      ? controller.isCustomerExist.value
                          ? AppStrings.kSignIn
                          : AppStrings.kSignUp
                      : AppStrings.kGetOtp,
                  onPressed: () async {
                    if (controller.otpSent.value) {
                      if (controller.otpSent.value &&
                          controller.otpVerified.isFalse) {
                        controller.verifyOtp(
                            _phoneController.text.trim(),
                            controller.otpController.text,
                            _nameController.text.trim(),
                            _emailController.text.trim(),
                            controller.isPrivacyPolicyAccepted.value);
                      }
                    } else {
                      if (!controller.isCustomerExist.value) {
                        await controller.registerUser(
                            _nameController.text.trim(),
                            _emailController.text.trim(),
                            _phoneController.text.trim());
                      }
                      controller.sendOtp(_phoneController.text.trim(),
                          _emailController.text.trim());
                    }
                  },
                  //isSecondaryButton: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
