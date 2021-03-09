import 'dart:core';

import 'package:get/get.dart';

class TestViewModel extends GetxController {
  List<int> all = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<int> some = [1, 2, 5, 7, 8];
  List<int> history = [];

  readAutomatic() {
    for (var i = 0; i < some.length; i++) {
      if (i < some.length - 1) {
        if (some[i] == some[i + 1] - 1) {
          print('connected number is${some[i]} : ${some[i + 1]}\n');
        }
        else{
          print('not connected ${some[i+1]}');
        }
      }
    }
  }
}
