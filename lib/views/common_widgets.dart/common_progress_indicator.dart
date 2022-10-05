import 'package:flutter/material.dart';
import 'package:nightly/utils/constants/color_constants.dart';

class CommonProgressIndicator extends StatelessWidget {
  const CommonProgressIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Opacity(
          opacity: 0.7,
          child: ModalBarrier(dismissible: false, color: Colors.black),
        ),
        Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: ColorConstants.appBackgroundTheme,
              strokeWidth: 6,
            )),
      ],
    );
  }
}
