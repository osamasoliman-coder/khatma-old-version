import 'package:flutter/material.dart';
import 'package:khatma/constance/constance.dart';
import 'package:khatma/view/widget/custom_text.dart';

class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: CustomText(
          text: 'History',
        ),
      ),
    );
  }
}
