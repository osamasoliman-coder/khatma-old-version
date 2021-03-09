import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatma/core/viewmodel/test.dart';
import 'package:khatma/view/widget/custom_text.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TestViewModel>(
      init: TestViewModel(),
      builder: (controller) => Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: (){
              controller.readAutomatic();
            },
            child: CustomText(
              text: 'check',
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
