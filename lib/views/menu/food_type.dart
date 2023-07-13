import 'package:flutter/material.dart';
import 'package:nightly/utils/constants/app_colors.dart';

class FoodTypeTile extends StatelessWidget {
  const FoodTypeTile({
    required this.isVeg,
    Key? key,
  }) : super(key: key);

  final bool isVeg;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
            border: Border.all(
                color: isVeg ? AppColors.kFoodGreen : const Color(0xFFab5a3e)
                //AppColors.kFoodRed
                ),
            borderRadius: BorderRadius.circular(1)),
        child: Center(
          child: isVeg
              ? Container(
                  padding: const EdgeInsets.all(2),
                  height: 6,
                  width: 6,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.kFoodGreen),
                )
              : Container(
                  padding: const EdgeInsets.all(1),
                  height: 25,
                  width: 25,
                  decoration: const BoxDecoration(color: AppColors.kWhite),
                  child: CustomPaint(
                    painter: TrianglePainter(
                      strokeColor:
                          const Color(0xFFab5a3e), // AppColors.kFoodRed,
                      strokeWidth: 2,
                      paintingStyle: PaintingStyle.fill,
                    ),
                  ),
                ),
        ));
  }
}

//AppColors.kFoodRed
class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 6,
      this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, y)
      ..lineTo(x / 2, 0)
      ..lineTo(x, y)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
