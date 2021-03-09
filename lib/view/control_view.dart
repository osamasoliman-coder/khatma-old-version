import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatma/constance/constance.dart';
import 'package:khatma/core/viewmodel/auth_view_model.dart';
import 'package:khatma/core/viewmodel/control_view_model.dart';
import 'package:khatma/core/viewmodel/home_view_model.dart';
import 'package:khatma/view/myprifile_view.dart';
import 'package:khatma/view/auth/login_screen.dart';
import 'package:khatma/view/home_view.dart';
import 'package:khatma/view/search_view.dart';

class ControlView extends GetWidget<AuthViewModel> {

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthViewModel>().user == null)
          ? LoginScreen()
          : GetBuilder<ControlViewModel>(
        init: ControlViewModel(),
            builder:(controller) => Scaffold(
                bottomNavigationBar: _bottomNavigationBar(),
                body: controller.currentView,
              ),
          );
    });
  }

  Widget _bottomNavigationBar() {
    return GetBuilder<ControlViewModel>(
      init: ControlViewModel(),
      builder: (controller) => BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  'Khatma',
                  style: TextStyle(fontSize: 16, color: primaryColor),
                ),
              ),
              label: '',
              icon: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Icon(Icons.home),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  'Search',
                  style: TextStyle(fontSize: 16, color: primaryColor),
                ),
              ),
              label: '',
              icon: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Icon(Icons.search),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  'My Profile',
                  style: TextStyle(fontSize: 16, color: primaryColor),
                ),
              ),
              label: '',
              icon: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Icon(Icons.person),
              ),
            ),
          ],
          elevation: 1.0,
          selectedItemColor: Colors.black,
          backgroundColor: Colors.grey.shade50,
          currentIndex: controller.navigatorValue,
          onTap: (index) {
            controller.changeSelectedValue(index);
          }),
    );
  }
}
