import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:khatma/model/khatma_model.dart';
import 'package:khatma/model/my_werd_model.dart';

class MyProfileViewModel extends GetxController {
  final CollectionReference _myKhatma =
      FirebaseFirestore.instance.collection('Khatma');

  final CollectionReference _userColloection =
      FirebaseFirestore.instance.collection('Users');
  FirebaseAuth _auth = FirebaseAuth.instance;

  String currentUsername = '';
  String currentEmail = '';

  List<KhatmaModel> _myKhatmaModel = [];

  List<KhatmaModel> get myKhatmaModel => _myKhatmaModel;

  List<KhatmaModel> _allKhatmaModel = [];

  List<KhatmaModel> get allKhatmaModel => _allKhatmaModel;

  List<KhatmaModel> _myKhatmaWithWerd = [];

  List<KhatmaModel> get myKhatmaWithWerd => _myKhatmaWithWerd;

  List<Map> _myWerd = [];

  List<Map> get myWerd => _myWerd;
  List<MyWerdModel> _myWerdDetails = [];

  List<MyWerdModel> get myWerdDetails => _myWerdDetails;

  Map historyNew = {};
  List<Map<dynamic, dynamic>> historyOld = [];
  List<Map<dynamic, dynamic>> updateReserve = [];

  MyProfileViewModel() {
    getAllMyWerdFromMyKhatma();
    getCurrentUserData();
  }

  getAllMyWerdFromMyKhatma() async {
    _allKhatmaModel.clear();
    _myKhatmaModel.clear();
    _myKhatma.get().then((value) {
      //get all khatma
      for (int i = 0; i < value.docs.length; i++) {
        _allKhatmaModel.add(KhatmaModel.fromJson(value.docs[i].data()));
      }
      //get my khatma or i joined in this khatma
      for (int i = 0; i < _allKhatmaModel.length; i++) {
        if (_allKhatmaModel[i].ownerEmail == _auth.currentUser.email) {
          _myKhatmaModel.add(_allKhatmaModel[i]);
          update();
        } else {
          for (int m = 0; m < _allKhatmaModel[i].members.length; m++) {
            if (_allKhatmaModel[i].members[m]['memberEmail'] ==
                    _auth.currentUser.email &&
                _auth.currentUser.email != _allKhatmaModel[i].ownerEmail) {
              _myKhatmaModel.add(_allKhatmaModel[i]);
              update();
            }
          }
        }
      }

      //get khatma if i reserve quran
      for (int mww = 0; mww < _myKhatmaModel.length; mww++) {
        for (int r = 0; r < _myKhatmaModel[mww].reserved.length; r++) {
          if (_myKhatmaModel[mww].reserved[r]['memberReservedEmail'] ==
              _auth.currentUser.email) {
            _myKhatmaWithWerd.add(_myKhatmaModel[mww]);
          }
        }
      }

      //get daily werd of current user
      for (int khatma = 0; khatma < _myKhatmaWithWerd.length; khatma++) {
        for (int reserv = 0;
            reserv < _myKhatmaWithWerd[khatma].reserved.length;
            reserv++) {
          if (_myKhatmaWithWerd[khatma].reserved[reserv]
                  ['memberReservedEmail'] ==
              _auth.currentUser.email) {
            _myWerd.add(_myKhatmaWithWerd[khatma].reserved[reserv]);
            break;
          }
        }
      }

      //get my werd details
      for (int index = 0; index < _myWerd.length; index++) {
        _myWerdDetails.add(MyWerdModel.fromJson(_myWerd[index]));
      }
    });
    update();
  }

  getCurrentUserData() async {
    _userColloection.doc(_auth.currentUser.uid).get().then((value) {
      currentUsername = value.data()['name'];
      currentEmail = value.data()['email'];
      update();
    });
  }

  automationWerd(int index) async {
    // for (int x = 0; x < _myKhatmaWithWerd[index].reserved.length; x++) {
    //   if (_auth.currentUser.email ==
    //       _myKhatmaWithWerd[index].reserved[x]['memberReservedEmail']) {
    //     historyNew = _myKhatmaWithWerd[index].reserved[x];
    //   }
    // }
    //
    // //remove from reserved
    // for (int z = 0; z < _myKhatmaWithWerd[index].reserved.length; z++) {
    //   if (_myKhatmaWithWerd[index].reserved[z]['memberReservedEmail'] !=
    //       _auth.currentUser.email) {
    //     updateReserve.add(_myKhatmaWithWerd[index].reserved[z]);
    //   }
    // }
    // _myKhatma
    //     .doc(_myKhatmaWithWerd[index].khatmaId)
    //     .update({'reserved': updateReserve});
    //
    // //add to history
    // historyOld = _myKhatmaWithWerd[index].history;
    // historyOld.add(historyNew);
    // _myKhatma
    //     .doc(_myKhatmaWithWerd[index].khatmaId)
    //     .update({'history': historyOld});

    int lengthWerd = 1;

    //check to get new werd
    for (int h = 0; h < _myKhatmaWithWerd[index].history.length; h++) {
      if (_auth.currentUser.email ==
          _myKhatmaWithWerd[index].history[h]['memberReservedEmail']) {
        for (int i = 0;
            i < _myKhatmaWithWerd[index].history[h]['quran'].length;
            i++) {
          for (int a = 0; a < _myKhatmaWithWerd[index].allQuran.length; a++) {
            if (_myKhatmaWithWerd[index].history[h]['quran'][i]['n'] ==
                _myKhatmaWithWerd[index].allQuran[a]['n']) {
              if (_myKhatmaWithWerd[index].history[h]['quran'][i]['n'] ==
                  _myKhatmaWithWerd[index].history[h]['quran'][i]['n'] + 1 - 1) {
                lengthWerd = _myKhatmaWithWerd[index].allQuran[a + 1]['n'];
                print(_myKhatmaWithWerd[index].allQuran[lengthWerd]['quranAr']);
                break;
              }
            }
          }
        }
      }
    }

    update();
  }
}
