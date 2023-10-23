import 'package:expense_app/constants/const.dart';
import 'package:flutter/material.dart';

class BackgroundCircles extends StatelessWidget {
  final double top;
  final double left;
  final double bottom;
  final double right;

  const BackgroundCircles({
    this.top = 0,
    this.left = 0,
    this.right = 0,
    this.bottom = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left == 0 ? null : left,
      top: top == 0 ? null : top,
      right: right == 0 ? null : right,
      bottom: bottom == 0 ? null : bottom,
      height: MediaQuery.of(context).size.height * 0.38,
      width: MediaQuery.of(context).size.height * 0.38,
      child: Container(
        height: 300,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              blurStyle: BlurStyle.solid,
              color: Colors.black,
              blurRadius: 8,
              spreadRadius: -5,
            ),
          ],
          color: Constant.loginBackground2,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
