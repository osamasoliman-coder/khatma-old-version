import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatma/view/control_view.dart';
import 'package:khatma/view/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helper/binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var  pref = await SharedPreferences.getInstance();
  bool isSeen = pref.getBool('is_seen');
  Widget homepage = ControlView();
  if(isSeen == null || !isSeen){
    homepage = OnboardingScreen();
  }
  runApp(Khatma(homepage));
}

class Khatma extends StatelessWidget {
  final Widget homepage;
  Khatma(this.homepage);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Binding(),
      debugShowCheckedModeBanner: false,
      home: homepage,
    );
  }
}
