import 'package:flutter/material.dart';
import 'package:nightly/utils/constants/app_styles.dart';
import 'package:nightly/utils/constants/dimensions.dart';

class TagWidget extends StatelessWidget {
  const TagWidget({
    required this.iconImageUrl,
    required this.title,
    Key? key,
  }) : super(key: key);

  final String iconImageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height30,
      width: Dimensions.width158 - 6,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width17, vertical: Dimensions.height5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius30)),
        color: const Color(0xffffe010).withOpacity(0.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: Dimensions.width24,
            height: Dimensions.height24,
            child: Image.asset(
              iconImageUrl,
              scale: 3,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: Dimensions.width8),
          Text(
            title,
            style: AppTextStyles.kOpenSans60014DarkGrey,
          ),
        ],
      ),
    );
  }
}
