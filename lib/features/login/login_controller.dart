import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightly/controller/main_controller.dart';
import 'package:nightly/extensions/common_extensions.dart';
import 'package:nightly/features/login/login_service.dart';
import 'package:nightly/utils/constants/app_colors.dart';
import 'package:nightly/utils/constants/app_strings.dart';
import 'package:nightly/utils/constants/common_functions.dart';
import 'package:nightly/utils/constants/country_codes.dart';
import 'package:nightly/utils/constants/dimensions.dart';
import 'package:nightly/utils/logging/app_logger.dart';

///Auth Controller
class LoginController extends GetxController {
  final MainController _mainController = Get.find();

  ///initializing variables for auth controller
  RxBool isPhoneValid = false.obs;
  RxBool isNameValid = false.obs;
  RxBool isEmailValid = false.obs;
  RxBool isOtpValid = false.obs;

  RxBool otpSent = false.obs;
  RxBool otpVerified = false.obs;

  RxBool showNoWidget = true.obs;
  RxBool isCustomerExist = false.obs;

  RxBool showOtpInvalid = false.obs;

  RxBool enablePhoneField = true.obs;
  RxBool isLoading = false.obs;
  RxString navigateToTab = AppStrings.kFoodCourts.obs;
  RxString tagWidgetTitle = AppStrings.bFoodCourt.obs;
  List countryCodes = CountryCodes.countryCodes['countries']!;
  TextEditingController countryCodeSearchController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  RxString selectedCode = '+91'.obs;
  RxInt currentTimerValue = 30.obs;
  late Timer timer;
  final globalkey = GlobalKey<FormState>();
  RxBool isPrivacyPolicyAccepted = false.obs;

  @override
  void onInit() {
    super.onInit();
    otpautodetect();
  }

  void otpautodetect() {
    otpController.addListener(() {});
  }

  ///function to search county code
  ///function to search county code

  void searchCountryCodes(String searchText) {
    final List filteredCountryCodes = [];
    if (searchText.isNotEmpty) {
      for (var element in countryCodes) {
        if (element['code']
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            element['name']
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase())) {
          filteredCountryCodes.add(element);
        }
      }
      if (filteredCountryCodes.isNotEmpty) {
        countryCodes = filteredCountryCodes;
        update();
      } else {
        countryCodes.clear();
        update();
      }
    } else {
      countryCodes = CountryCodes.countryCodes['countries']!;
      update();
    }
  }

  //* Phone textfield data validation
  Future<void> validatePhoneNumber(String inputText) async {
    if (inputText.isNumericOnly) {
      if (inputText.trim().length == 10) {
        otpSent.value = false;
        await checkIfCustomerExist(inputText.trim());
        isPhoneValid.value = true;
      } else {
        isPhoneValid.value = false;
        showNoWidget.value = true;
      }
    } else {
      isPhoneValid.value = false;
    }
  }

  //* OTP textfield data validation
  void validateOtp(String inputText) {
    showOtpInvalid.value = false;
    if (inputText.isNumericOnly && inputText.length == 6) {
      isOtpValid.value = true;
    } else {
      isOtpValid.value = false;
    }
  }

  //* Name textfield data validation
  void validateName(String inputText) {
    if (inputText.isEmpty) {
      isNameValid.value = false;
    } else {
      isNameValid.value = true;
    }
  }

  //* Email textfield data validation
  void validateEmail(String inputText) {
    // if (RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(inputText))
    if (inputText.isValidEmail()) {
      //isEmailValid.value = true;
      if (inputText.contains("icicihfc.com")) {
        isEmailValid.value = false;
        showCustomStatusSnackBar(
          backgroundColor: AppColors.kErrorRed,
          text: 'Login with your email id', //'Login with personal email id',
          iconPath: "",
          iconHeight: Dimensions.height20,
          iconWidth: Dimensions.height20,
          iconBackgroundColor: AppColors.kWhite,
          textFontSize: 15,
          textColor: AppColors.kWhite,
        );
      } else {
        if ('@'.allMatches(inputText).length > 1) {
          isEmailValid.value = false;
          showCustomStatusSnackBar(
            backgroundColor: AppColors.kErrorRed,
            text: 'Enter correct email id',
            iconPath: "",
            iconHeight: Dimensions.height20,
            iconWidth: Dimensions.height20,
            iconBackgroundColor: AppColors.kWhite,
            textFontSize: 15,
            textColor: AppColors.kWhite,
          );
        } else {
          isEmailValid.value = true;
        }
      }
    } else {
      isEmailValid.value = false;
    }
  }

  ///function to check if customer exist or not
  Future<void> checkIfCustomerExist(String phoneNumber) async {
    try {
      final bool model = await loginService.checkUserExists(phoneNumber.trim());
      Logger.info("checkIfCustomerExist : $model");
      if (model) {
        isCustomerExist.value = true;
      } else {
        isCustomerExist.value = false;
        showNoWidget.value = false;
      }
      Logger.info("checkIfCustomerExist : ${isCustomerExist.value}");
    } catch (error, stackTrace) {
      Logger.error(error.toString(), stackTrace);
      isCustomerExist.value = false;
    }
  }

  ///function to send otp
  void sendOtp(String phoneNumber, String email) async {
    if (isPhoneValid.value) {
      isLoading.value = true;
      enablePhoneField.value = false;
      bool responseMessage = await loginService.loginUser(phoneNumber.trim());
      if (responseMessage) {
        otpSent.value = true;
        isLoading.value = false;
        resetAndStartTimer();
      }
    }
  }

  ///function to verfy otp
  void verifyOtp(String phoneNumber, String otp, String name, String email,
      bool isPrivacyPolicyAccepted) async {
    try {
      if (isPhoneValid.value && isCustomerExist.value
          ? true
          : isNameValid.value && isCustomerExist.value
              ? true
              : isEmailValid.value && isOtpValid.value) {
        isLoading.value = true;
        await loginService.verifyOTP(phoneNumber, int.parse(otp));

        if (_mainController.userModel != null) {
          showOtpInvalid.value = false;
          otpVerified.value = true;

          // try {
          //   await FCMNotificationManager
          //       .registerDeviceWithMemberForNotifications();
          // } catch (error, stackTrace) {
          //   Logger.error(error.toString(), stackTrace);
          // }

          resetValues();
          isLoading.value = false;
          otpController.clear();
          if (!isCustomerExist.value) {
          } else {}
        } else {
          showOtpInvalid.value = true;
        }
        enablePhoneField.value = true;
        isLoading.value = false;
      }
    } catch (error, stackTrace) {
      Logger.error(error.toString(), stackTrace);
    }
    isLoading.value = false;
  }

  ///function to reset and start timer
  void resetAndStartTimer() {
    currentTimerValue.value = 30;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentTimerValue.value == 0) {
        timer.cancel();
        enablePhoneField.value = true;
      } else {
        currentTimerValue.value--;
      }
    });
  }

  ///function to reset the values
  void resetValues() {
    otpSent.value = false;
    otpVerified.value = false;
    isPhoneValid.value = false;
    showNoWidget.value = true;
  }

  ///dispose function
  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }
}
