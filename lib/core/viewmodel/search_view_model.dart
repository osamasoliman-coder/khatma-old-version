import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatma/core/viewmodel/home_view_model.dart';
import 'package:khatma/model/khatma_model.dart';
import 'package:khatma/model/member_model.dart';
import 'package:khatma/model/user_model.dart';

class SearchViewModel extends GetxController {
  List<KhatmaModel> _khatmaModel = [];

  List<KhatmaModel> get khatmaModel => _khatmaModel;

  List<UserModel> _userModel = [];

  List<UserModel> get userModel => _userModel;

  List<Members> _memberModel = [];

  List<Members> get memberModel => _memberModel;

  List<Map<dynamic, dynamic>> _mk = [];

  List<Map<dynamic, dynamic>> get mk => _mk;

  List<KhatmaModel> _resuultListSearch = [];
  List<KhatmaModel> get resuultListSearch =>_resuultListSearch;
  Future _resultLioaded;
  final TextEditingController _searchController = TextEditingController();
  String search;

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  int _khatmaByIdCount = 0;

  int get khatmaByIdCount => _khatmaByIdCount;

 // String _password;
  String  password;

  bool _memberAlready = false;
  bool get memberAlready => _memberAlready;


  final CollectionReference _khatmaCollection =
      FirebaseFirestore.instance.collection('Khatma');
  final CollectionReference _membersCollection =
      FirebaseFirestore.instance.collection('Members');
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('Users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    getAllKhatma();
    gettAllUsers();
    onSearchEmptyValue();
  }

  getAllKhatma() async {
    Map map;
    List<String>email;
    _khatmaCollection.get().then((value) async {
      for (int i = 0; i < value.docs.length; i++) {
        _khatmaModel.add(KhatmaModel.fromJson(value.docs[i].data()));
        _isLoading = true;
      }
      _resuultListSearch = _khatmaModel;
      update();
    });
  }


  checkUserInKhatmaOrNot(int index)async{
    //gett all members in khatma
      for(int x=0;x<_khatmaModel[index].members.length; x++){
        if(_khatmaModel[index].members[x]['memberEmail'] == _auth.currentUser.email){
          print(_khatmaModel[index].members[x]['memberEmail']);
          print(_khatmaModel[index].khatmaName);
         return _memberAlready = true;
        }
      update();
    }

  }

  gettAllUsers() async {
    _userCollection.get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        _userModel.add(UserModel.fromJson(value.docs[i].data()));
      }
      update();
    });
  }

  getAllMembers() async {
    _membersCollection.get().then((value) async {
      for (int i = 0; i < value.docs.length; i++) {
        _memberModel.add(Members.fromJson(value.docs[i].data()));
        //print(_memberModel[i].memberName);
      }
    });
    update();
  }


  addNewMemberToPublicKhatma(int khatmaId , int index) async {
    Map newm;
    bool listMemberisEmpty = false;
    bool isMember = false;
    String currentUserName = '';
    String currentUserEmail = '';
    String currentUserId = '';

    //gett all members in khatmaby id
    for (int i = 0; i < _khatmaModel[index].members.length; i++) {
      _mk = _khatmaModel[index].members;
      update();
    }

    //check if user is member in this khatma or not
    for (int user = 0; user < _userModel.length; user++) {
      if (_userModel[user].userId == _auth.currentUser.uid) {
         currentUserName = _userModel[user].name;
         currentUserEmail = _userModel[user].email;
         currentUserId = _userModel[user].userId;
        if (khatmaModel[index].members.length == 0) {
          listMemberisEmpty = true;
          break;
        } else if (_khatmaModel.length > 0) {
          for(int i=0; i<_mk.length; i++){
            if(_mk[i]['memberEmail'] == _userModel[user].email){
              isMember = true;
              break;
            }
          }
        }
      }
    }
    if(isMember == false){
      addNewMemberToKhatmaById(khatmaId, currentUserId, currentUserName, currentUserEmail);
    }
    else{
      print("user already member");
    }
    //gett all members in khatmaby id againg to refresh the list of member
    for (int i = 0; i < _khatmaModel[index].members.length; i++) {
      _mk = _khatmaModel[index].members;
      update();
    }
    update();
  }

  addNewMemberTpPrivateKhatma(int khatmaId,int index) async {
    Map newm;
    bool listMemberisEmpty = false;
    bool isMember = false;
    String currentUserName = '';
    String currentUserEmail = '';
    String currentUserId = '';

    //gett all members in khatmaby id
    for (int i = 0; i < _khatmaModel[index].members.length; i++) {
      _mk = _khatmaModel[index].members;
      update();
    }

    //check if user is member in this khatma or not
    for (int user = 0; user < _userModel.length; user++) {
      if (_userModel[user].userId == _auth.currentUser.uid) {
        currentUserName = _userModel[user].name;
        currentUserEmail = _userModel[user].email;
        currentUserId = _userModel[user].userId;
        if (khatmaModel[index].members.length == 0) {
          listMemberisEmpty = true;
          break;
        } else if (_khatmaModel.length > 0) {
          for(int i=0; i<_mk.length; i++){
            if(_mk[i]['memberEmail'] == _userModel[user].email){
              isMember = true;
              break;
            }
          }
        }
      }
    }
    if(_khatmaModel[index].password == password){
      if(isMember == false){
        addNewMemberToKhatmaById(khatmaId, currentUserId, currentUserName, currentUserEmail);
        Get.snackbar(
          'Good',
          'You Are Joined To This Khatma',
          colorText: Colors.green,
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      else{
        print("user already member");
      }
    }
    else{
      return Get.snackbar(
        'Sorry',
        'Wrong Password',
        colorText: Colors.red,
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    //gett all members in khatmaby id againg to refresh the list of member
    for (int i = 0; i < _khatmaModel[index].members.length; i++) {
      _mk = _khatmaModel[index].members;
      update();
    }
    update();
  }

  //add new member to list of map
  addNewMemberToKhatmaById(int khatmaId, memberId, memberName, memberEmail) async {
    Map newm;
    for (int i = 0; i < khatmaModel.length; i++) {
      if (_khatmaModel[i].khatmaId == khatmaId.toString()) {
        _mk = _khatmaModel[i].members;
        newm = {
          'memberId': memberId.toString(),
          'memberEmail': memberEmail,
          'memberName': memberName
        };
        _mk.add(newm);
        _khatmaCollection.doc(khatmaId.toString()).get().then((value) {
          print(value.data());
          _khatmaCollection.doc(khatmaId.toString()).update({'members': _mk});
        });
      }
    }
    print(_mk.length);
    update();
  }


  // 34an l user is member diable icon add
  bool test(index){
    List<String> email = [];

      for(int i=0;i<_khatmaModel[index].members.length; i++){
        email.add(_khatmaModel[index].members[i]['memberEmail']);
        HomeViewModel homeViewModel = HomeViewModel();
      }

    if(email.contains(_auth.currentUser.email)) {
      _memberAlready = true;
      return true;
    }
    update();
  }



  searchKhatmaMethod(String khatmaName)async {
   // getAllKhatma();
    List<KhatmaModel> list =[];
    if(search != ""){
      for(int i=0; i<_khatmaModel.length; i++){
        if(_khatmaModel[i].khatmaName == khatmaName){
          list.add(_khatmaModel[i]);
        }
      }
      _khatmaModel.clear();
      _khatmaModel = list;
      print(_khatmaModel.length);
     // print(list.length);
    }
    else if(search == ""){
      list.clear();
      _khatmaModel.clear();
      print(list.length);
      getAllKhatma();
    }
    update();
  }

  onSearchEmptyValue(){
    if(search == ""){
      _khatmaModel.clear();
      getAllKhatma();
    }
  }

}
