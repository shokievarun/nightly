import 'package:flutter/material.dart';
import 'package:nightly/controller/login_controller.dart';
import 'package:nightly/views/common_widgets/custom_button.dart';
import 'package:nightly/views/common_widgets/custom_otp.dart';
import 'package:nightly/views/common_widgets/custom_text_field.dart';
import 'package:nightly/views/common_widgets/loader.dart';
import 'package:nightly/views/common_widgets/tag_widget.dart';
import 'package:nightly/utils/constants/app_assets.dart';
import 'package:nightly/utils/constants/app_colors.dart';
import 'package:nightly/utils/constants/app_strings.dart';
import 'package:nightly/utils/constants/dimensions.dart';
import 'package:nightly/utils/constants/keys.dart';
import 'package:nightly/utils/logging/app_logger.dart';

import '../utils/constants/app_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const route = '/login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = LoginController();
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    controller.enablePhoneField = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        key: controller.globalkey,
        body: Padding(
          padding: EdgeInsets.fromLTRB(Dimensions.width20, Dimensions.height57,
              Dimensions.width20, Dimensions.height10),
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
                        iconImageUrl: controller.tagWidgetTitle ==
                                AppStrings.bFoodCourt
                            ? AppAssetUrls.kFoodCourtIcon
                            : controller.tagWidgetTitle == AppStrings.kAccount
                                ? AppAssetUrls.sProfile
                                : controller.tagWidgetTitle ==
                                        AppStrings.kRestaurant
                                    ? AppAssetUrls.sRestaurant
                                    : controller.tagWidgetTitle ==
                                            AppStrings.kApartment
                                        ? AppAssetUrls.sApartment
                                        : AppAssetUrls.sHome,
                        title: controller.tagWidgetTitle,
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
                            controller.navigateToTab.isEmpty
                                ? const TextSpan()
                                : TextSpan(
                                    text: controller.navigateToTab,
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
                        selectedCountryCode: controller.selectedCode,
                        textFieldKey: const Key(AppKeys.kTextFieldKey),
                        phoneCodeKey: const Key(AppKeys.kPhoneCodeKey),
                        controller: _phoneController,
                        maxLength: 10,
                        hint: AppStrings.kEnterMobileNumber,
                        showPhoneCodes: true,
                        enabled: controller.enablePhoneField,
                        textInputType: TextInputType.phone,
                        readOnly: !controller.enablePhoneField,
                        onChanged: (String phoneText) async {
                          await controller.validatePhoneNumber(phoneText);
                        },
                      ),
                      controller.showNoWidget
                          ? const SizedBox()
                          : controller.isCustomerExist
                              ? const SizedBox()
                              : SizedBox(height: Dimensions.height12),
                      controller.showNoWidget
                          ? const SizedBox()
                          : controller.isCustomerExist
                              ? const SizedBox()
                              : CustomTextField(
                                  controller: _nameController,
                                  hint: AppStrings.kEnteYourName,
                                  showPhoneCodes: false,
                                  textInputType: TextInputType.name,
                                  readOnly: controller.otpSent,
                                  onChanged: (String name) {
                                    controller.validateName(name);
                                  },
                                ),
                      controller.showNoWidget
                          ? const SizedBox()
                          : controller.isCustomerExist
                              ? const SizedBox()
                              : SizedBox(height: Dimensions.height12),
                      controller.showNoWidget
                          ? const SizedBox()
                          : controller.isCustomerExist
                              ? const SizedBox()
                              : CustomTextField(
                                  controller: _emailController,
                                  hint: AppStrings.kEnterYourEmail,
                                  showPhoneCodes: false,
                                  textInputType: TextInputType.emailAddress,
                                  readOnly: controller.otpSent,
                                  onChanged: (String emailText) {
                                    controller.validateEmail(emailText);
                                  },
                                ),
                      controller.showNoWidget
                          ? const SizedBox()
                          : controller.isCustomerExist
                              ? const SizedBox()
                              : SizedBox(height: Dimensions.height8),
                      controller.showNoWidget
                          ? const SizedBox()
                          : controller.isCustomerExist
                              ? const SizedBox()
                              : Row(children: <Widget>[
                                  // ValueBuilder<bool?>(
                                  //     initialValue: false,
                                  //     builder: (value, updateFn) =>
                                  Checkbox(
                                    value: controller.isPrivacyPolicyAccepted,
                                    onChanged: (value) {
                                      Logger.info('value $value');
                                      controller.isPrivacyPolicyAccepted =
                                          value!;

                                      Logger.info('value after $value');
                                    },
                                  ),
                                  //)
                                  // onUpdate: (value) {
                                  //   Logger.info("bbbbab${value}");
                                  // },
                                  // ,
                                  Expanded(
                                      child: Wrap(children: [
                                    const Text("I have read and agree to the "),
                                    InkWell(
                                      onTap: () {},
                                      child: const Text("Privacy Policy ",
                                          style: TextStyle(
                                              color: AppColors.kBlue)),
                                    ),
                                    const Text("and "),
                                    InkWell(
                                      onTap: () {},
                                      child: const Text("Terms and Conditions ",
                                          style: TextStyle(
                                              color: AppColors.kBlue)),
                                    ),
                                  ]))
                                ]),
                      SizedBox(height: Dimensions.height12),
                      // controller.otpSent
                      // ?
                      CustomOtpField(
                          height: controller.otpSent ? null : 0,
                          key: const Key(AppKeys.kOtpFieldKey),
                          textController: controller.otpController,
                          onChanged: (String otpText) {
                            Logger.info("OTP PINPUT - $otpText");
                            controller.validateOtp(otpText);
                          },
                          showError: controller.showOtpInvalid,
                          disableOtpResend:
                              controller.currentTimerValue == 0 ? false : true,
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
                                controller.isPrivacyPolicyAccepted,
                                context);
                          })
                      // : const SizedBox(),
                    ],
                  ),
                ),
              ),
              CustomButton(
                key: const Key(AppKeys.kPrimaryButtonKey),
                enabled: !controller.isCustomerExist
                    ?
                    //? Check if phone, name & email texts are validated during signup
                    controller.isPhoneValid &&
                        controller.isEmailValid &&
                        controller.isNameValid &&
                        controller.isEmailValid &&
                        controller.isPrivacyPolicyAccepted
                    :
                    //? Check if phone text is validated during login
                    controller.isPhoneValid,
                buttonTitle: controller.otpSent
                    ? controller.isCustomerExist
                        ? AppStrings.kSignIn
                        : AppStrings.kSignUp
                    : AppStrings.kGetOtp,
                onPressed: () async {
                  if (controller.otpSent) {
                    if (controller.otpSent && !controller.otpVerified) {
                      controller.verifyOtp(
                          _phoneController.text.trim(),
                          controller.otpController.text,
                          _nameController.text.trim(),
                          _emailController.text.trim(),
                          controller.isPrivacyPolicyAccepted,
                          context);
                    }
                  } else {
                    if (!controller.isCustomerExist) {
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
    );
  }
}
