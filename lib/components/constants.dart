import 'package:flutter/material.dart';
import 'dart:math' show pi;

//const ppmMain = Colors.green;
//const ppmMain = Color(0xff246EE9);
const ppmMain = Colors.black;
const ppmLight = Colors.blueGrey;
const ppmBack = Colors.white;
const ppmLightBlack = Color(0xff232323);

const gradientLightY = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [const Color(0xffffb347), const Color(0xffffcc33)],
  transform: GradientRotation(pi / 135)
);

const gradientMediumY = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [const Color(0xfff3c600), const Color(0xfff7a50c)],
    transform: GradientRotation(pi / 45)
);

const gradientDarkB = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [const Color(0xff141e30), const Color(0xff000000)],
    transform: GradientRotation(pi / 45)
);


const customTextStyle = TextStyle(
  color: Colors.black , fontStyle: FontStyle.normal , fontSize: 12.0, fontFamily: "englishTex",
);

const kDefaultPadding = 20.0;