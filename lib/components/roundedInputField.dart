import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

class RoundedInputField extends StatelessWidget {
  final double ? cSize, oWidth;
  final int ? maxLines;
  final String ?hintText;
  final IconData ?icon;
  final Color color;
  final Color textColor;
  final FormFieldValidator<String> ?validator;
  final bool obscureText;
  final TextInputType ?keyboardType;
  final TextEditingController ?controller;

  RoundedInputField(
      {Key? key,
      this.cSize = 0.8,
      this.oWidth = 1,
      this.maxLines = 1,
      this.color = Colors.white,
      this.textColor = Colors.black,
      this.hintText,
      this.icon,
      this.validator,
      this.obscureText = false,
      this.controller,
      this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.5*cSize!),
      padding: EdgeInsets.symmetric(horizontal: 12 *cSize!, vertical: 2 * cSize!),
      height: size.width * (cSize!/6),
      width: size.width * cSize! * oWidth!,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        validator: validator,
        controller: controller,
        cursorColor: ppmMain,
        keyboardType: keyboardType,
        autofocus: true,
        maxLines: maxLines,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: textColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
        style: TextStyle(
          fontSize: 20 * cSize!,
          color: textColor,
        ),
        //obscureText: true,
      ),
    );
  }
}
