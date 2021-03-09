import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatma/core/services/firestore_khatma.dart';
import 'package:khatma/model/khatma_model.dart';

class HomeViewModel extends GetxController{

  List<KhatmaModel> _khatmaModel = [];
  List<KhatmaModel> get khatmaModel => _khatmaModel;

  List<KhatmaModel> _myKhatma = [];
  List<KhatmaModel> get myKhatma => _myKhatma;

  ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ValueNotifier<bool> get isLoading => _isLoading;

  FirebaseAuth _auth = FirebaseAuth.instance;

  HomeViewModel(){
    getAllKhatma();
  }

  getAllKhatma() async {
    _isLoading.value = true;
   // await Future.delayed(Duration(seconds: 1));
    _isLoading.value = true;
    HomeService().getOnyMyKhatma().then((value) async {
      for (int i = 0; i < value.length; i++) {
         _khatmaModel.add(KhatmaModel.fromJson(value[i].data()));
      }
      for(int i=0; i<_khatmaModel.length; i++){
        if(_khatmaModel[i].ownerEmail ==_auth.currentUser.email){
          _myKhatma.add(_khatmaModel[i]);
        }
        else{
          for(int member=0; member<_khatmaModel[i].members.length; member++){
            if(_khatmaModel[i].members[member]['memberEmail'] == _auth.currentUser.email){
              _myKhatma.add(_khatmaModel[i]);
            }
          }
        }
      }
      update();
    });
   // print(_myKhatma.length);

  }

}
  //
  //  bool isAdminOrUser(int index){
  //     if(_khatmaModel[index].ownerEmail ==_auth.currentUser.email) {
  //       return true;
  //     }
  //     else{
  //       return false;
  //     }
  // }
