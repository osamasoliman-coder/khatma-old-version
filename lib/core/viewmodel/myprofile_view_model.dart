import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
    List<Map> nextWerd = [];
    List<int> connected = [];
    List<Map> allReserved = [];
    List<Map> history = [];
    Map newHistory ={};
    int c = 0;
    var newa = [];
    var m = 1;
    var counter = List.filled(60, 0);

      DateTime now = DateTime.now();
      DateFormat formatter = DateFormat('yyyy-MM-dd');
     String date = formatter.format(now);


    //reserved with current user
    for (int x = 0; x < _myKhatmaWithWerd[index].reserved.length; x++) {
      if (_auth.currentUser.email ==
          _myKhatmaWithWerd[index].reserved[x]['memberReservedEmail']) {
        historyNew = _myKhatmaWithWerd[index].reserved[x];
      }
    }

    for (int i = 0; i < _myKhatmaWithWerd[index].reserved.length; i++) {
      for (int x = 0;
          x < _myKhatmaWithWerd[index].reserved[i]['quran'].length;
          x++) {
        if (_myKhatmaWithWerd[index].reserved[i]['memberReservedEmail'] ==
            _auth.currentUser.email) {
          connected.add(_myKhatmaWithWerd[index].reserved[i]['quran'][x]['n']);
        }
      }
    }

    //change not reading
    for(int x=0;x<_myKhatmaWithWerd[index].notReading.length;x++){
    for (int i = 0; i < historyNew['quran'].length; i++) {
        if(historyNew['quran'][i]['n'] == _myKhatmaWithWerd[index].notReading[x]['n']){
          _myKhatmaWithWerd[index].notReading.remove(_myKhatmaWithWerd[index].notReading[x]);

        }
      }
    }

    _myKhatma
        .doc(_myKhatmaWithWerd[index].khatmaId)
        .update({'notReading': _myKhatmaWithWerd[index].notReading});

    //add to history
    for(int i=0;i<_myKhatmaWithWerd[index].history.length;i++){
      if(_myKhatmaWithWerd[index].history.length>0){
        history.add(_myKhatmaWithWerd[index].history[i]);
      }
    }


    newHistory = {
      'memberReservedEmail' : _auth.currentUser.email,
      'memberReservedId' : _auth.currentUser.uid,
      'date' : date,
      'quran' : historyNew['quran']
    };
    history.add(newHistory);

    _myKhatma
        .doc(_myKhatmaWithWerd[index].khatmaId)
        .update({'history': history});


    connected.add(0);
    for (int i = 0; i < connected.length - 1; i++) {
      if (connected[i] < 60) {
        if (connected[i] + 1 == connected[i + 1]) {
          m++;
          counter[c] = m;
        } else if (i > 1 &&
                connected[i - 1] + 1 != connected[i] &&
                connected[i] + 1 != connected[i + 1] ||
            connected[i] + 1 != connected[i + 1] && i == 0) {
          newa.add(connected[i] + 1);
          counter[c] = 1;
          c++;
        } else {
          for (int x = 0; x < counter[c]; x++) {
            newa.add(connected[i] + x + 1);
          }
          m = 1;
          c++;
        }
      } else {
        if (connected[i] + 1 == connected[i + 1]) {
          m++;
          counter[c] = m;
        } else if (i > 1 &&
                connected[i - 1] + 1 != connected[i] &&
                connected[i] + 1 != connected[i + 1] ||
            connected[i] + 1 != connected[i + 1] && i == 0) {
          newa.add(60 - connected[i] + 1);
          counter[c] = 1;
          c++;
        } else {
          for (int x = 0; x < counter[c]; x++) {
            newa.add(60 - connected[i] + x + 1);
          }
          m = 1;
          c++;
        }
      }
    }
    m = 1;
    c++;

    for (int i = 0; i < _myKhatmaWithWerd[index].allQuran.length; i++) {
      for (int x = 0; x < newa.length; x++) {
        if (newa[x] == _myKhatmaWithWerd[index].allQuran[i]['n']) {
          nextWerd.add(_myKhatmaWithWerd[index].allQuran[i]);
        }
      }
    }

    for (int z = 0; z < _myKhatmaWithWerd[index].reserved.length; z++) {
      if (_myKhatmaWithWerd[index].reserved[z]['memberReservedEmail'] !=
          _auth.currentUser.email) {
        allReserved.add(_myKhatmaWithWerd[index].reserved[z]);
      }
    }
    Map mm = {
      'memberReservedEmail': _auth.currentUser.email,
      'memberReservedId': _auth.currentUser.uid,
      'quran': nextWerd
    };
    allReserved.add(mm);
    _myKhatma
        .doc(_myKhatmaWithWerd[index].khatmaId)
        .update({'reserved': allReserved});


    _myKhatmaWithWerd.clear();
    getAllMyWerdFromMyKhatma();
    update();
  }

  t() {
    int c = 0;
    var newa = [];
    var m = 1;
    var counter = List.filled(60, 0);
    var connected = [
      43,
      1,
      2,
      3,
      4,
      11,
      12,
      40,
      50,
      51,
      52,
      17,
      18,
      25,
      26,
      27,
      28,
      37,
      57,
      58,
      59,
    ];
    connected.add(0);
    for (int i = 0; i < connected.length - 1; i++) {
      if (connected[i] < 59) {
        if (connected[i] + 1 == connected[i + 1]) {
          m++;
          counter[c] = m;
        } else if (i > 1 &&
                connected[i - 1] + 1 != connected[i] &&
                connected[i] + 1 != connected[i + 1] ||
            connected[i] + 1 != connected[i + 1] && i == 0) {
          newa.add(connected[i] + 1);
          counter[c] = 1;
          c++;
        } else {
          for (int x = 0; x < counter[c]; x++) {
            newa.add(connected[i] + x + 1);
          }
          m = 1;
          c++;
        }
      } else {
        if (connected[i] + 1 == connected[i + 1]) {
          m++;
          counter[c] = m;
        } else if (i > 1 &&
                connected[i - 1] + 1 != connected[i] &&
                connected[i] + 1 != connected[i + 1] ||
            connected[i] + 1 != connected[i + 1] && i == 0) {
          newa.add(59 - connected[i] + 1);
          counter[c] = 1;
          c++;
        } else {
          for (int x = 0; x < counter[c]; x++) {
            newa.add(59 - connected[i] + x + 1);
          }
          m = 1;
          c++;
        }
      }
    }

    for (int z = 0; z < newa.length; z++) {
      print(newa[z]);
    }
    m = 1;
    c++;
  }

  t2() {
    List<int> all = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    List<int> res = [1, 2];

    for (int i = 0; i < res.length; i++) {
      if (all.contains(res[i])) {
        all.remove(res[i]);
      }
    }
    for (int i = 0; i < all.length; i++) {
      print(all[i]);
    }
  }
}
