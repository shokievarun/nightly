import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nightly/utils/constants/app_colors.dart';
import 'package:nightly/utils/constants/app_styles.dart';
import 'package:nightly/utils/constants/dimensions.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.hint,
    required this.onChanged,
    this.errorMessage = '',
    this.textInputType,
    this.onTap,
    this.readOnly = false,
    this.controller,
    this.validator,
    this.maxLength = 100,
    this.initialValue,
    this.maxLines = 1,
    this.minLines = 1,
    this.textInputAction,
    this.labelSuffixIcon = const SizedBox(),
    this.showPhoneCodes = false,
    this.autofocus = false,
    this.enabled = true,
    this.textFieldKey,
    this.textCapitalization = TextCapitalization.sentences,
    this.phoneCodeKey,
    this.selectedCountryCode = '+91',
    this.prefixIcon,
    this.contentPadding,
    this.borderColor,
    this.inputFormatters,
    this.prefixText,
    this.prefixIconConstraints,
    this.hintStyle,
  }) : super(key: textFieldKey);

  final Key? textFieldKey;
  final Key? phoneCodeKey;
  final String hint;
  final String errorMessage;
  final Function(String) onChanged;
  final TextInputType? textInputType;
  final Function()? onTap;
  final bool readOnly;
  final bool enabled;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int maxLength;
  final String? initialValue;
  final int maxLines;
  final int minLines;
  final TextInputAction? textInputAction;
  final Widget labelSuffixIcon;
  final bool showPhoneCodes;
  final bool autofocus;
  final String selectedCountryCode;
  final TextCapitalization textCapitalization;
  final Widget? prefixIcon;
  final EdgeInsets? contentPadding;
  final Color? borderColor;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final BoxConstraints? prefixIconConstraints;
  final TextStyle? hintStyle;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: textFieldKey,
      onChanged: onChanged,
      controller: controller,
      textCapitalization: textCapitalization,
      autofocus: autofocus,
      enabled: enabled,
      style: enabled
          ? AppTextStyles.kOpenSans60014DarkGrey
              .copyWith(color: const Color(0xff000000))
          : AppTextStyles.kOpenSans40014Black,
      maxLength: maxLength,
      initialValue: controller == null ? initialValue : null,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        counter: const SizedBox(),
        prefixIcon: showPhoneCodes
            ? SizedBox(
                width: 85,
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        //showCountryCodePicker(context);
                      },
                      child: Container(
                        height: 16,
                        margin:
                            const EdgeInsets.only(top: 15, right: 15, left: 20),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              selectedCountryCode,
                              style: AppTextStyles.kRoboto70014Black,
                            )),
                      ),
                    ),
                    const Positioned(
                      top: 15,
                      left: 55,
                      child: Icon(Icons.keyboard_arrow_down,
                          color: AppColors.kBlack),
                    ),
                    Positioned(
                      top: 10,
                      left: 65,
                      child: Container(
                        width: 1,
                        height: 30,
                        margin: const EdgeInsets.only(left: 10),
                        color: AppColors.kLightGrey,
                      ),
                    )
                  ],
                ),
              )
            : prefixIcon,
        // prefixText: prefixText != null ? prefixText : null,
        // prefix: prefixIcon != null ? prefixIcon : null,
        prefixIconConstraints: prefixIconConstraints,
        suffix: labelSuffixIcon,
        errorMaxLines: 1,
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(Dimensions.width16,
            Dimensions.height17, Dimensions.width16, Dimensions.height16),
        hintStyle: hintStyle ?? AppTextStyles.kOpenSans40016Grey,
        hintText: hint,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? AppColors.kBlack,
            style: BorderStyle.solid,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(Dimensions.radius8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? AppColors.kBlack,
            style: BorderStyle.solid,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(Dimensions.radius8),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.ksearchFieldBorder,
            style: BorderStyle.solid,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(Dimensions.radius8),
        ),
        filled: true,
        errorText: errorMessage.isEmpty ? null : errorMessage,
        fillColor: Colors.white,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.kBlack,
            // style: BorderStyle.solid,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(Dimensions.radius8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.kBlack,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(Dimensions.radius8),
        ),
        errorStyle: AppTextStyles.kRoboto50013Red.copyWith(color: Colors.red),
      ),
      onTap: onTap,
      readOnly: readOnly,
      keyboardType: textInputType ?? TextInputType.multiline,
      minLines: minLines,
      maxLines: null,
      textInputAction: textInputAction ?? TextInputAction.next,
      onSaved: (value) {},
      //validator: validator ?? (value) => value == null || value.isEmpty ? errorMessage : null,
    );
  }
}
