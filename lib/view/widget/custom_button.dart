import 'package:flutter/material.dart';
import 'package:khatma/constance/constance.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final double width;
  final double fontSize;
  final Color colorButton;
  final double height;
  final Function onPressed;

  CustomButton({
    this.text,
    this.color,
    this.width,
    this.fontSize,
    this.colorButton,
    this.height,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      margin: EdgeInsets.only(top: 30),
      height: height,
      child: FlatButton(
        color: colorButton,
        onPressed: onPressed,
        child: CustomText(
          text: text,
          fontSize: fontSize,
          color: color,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
