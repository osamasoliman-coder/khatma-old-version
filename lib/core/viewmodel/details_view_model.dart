import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatma/core/services/firestore_khatma.dart';
import 'package:khatma/core/viewmodel/home_view_model.dart';
import 'package:khatma/model/khatma_model.dart';
import 'package:khatma/model/member_model.dart';
import 'package:khatma/model/user_model.dart';

class DetailsViewModewl extends GetxController {

  HomeViewModel homeViewModel = Get.put(HomeViewModel());

  String subject, about, khatmaName;

  List<KhatmaModel> _khatmaModel = [];

  List<KhatmaModel> get khatmaModel => _khatmaModel;

  List<KhatmaModel> _myKhatma = [];

  List<KhatmaModel> get myKhatma => _myKhatma;

  List<UserModel> _userModel = [];

  List<UserModel> get userModel => _userModel;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _khatmaName = '';

  bool _isUpdate = false;
  bool get isUpdate => _isUpdate;
  bool _checkAnyChange = false;




  final CollectionReference _khatmaCollection =
  FirebaseFirestore.instance.collection('Khatma');
  final CollectionReference _membersCollection =
  FirebaseFirestore.instance.collection('Members');
  final CollectionReference _closedKhatma =
  FirebaseFirestore.instance.collection('Closed');
  final CollectionReference _userCollection =
  FirebaseFirestore.instance.collection('Users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    update();
  }

  //update khatma
  updateKhatma(String khatmaId) async {
    await _khatmaCollection.doc(khatmaId.toString()).get().then((value) async {
      print(value.data()['khatmaId']);
      await  _khatmaCollection.doc(khatmaId.toString()).update({
         'khatmaName' : khatmaName,
         'subject' : subject,
         'about' : about
       });
      Get.snackbar(
        'Update',
        'You Are Updated Successfully',
        colorText: Colors.green,
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    });
    _isUpdate = true;
    update();
  }


  //delete khatma
  deleteKhatma(String khatmaId)async{
    List<KhatmaModel>khatma = [];
    await _khatmaCollection.doc(khatmaId.toString()).get().then((value) async {
      khatma.add(KhatmaModel.fromJson(value.data()));
      print(khatma.length);
      await  _khatmaCollection.doc(khatmaId.toString()).delete();
      await _closedKhatma.doc(khatmaId.toString()).set(KhatmaModel(
          khatmaId:khatmaId,
          ownerId: khatma[0].ownerId,
          ownerName: khatma[0].ownerName,
          ownerEmail: khatma[0].ownerEmail,
          khatmaName: khatma[0].khatmaName,
          password: khatma[0].password,
          type: khatma[0].type,
          renewal: khatma[0].renewal,
          notification: khatma[0].notification,
          days: khatma[0].days,
          dateTime: khatma[0].dateTime,
           members: khatma[0].members,
          subject: khatma[0].subject,
          about: khatma[0].about
      ).toJson());
      update();
    });
    update();
  }


  //leave khatma
  leaveKhatma(String khatmaId)async{
    List<KhatmaModel>khatma = [];
    List<Map> map = [];
    await _khatmaCollection.doc(khatmaId.toString()).get().then((value) async {
      khatma.add(KhatmaModel.fromJson(value.data()));

      for(int i=0; i<khatma[0].members.length; i++){
        if(khatma[0].members[i]["memberEmail"] != _auth.currentUser.email){
          map.add(khatma[0].members[i]);
        }
      }

      await _khatmaCollection.doc(khatmaId.toString()).update(
      {
          "khatmaId":khatmaId,
          "ownerId": "",
          "ownerName": "",
          "ownerEmail": "",
          "khatmaName": khatma[0].khatmaName,
          "password": khatma[0].password,
          "type": khatma[0].type,
          "renewal": khatma[0].renewal,
          "notification": khatma[0].notification,
          "days": khatma[0].days,
          "dateTime": khatma[0].dateTime,
          "members": map,
          "subject": khatma[0].subject,
          "about": khatma[0].about
      }
      );

    });
    update();
  }

  //leave members khatma
  MemberLeaveKhatma(String khatmaId,String ownerId , String ownerName , String ownerEmail)async{
    List<KhatmaModel>khatma = [];
    List<Map> map = [];
    await _khatmaCollection.doc(khatmaId.toString()).get().then((value) async {
      khatma.add(KhatmaModel.fromJson(value.data()));

      for(int i=0; i<khatma[0].members.length; i++){
        if(khatma[0].members[i]["memberEmail"] != _auth.currentUser.email){
          map.add(khatma[0].members[i]);
        }
      }

      await _khatmaCollection.doc(khatmaId.toString()).update(
          {
            "khatmaId":khatmaId,
            "ownerId": ownerId ,
            "ownerName": ownerName,
            "ownerEmail": ownerEmail,
            "khatmaName": khatma[0].khatmaName,
            "password": khatma[0].password,
            "type": khatma[0].type,
            "renewal": khatma[0].renewal,
            "notification": khatma[0].notification,
            "days": khatma[0].days,
            "dateTime": khatma[0].dateTime,
            "members": map,
            "subject": khatma[0].subject,
            "about": khatma[0].about
          }
      );
      update();
    });
    update();
  }

}
