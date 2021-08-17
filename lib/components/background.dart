import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'dart:math' show pi;

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Transform.rotate(
              angle: pi / -90.0,
              child: SvgPicture.asset(
                "assets/icons/dots.svg",
                width: size.width * 0.35,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Transform.rotate(
              angle: pi / 90.0,
              child: SvgPicture.asset(
                "assets/icons/dots.svg",
                width: size.width * 0.4,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
