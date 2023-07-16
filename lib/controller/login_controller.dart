import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nightly/extensions/common_extensions.dart';
import 'package:nightly/repositries/login_service.dart';
import 'package:nightly/models/user_model.dart';

import 'package:nightly/utils/constants/app_strings.dart';

import 'package:nightly/utils/constants/country_codes.dart';

import 'package:nightly/utils/logging/app_logger.dart';

///Auth Controller
class LoginController {
  ///initializing variables for auth controller
  bool isPhoneValid = false;
  bool isNameValid = false;
  bool isEmailValid = false;
  bool isOtpValid = false;

  bool otpSent = false;
  bool otpVerified = false;

  bool showNoWidget = true;
  bool isCustomerExist = false;

  bool showOtpInvalid = false;

  bool enablePhoneField = true;
  bool isLoading = false;
  String navigateToTab = AppStrings.kFoodCourts;
  String tagWidgetTitle = AppStrings.bFoodCourt;
  List countryCodes = CountryCodes.countryCodes['countries']!;
  TextEditingController countryCodeSearchController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String selectedCode = '+91';
  int currentTimerValue = 30;
  late Timer timer;
  final globalkey = GlobalKey<FormState>();
  bool isPrivacyPolicyAccepted = false;

  // @override
  // void onInit() {
  //   super.onInit();
  //   otpautodetect();
  // }

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
      } else {
        countryCodes.clear();
      }
    } else {
      countryCodes = CountryCodes.countryCodes['countries']!;
    }
  }

  //* Phone textfield data validation
  Future<void> validatePhoneNumber(String inputText) async {
    if (inputText.isNumericOnly) {
      if (inputText.trim().length == 10) {
        otpSent = false;
        await checkIfCustomerExist(inputText.trim());
        isPhoneValid = true;
      } else {
        isPhoneValid = false;
        showNoWidget = true;
      }
    } else {
      isPhoneValid = false;
    }
  }

  //* OTP textfield data validation
  void validateOtp(String inputText) {
    showOtpInvalid = false;
    if (inputText.isNumericOnly && inputText.length == 6) {
      isOtpValid = true;
    } else {
      isOtpValid = false;
    }
  }

  //* Name textfield data validation
  void validateName(String inputText) {
    if (inputText.isEmpty) {
      isNameValid = false;
    } else {
      isNameValid = true;
    }
  }

  //* Email textfield data validation
  void validateEmail(String inputText) {
    // if (RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(inputText))
    if (inputText.isValidEmail()) {
      //isEmailValid = true;
      if (inputText.contains("icicihfc.com")) {
        isEmailValid = false;
      } else {
        if ('@'.allMatches(inputText).length > 1) {
          isEmailValid = false;
        } else {
          isEmailValid = true;
        }
      }
    } else {
      isEmailValid = false;
    }
  }

  ///function to check if customer exist or not
  Future<void> checkIfCustomerExist(String phoneNumber) async {
    try {
      final bool model = await loginService.checkUserExists(phoneNumber.trim());
      Logger.info("checkIfCustomerExist : $model");
      if (model) {
        isCustomerExist = true;
      } else {
        isCustomerExist = false;
        showNoWidget = false;
      }
      Logger.info("checkIfCustomerExist : $isCustomerExist");
    } catch (error, stackTrace) {
      Logger.error(error.toString(), stackTrace);
      isCustomerExist = false;
    }
  }

  ///function to send otp
  void sendOtp(String phoneNumber, String email) async {
    if (isPhoneValid) {
      isLoading = true;
      enablePhoneField = false;
      bool responseMessage = await loginService.loginUser(phoneNumber.trim());
      if (responseMessage) {
        otpSent = true;
        isLoading = false;
        resetAndStartTimer();
      } else {
        isLoading = false;
      }
    }
  }

  Future<bool> registerUser(String name, String email, String number) async {
    return await loginService.registerUser(name, email, number);
  }

  ///function to verfy otp
  void verifyOtp(String phoneNumber, String otp, String name, String email,
      bool isPrivacyPolicyAccepted, BuildContext context) async {
    try {
      if (isPhoneValid && isCustomerExist
          ? true
          : isNameValid && isCustomerExist
              ? true
              : isEmailValid && isOtpValid) {
        isLoading = true;
        UserModel? userModel =
            await loginService.verifyOTP(phoneNumber, int.parse(otp));

        if (userModel != null) {
          showOtpInvalid = false;
          otpVerified = true;

          // try {
          //   await FCMNotificationManager
          //       .registerDeviceWithMemberForNotifications();
          // } catch (error, stackTrace) {
          //   Logger.error(error.toString(), stackTrace);
          // }

          resetValues();
          isLoading = false;
          otpController.clear();
          context.go('/restaurant');
          //  Navigator.of(context).pop();
          if (!isCustomerExist) {
          } else {}
        } else {
          showOtpInvalid = true;
        }
        enablePhoneField = true;
        isLoading = false;
      }
    } catch (error, stackTrace) {
      Logger.error(error.toString(), stackTrace);
    }
    isLoading = false;
  }

  ///function to reset and start timer
  void resetAndStartTimer() {
    currentTimerValue = 30;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentTimerValue == 0) {
        timer.cancel();
        enablePhoneField = true;
      } else {
        currentTimerValue--;
      }
    });
  }

  ///function to reset the values
  void resetValues() {
    otpSent = false;
    otpVerified = false;
    isPhoneValid = false;
    showNoWidget = true;
  }
}
