import 'package:flutter/material.dart';
import 'package:nightly/utils/constants/color_constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomRefresh extends StatefulWidget {
  const CustomRefresh({Key? key}) : super(key: key);

  @override
  State<CustomRefresh> createState() => _CustomRefreshState();
}

class _CustomRefreshState extends State<CustomRefresh> {
  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      builder: (BuildContext? context, RefreshStatus? mode) {
        return Container(
          // color: ColorConstants.appTheme,
          width: 40,
          height: 40,
          child: mode != RefreshStatus.canRefresh
              ? Transform.scale(
                  scale: 0.5,
                  child: Container(
                      height: 35,
                      width: 35,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        color: ColorConstants.appBackgroundTheme,
                        strokeWidth: 6,
                      )),
                )
              : const Icon(
                  Icons.refresh,
                  color: ColorConstants.appBackgroundTheme,
                  size: 25,
                ),
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: ColorConstants.appTheme),
        );
      },
    );
  }
}
