import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:khatma/model/khatma_model.dart';

class QuranViewModel extends GetxController {
  final CollectionReference _khatmaCollection =
      FirebaseFirestore.instance.collection('Khatma');

  FirebaseAuth _auth = FirebaseAuth.instance;

  List<KhatmaModel> _myKhatmaList = [];

  List<Map> _quran = [];
  List<Map> _map = [];

  RxList addToMap = List<Map>().obs;


  RxInt changeGridValue;

  bool found = false;

  QuranViewModel() {
    changeGridValue = 2.obs;
    update();
  }

  incrementValue(int value) {
    changeGridValue.value = value;
    update();
  }

  getValueSelected(int index, Map map) {
      for (int i = 0; i < addToMap.length; i++) {
        if (addToMap[i] == map) {
          found = true;
          break;
        }
    }
    if (found == true) {
      addToMap.remove(map);
    } else {
      addToMap.add(map);
    }
   // print(addToMap.length);
    found = false;
    update();
  }

  getDataFromKhatma(String KhatmaId) async {
    await _khatmaCollection.doc(KhatmaId).get().then((value) {
      _myKhatmaList.add(KhatmaModel.fromJson(value.data()));
      print(_myKhatmaList[0].quran.length);
    });
    update();
  }

  reserveQoz(khatmaId) async {
    _myKhatmaList.clear();
    _quran.clear();
    _map.clear();

   await _khatmaCollection.doc(khatmaId).get().then((value) {
      _myKhatmaList.add(KhatmaModel.fromJson(value.data()));
    });

    for (int i = 0; i < _myKhatmaList[0].reserved.length; i++) {
     _map.add(_myKhatmaList[0].reserved[i]);
    }
    for (int i = 0; i < _myKhatmaList[0].quran.length; i++) {
     _quran.add(_myKhatmaList[0].quran[i]);
    }

    for(int x=0;x<_quran.length;x++){
      for(int a=0;a<addToMap.length;a++){
        if(_quran[x]['quranEn'] == addToMap[a]['quranEn']){
          _quran.removeAt(x);
        }
      }
    }
    Map resMap ={
          'quran': addToMap,
          'memberReservedEmail': _auth.currentUser.email,
          'memberReservedId': _auth.currentUser.uid
    };
    _map.add(resMap);
    //set data
    await _khatmaCollection.doc(khatmaId).update({
      'quran': _quran,
      'reserved': _map
    });
    update();
  }
}
