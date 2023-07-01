import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nightly/utils/constants/app_colors.dart';
import 'package:nightly/utils/constants/app_styles.dart';
import 'package:nightly/utils/constants/dimensions.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    required this.hint,
    this.errorMessage = '',
    required this.onChanged,
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
    this.isPrefix = false,
    this.isSuffix = false,
    this.isSuffixWithIcon = false,
    this.onSuffixPressed,
    this.suffixText = '',
    this.focusNode,
    this.autofocus = false,
    this.enablePadding = false,
    this.onFieldSubmitted,
    this.textFontSize,
    this.hintTextFontSize,
    this.cursorColor,
    Key? key,
  }) : super(key: key);

  final String hint;
  final String errorMessage;
  final Function(String) onChanged;
  final Function()? onSuffixPressed;
  final TextInputType? textInputType;
  final Function()? onTap;
  final bool readOnly;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int maxLength;
  final String? initialValue;
  final int maxLines;
  final int minLines;
  final TextInputAction? textInputAction;
  final bool isPrefix;
  final bool isSuffix;
  final FocusNode? focusNode;
  final bool isSuffixWithIcon;
  final String suffixText;
  final bool autofocus;
  final bool enablePadding;
  final double? textFontSize;
  final double? hintTextFontSize;
  final Color? cursorColor;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: enablePadding
          ? EdgeInsets.symmetric(horizontal: Dimensions.width20)
          : EdgeInsets.zero,
      child: TextFormField(
        focusNode: focusNode,
        onChanged: onChanged,
        controller: controller,
        autofocus: autofocus,
        onFieldSubmitted: onFieldSubmitted,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
          fontFamily: 'Open Sans',
          fontSize: textFontSize ?? Dimensions.fontSize14,
          height: 1.28,
          color: AppColors.kInputTextColor,
        ),
        cursorColor: cursorColor ?? AppColors.kSearchFieldCursorColor,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.deny(RegExp(r'^\s+|$'))
        ],
        maxLength: maxLength,
        initialValue: controller == null ? initialValue : null,
        decoration: InputDecoration(
          suffixIcon: isSuffix
              ? Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    isSuffixWithIcon
                        ? InkWell(
                            onTap: onSuffixPressed,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: const Icon(
                                Icons.clear,
                                color: AppColors.kBlack,
                                size: 16,
                              ),
                            ),
                          )
                        : TextButton(
                            child: Text(
                              suffixText,
                              style: AppTextStyles.kRoboto60012Black.copyWith(
                                  color: AppColors.kcouplyApplyTextColor,
                                  fontSize: 11.5),
                            ),
                            onPressed: onSuffixPressed,
                          )
                  ],
                )
              : null,
          prefixIcon: isPrefix
              ? Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 17.0),
                        child: SizedBox(
                            width: 20.31,
                            height: 20.31,
                            child: Image.asset(
                              'assets/icons/search.png',
                            )))
                  ],
                )
              : null,
          counter: const SizedBox(),
          errorMaxLines: 1,
          isDense: true,
          contentPadding: const EdgeInsets.only(top: 14, left: 10, bottom: 14),
          hintStyle: TextStyle(
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: hintTextFontSize ?? Dimensions.fontSize14,
            height:
                1.28, //  line height required is 18px i.e it should be the multiple of font size 1.28 x 14 = 18 .
            color: AppColors.ksearchHintColor,
          ),
          hintText: hint,
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                  style: BorderStyle.solid,
                  color: AppColors.ksearchFieldBorder,
                  width: 1),
              borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  style: BorderStyle.solid,
                  color: AppColors.ksearchFieldBorder,
                  width: 1),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  style: BorderStyle.solid,
                  color: AppColors.kenabledBorderColor,
                  width: 1),
              borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.white,
          errorText: errorMessage.isEmpty ? null : errorMessage,
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
          errorStyle: const TextStyle(
            fontSize: 12,
            color: Colors.red,
          ),
        ),
        onTap: onTap,
        readOnly: readOnly,
        keyboardType: textInputType ?? TextInputType.text,
        minLines: minLines,
        maxLines: 1,
        textInputAction: textInputAction ?? TextInputAction.next,
        onSaved: (value) {},
        validator: validator,
      ),
    );
  }
}
