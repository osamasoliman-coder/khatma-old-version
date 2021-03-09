import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khatma/model/khatma_chat_model.dart';
import 'package:khatma/model/khatma_model.dart';
import 'package:khatma/model/public_chat_list_model.dart';

class KhatmaChatViewModel extends GetxController {
  final CollectionReference _addToPublicChatCollection =
      FirebaseFirestore.instance.collection('PublicChat');

  final CollectionReference _myKhatma =
      FirebaseFirestore.instance.collection('Khatma');

  final CollectionReference _userColloection =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference _publicChatListCollection =
      FirebaseFirestore.instance.collection('PublicChatList');

  FirebaseAuth _auth = FirebaseAuth.instance;
  DateTime now = DateTime.now();

  String _currentUserName = '';
  String _currentUserPic = '';

  String get currentUserPic => _currentUserPic;
  String message;
  RxString khatmaId = ''.obs;

  List<KhatmaChatModel> _khatmaChatModel = [];

  List<KhatmaChatModel> get khatmaChatModel => _khatmaChatModel;

  List<KhatmaModel> mykhatma = [];

  List<PublicChatListModel> _publicChatList = [];
  List<PublicChatListModel> get publicChatList => _publicChatList;

  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get  loading => _loading;


  KhatmaChatViewModel() {
    getCurrentUserData();
    getOnlyMyKhatma();
    update();
  }

  createNewMessageToKhatma(
      BuildContext context, String khatmaId,String khatmaName, String message) async {
    FocusScope.of(context).unfocus();
    String formattedDate = DateFormat('kk:mm').format(now);
    //current user data
    await _userColloection.doc(_auth.currentUser.uid).get().then((value) {
      _currentUserName = value.data()['name'];
      _currentUserPic = value.data()['pic'];
      print(_currentUserName);
      update();
    });
    //add message to public chat by khatmaId
    await _addToPublicChatCollection.doc().set(
          KhatmaChatModel(
            khatmaId: khatmaId,
            userId: _auth.currentUser.uid,
            currentUserName: _currentUserName,
            currentUserPic: _currentUserPic,
            message: message,
            timeSend: formattedDate,
          ).toJson(),
        );

    //add this message to list to see this message after member send directly
    Map map;
    map = {
      'khatmaId': khatmaId,
      'khatmaName' : khatmaName,
      'userId': _auth.currentUser.uid,
      'currentUserName': _currentUserName,
      'currentUserPic': _currentUserPic,
      'message': message,
      'timeSend': formattedDate,
    };
    _khatmaChatModel.add(KhatmaChatModel.fromJson(map));

    //add to public chatlist
    _publicChatListCollection.doc(khatmaId).get().then((value) {
      _publicChatListCollection.doc(khatmaId).set(PublicChatListModel(
              khatmaId: khatmaId, khatmaName: khatmaName , timeSend: formattedDate, message: message)
          .toJson());
    });

    update();
  }

  getAllChatInKhatmaById(String khatmaId) async {
    _khatmaChatModel.clear();
    await _addToPublicChatCollection
        .orderBy('timeSend', descending: false)
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        if (khatmaId == value.docs[i].data()['khatmaId']) {
          _khatmaChatModel.add(KhatmaChatModel.fromJson(value.docs[i].data()));
        }
      }
      update();
    });
  }

  getCurrentUserData() async {
    //current user data
    await _userColloection.doc(_auth.currentUser.uid).get().then((value) {
      _currentUserName = value.data()['name'];
      _currentUserPic = value.data()['pic'];
      update();
    });
  }

  //get khatma chat list
  getKhatmaChatList() async {
    _publicChatList.clear();
    List<PublicChatListModel> list = [];
    _publicChatListCollection.orderBy('timeSend' , descending: true).get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        list.add(PublicChatListModel.fromJson(value.docs[i].data()));
      }
      for(int x=0;x<list.length;x++){
        for(int z=0;z<mykhatma.length;z++){
          if(list[x].khatmaId == mykhatma[z].khatmaId){
            _publicChatList.add(list[x]);
            _loading.value = true;
          }
        }
      }
      _loading.value = false;
      print(publicChatList.length);
      update();
    });
    update();
  }

  getOnlyMyKhatma() async {
    List<KhatmaModel> allKhatmaList = [];
    _myKhatma.get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        allKhatmaList.add(KhatmaModel.fromJson(value.docs[i].data()));
      }
      for (int x = 0; x < allKhatmaList.length; x++) {
        if (allKhatmaList[x].ownerEmail == _auth.currentUser.email) {
          mykhatma.add(allKhatmaList[x]);
        } else {
          for (int i = 0; i < allKhatmaList[x].members.length; i++) {
            if (allKhatmaList[x].members[i]['memberEmail'] ==
                _auth.currentUser.email) {
              mykhatma.add(allKhatmaList[x]);
            }
          }
        }
      }
      update();
    });
  }
}
