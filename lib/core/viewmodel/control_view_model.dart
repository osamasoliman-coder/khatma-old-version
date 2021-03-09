
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatma/view/myprifile_view.dart';
import 'package:khatma/view/home_view.dart';
import 'package:khatma/view/search_view.dart';

class ControlViewModel extends GetxController{

  Widget _currentView = HomeView();
  get currentView => _currentView;


  int _navigatorValue=0;

  int get navigatorValue =>_navigatorValue;


  void changeSelectedValue(int selectedValue){
    _navigatorValue = selectedValue;
    switch(selectedValue){
      case 0 : {
        _currentView = HomeView();
        break;
      }
      case 1:{
        _currentView = SearchView();
        break;
      }
      case 2:{
        _currentView = MyProfile();
      }
    }
    update();
  }


}