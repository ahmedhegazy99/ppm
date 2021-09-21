import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'dart:math' show pi;

import 'package:pro_player_market/components/constants.dart';

class Background extends StatelessWidget {
  final Widget child;
  final Color ? backgroundColor;
  const Background({
    Key? key,
    required this.child,
    this.backgroundColor = ppmBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: backgroundColor,
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: -size.width * 0.1,
            left: -size.width * 0.3,
            child: Transform.rotate(
              angle: pi / -2.0,
              child: Opacity(
                opacity: 0.3,
                child: SvgPicture.asset(
                  "assets/icons/soccer_ball.svg",
                  width: size.width * 0.6,
                  color: ppmMain,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -size.width * 0.1,
            right: -size.width * 0.2,
            child: Transform.rotate(
              angle: pi / 2.0,
              child: Opacity(
                opacity: 0.6,
                child: SvgPicture.asset(
                  "assets/icons/soccer_ball.svg",
                  width: size.width * 0.4,
                  color: ppmMain,
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
