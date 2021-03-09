import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButtonSocial extends StatelessWidget {
  final String image;
  final String text;
  final double heightImage;
  final double widthImage;
  final double widthSizedBetween;
  final Function onPressed;

  CustomButtonSocial({
    this.image,
    this.text,
    this.heightImage,
    this.widthImage,
    this.widthSizedBetween,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade50
      ),
      child: FlatButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: heightImage,
              height: widthImage,
              child: Image.asset(image),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * widthSizedBetween,
            ),
            CustomText(
              text: text,
              fontSize: 17,
            )
          ],
        ),
      ),
    );
  }
}
