import 'package:flutter/material.dart';

class LoadingWrapper extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final double opacity;
  final Color color;

  const LoadingWrapper(
      {required this.child,
      required this.isLoading,
      this.opacity = 0.1,
      this.color = Colors.black,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (isLoading) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          const Center(
            child: CustomLoadingIndicator(),
          ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}

class CustomLoadingIndicator extends StatefulWidget {
  const CustomLoadingIndicator({Key? key}) : super(key: key);

  @override
  _CustomLoadingIndicatorState createState() => _CustomLoadingIndicatorState();
}

class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat(reverse: false);
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.linear);

  final Tween<double> antiClockTween = Tween<double>(
    begin: 1,
    end: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        Container(
          color: Colors.transparent,
          height: 40,
          width: 40,
          child: RotationTransition(
              turns: antiClockTween.animate(_animation),
              child: CustomPaint(
                  foregroundPainter:
                      CustomLoadingIndicatorPaint(isAntiClockWise: true))),
        ),
        Positioned(
          left: 10,
          top: 10,
          child: Container(
            color: Colors.transparent,
            height: 20,
            width: 20,
            child: RotationTransition(
                turns: _animation,
                child: CustomPaint(
                    foregroundPainter:
                        CustomLoadingIndicatorPaint(isAntiClockWise: false))),
          ),
        ),
      ]),
    );
  }
}

class CustomLoadingIndicatorPaint extends CustomPainter {
  bool isAntiClockWise = false;
  CustomLoadingIndicatorPaint({required this.isAntiClockWise});
  @override
  void paint(Canvas canvas, Size size) {
    Paint bigArc = Paint()
      ..strokeWidth = 5
      ..color = const Color(0XFFF5BD1C)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    isAntiClockWise
        ? canvas.drawArc(
            const Offset(0, 0) & const Size(40, 40),
            0,
            5,
            false,
            bigArc,
          )
        : canvas.drawArc(
            const Offset(0, 0) & const Size(20, 20),
            0,
            4.5,
            false,
            bigArc,
          );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
