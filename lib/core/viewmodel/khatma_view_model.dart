import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khatma/model/khatma_model.dart';
import 'package:uuid/uuid.dart';

class KhatmaViewModel extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _khatmaCollection =
      FirebaseFirestore.instance.collection('Khatma');

  RxMap map = Map().obs;

  // final HomeViewModel homeViewModel = Get.put(HomeViewModel());

  Uuid uuid = Uuid();
  Map<dynamic, dynamic> members;
  String khatmaId, _ownerId, _ownerName, _ownerEmail, dateTime;
  String name, password, subject, about;
  String _dropdownValue = 'Public';
  String _notificationValue = 'Yes';
  String _renewValue = 'Yes';
  String _daysValue = '60';

  String get ownerId => _ownerId;

  String get ownerName => _ownerName;

  String get ownerEmail => _ownerEmail;

  String get dropdownValue => _dropdownValue;

  String get notificationValue => _notificationValue;

  String get renewValue => _renewValue;

  String get daysValue => _daysValue;
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  bool _create = false;

  bool get create => _create;

  bool _checkKhatmaName = false;
  bool get checkKhatmaName => _checkKhatmaName;


  List<String> typeItems = ['Public', 'Private'];
  List<String> notificationItems = ['Yes', 'No'];
  List<String> renewItems = ['Yes', 'No'];
  List<String> daysItems = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50',
    '51',
    '52',
    '53',
    '54',
    '55',
    '56',
    '57',
    '58',
    '59',
    '60'
  ];

  @override
  void onInit() {
    super.onInit();
    getUserData();
    update();
  }

  typeChange(String data) {
    _dropdownValue = data;
    update();
  }

  notificationChange(String data) {
    _notificationValue = data;
    update();
  }

  renewalChange(String data) {
    _renewValue = data;
    update();
  }

  daysChange(String data) {
    _daysValue = data;
    update();
  }

  getUserData() async {
    final CollectionReference _userCollection =
        FirebaseFirestore.instance.collection('Users');
    _userCollection.doc(_auth.currentUser.uid).snapshots().listen((event) {
      _ownerId = event.data()['userId'];
      _ownerName = event.data()['name'];
      _ownerEmail = event.data()['email'];
    });
    update();
  }

  createNewKhatma() async {
    var random = Random();
    int n1 = random.nextInt(100);
    int n2 = random.nextInt(1000);
    List<Map> membersMaps = [
      {
        'memberId': _ownerId,
        'memberName': _ownerName,
        'memberEmail': _ownerEmail
      }
    ];

    // quran En
    List<Map> quran = [
      {
        'quranEn': 'First Juz - First Hizb',
        'quranAr': 'الجزء الأول - الحزب الأول',
        'n' : 1
      },
      {
        'quranEn': 'First Juz - Second Hizb',
        'quranAr': 'الجزء الأول - الحزب الثاني',
        'n' : 2
      },
      {
        'quranEn': 'Second Juz - First Hizb',
        'quranAr': 'الجزء الثاني - الحزب الأول',
        'n' : 3
      },
      {
        'quranEn': 'Second Juz - Second Hizb',
        'quranAr': 'الجزء الثاني - الحزب الثاني',
        'n' : 4
      },
      {
        'quranEn': 'Third Juz - First Hizb',
        'quranAr': 'الجزء الثالث - الحزب الأول',
        'n' : 5
      },
      {
        'quranEn': ' Third Juz - Second Hizb',
        'quranAr': 'الجزء الثالث - الحزب الثاني',
        'n' : 6
      },
      {
        'quranEn': 'Fourth Juz - First Hizb',
        'quranAr': 'الجزء الرابع - الحزب الأول',
        'n' : 7
      },
      {
        'quranEn': 'Fourth Juz - Second Hizb',
        'quranAr': 'الجزء الرابع - الحزب الثاني',
        'n' : 8
      },
      {
        'quranEn': 'Fifth Juz - First Hizb',
        'quranAr': 'الجزء الخامس - الحزب الأول',
        'n' : 9
      },
      {
        'quranEn': 'Fifth Juz - Second Hizb',
        'quranAr': 'الجزء الخامس - الحزب الثاني',
        'n' : 10
      },
      {
        'quranEn': 'Sixth Juz - First Hizb',
        'quranAr': 'الجزء السادس - الحزب الأول',
        'n' : 11
      },
      {
        'quranEn': 'Sixth Juz - Second Hizb',
        'quranAr': 'الجزء السادس - الحزب الثاني',
        'n' : 12
      },
      {
        'quranEn': 'Seventh Juz - First Hizb',
        'quranAr': 'الجزء السابع - الحزب الأول',
        'n' : 13
      },
      {
        'quranEn': 'Seventh Juz - Second Hizb',
        'quranAr': 'الجزء السابع - الحزب الثاني',
        'n' : 14
      },
      {
        'quranEn': 'Eighth Juz - First Hizb',
        'quranAr': 'الجزء الثامن - الحزب الأول',
        'n' : 15
      },
      {
        'quranEn': 'Eighth Juz - Second Hizb',
        'quranAr': 'الجزء الثامن - الحزب الثاني',
        'n' : 16
      },
      {
        'quranEn': 'Ninth Juz - First Hizb',
        'quranAr': 'الجزء التاسع - الحزب الأول',
        'n' : 17
      },
      {
        'quranEn': ' Ninth Juz - Second Hizb',
        'quranAr': ' الجزء التاسع - الحزب الثاني',
        'n' : 18
      },
      {
        'quranEn': 'Tenth Juz - First Hizb',
        'quranAr': 'الجزء العاشر - الحزب الأول',
        'n' : 19
      },
      {
        'quranEn': 'Tenth Juz - Second Hizb',
        'quranAr': 'الجزء العاشر - الحزب الثاني',
        'n' : 20
      },
      {
        'quranEn': 'Eleventh Juz - First Hizb',
        'quranAr': 'الجزء الحادي عشر - الحزب الأول',
        'n' : 21
      },
      {
        'quranEn': 'Eleventh Juz - Second Hizb',
        'quranAr': 'الجزء الحادي عشر - الحزب الثاني ',
        'n' : 22
      },
      {
        'quranEn': 'Twelfth Juz - First Hizb',
        'quranAr': 'الجزء الثاني عشر - الحزب الأول',
        'n' : 23
      },
      {
        'quranEn': 'Twelfth Juz - Second Hizb',
        'quranAr': 'الجزء الثاني عشر - الحزب الثاني',
        'n' : 24
      },
      {
        'quranEn': 'Thirteenth Juz - First Hizb',
        'quranAr': 'الجزء الثالث عشر - الحزب الأول',
        'n' : 25
      },
      {
        'quranEn': ' Thirteenth Juz - Second Hizb',
        'quranAr': ' الجزء الثالث عشر - الحزب الثاني',
        'n' : 26
      },
      {
        'quranEn': 'Fourteenth Juz - First Hizb',
        'quranAr': 'الجزء الرابع عشر - الحزب الأول',
        'n' : 27
      },
      {
        'quranEn': ' Fourteenth Juz - Second Hizb',
        'quranAr': ' الجزء الرابع عشر - الحزب الثاني',
        'n' : 28
      },
      {
        'quranEn': 'Fifteenth Juz - First Hizb',
        'quranAr': 'الجزء الخامس عشر - الحزب الأول',
        'n' : 29
      },
      {
        'quranEn': 'Fifteenth Juz - Second Hizb',
        'quranAr': 'الجزء الخامس عشر - الحزب الثاني',
        'n' : 30
      },
      {
        'quranEn': 'Sixteenth Juz - First Hizb',
        'quranAr': 'الجزء السادس عشر - الحزب الأول',
        'n' : 31
      },
      {
        'quranEn': 'Sixteenth Juz - Second Hizb',
        'quranAr': 'الجزء السادس عشر - الحزب الثاني',
        'n' : 32
      },
      {
        'quranEn': 'Seventeenth Juz - First Hizb',
        'quranAr': 'الجزء السابع عشر - الحزب الأول',
        'n' : 33
      },
      {
        'quranEn': ' Seventeenth Juz - Second Hizb',
        'quranAr': 'الجزء السابع عشر - الحزب الثاني',
        'n' : 34
      },
      {
        'quranEn': 'Eighteenth Juz - First Hizb',
        'quranAr': 'الجزء الثامن عشر - الحزب الأول',
        'n' : 35
      },
      {
        'quranEn': ' Eighteenth Juz - Second Hizb ',
        'quranAr': 'الجزء الثامن عشر - الحزب الثاني',
        'n' : 36
      },
      {
        'quranEn': 'Nineteenth Juz - First Hizb',
        'quranAr': 'الجزء التاسع عشر - الحزب الأول',
        'n' : 37
      },
      {
        'quranEn': 'Nineteenth Juz - Second Hizb',
        'quranAr': 'الجزء التاسع عشر - الحزب الثاني',
        'n' : 38
      },
      {
        'quranEn': 'Twentieth Juz - First Hizb',
        'quranAr': 'الجزء عشرون - الحزب الأول',
        'n' : 39
      },
      {
        'quranEn': 'Twentieth Juz - Second Hizb',
        'quranAr': 'الجزء عشرون - الحزب الثاني',
        'n' : 40
      },
      {
        'quranEn': 'Twenty-first Juz - First Hizb',
        'quranAr': 'الجزء واحد وعشرون - الحزب الأول',
        'n' : 41
      },
      {
        'quranEn': ' Twenty-first Juz - Second Hizb',
        'quranAr': ' الجزء واحد وعشرون - الحزب الثاني',
        'n' : 42
      },
      {
        'quranEn': 'Twenty-second Juz - First Hizb',
        'quranAr': 'الجزء اثنان وعشرون - الحزب الأول',
        'n' : 43
      },
      {
        'quranEn': 'Twenty-second Juz - Second Hizb',
        'quranAr': 'الجزء اثنان وعشرون - الحزب الثاني',
        'n' : 44
      },
      {
        'quranEn': 'Twenty-third Juz - First Hizb',
        'quranAr': 'الجزء ثلاثة وعشرون - الحزب الأول',
        'n' : 45
      },
      {
        'quranEn': ' Twenty-third Juz - Second Hizb',
        'quranAr': 'الجزء ثلاثة وعشرون - الحزب الثاني',
        'n' : 46
      },
      {
        'quranEn': 'Twenty-fourth Juz - First Hizb',
        'quranAr': 'الجزء أربعة وعشرون - الحزب الأول',
        'n' : 47
      },
      {
        'quranEn': 'Twenty-fourth Juz - Second Hizb',
        'quranAr': 'الجزء أربعة وعشرون - الحزب الثاني',
        'n' : 48
      },
      {
        'quranEn': 'Twenty-fifth Juz - First Hizb',
        'quranAr': 'الجزء خمسة وعشرون - الحزب الأول',
        'n' : 49
      },
      {
        'quranEn': 'Twenty-fifth Juz - Second Hizb',
        'quranAr': 'الجزء خمسة وعشرون - الحزب الثاني',
        'n' : 50
      },
      {
        'quranEn': 'Twenty-sixth Juz - First Hizb',
        'quranAr': 'الجزء ستة وعشرون - الحزب الأول',
        'n' : 51
      },
      {
        'quranEn': 'Twenty-sixth Juz - Second Hizb',
        'quranAr': 'الجزء ستة وعشرون - الحزب الثاني',
        'n' : 52
      },
      {
        'quranEn': 'Twenty-seventh Juz - First Hizb',
        'quranAr': 'الجزء سبعة وعشرون - الحزب الأول',
        'n' : 53
      },
      {
        'quranEn': ' Twenty-seventh Juz - Second Hizb',
        'quranAr': 'الجزء سبعة وعشرون - الحزب الثاني',
        'n' : 54
      },
      {
        'quranEn': 'Twenty-eighth Juz - First Hizb',
        'quranAr': 'الجزء ثمانية وعشرون - الحزب الأول',
        'n' : 55
      },
      {
        'quranEn': 'Twenty-eighth Juz - Second Hizb',
        'quranAr': 'الجزء ثمانية وعشرون - الحزب الثاني',
        'n' : 56
      },
      {
        'quranEn': 'Twenty-ninth Juz - First Hizb',
        'quranAr': 'الجزء تسعة وعشرون - الحزب الأول',
        'n' : 57
      },
      {
        'quranEn': 'Twenty-ninth Juz - Second Hizb',
        'quranAr': 'الجزء تسعة وعشرون - الحزب الثاني',
        'n' : 58
      },
      {
        'quranEn': 'Thirtieth Juz - First Hizb',
        'quranAr': 'الجزء ثلاثون - الحزب الأول',
        'n' : 59
      },
      {
        'quranEn': 'Thirtieth Juz - Second Hizb',
        'quranAr': 'الجزء ثلاثون - الحزب الثاني',
        'n' : 60
      }
    ];
    Map mapas = {};
    await _khatmaCollection.doc("$n1" + "$n2").set(KhatmaModel(
            khatmaId: "$n1" + "$n2",
            ownerId: _ownerId,
            ownerName: _ownerName,
            ownerEmail: _ownerEmail,
            khatmaName: name,
            password: password,
            type: _dropdownValue,
            renewal: _renewValue,
            notification: _notificationValue,
            days: int.parse(_daysValue),
            membersCount: 0,
            dateTime: formattedDate,
            members: membersMaps,
            quran: quran,
            reserved: [],
            allQuran: quran,
            notReading: quran,
            history: [],
            subject: subject,
            about: about)
        .toJson());

    // to add in mylist and show in home page;
    map.value = {
      "khatmaId": "$n1" + "$n2",
      "ownerId": _ownerId,
      "ownerName": _ownerName,
      "ownerEmail": _ownerEmail,
      "khatmaName": name,
      "password": password,
      "type": _dropdownValue,
      "renewal": _renewValue,
      "notification": _notificationValue,
      "days": int.parse(_daysValue),
      "membersCount": "0",
      "dateTime": formattedDate,
      "members": membersMaps,
      "subject": subject,
      "about": about
    };
    update();
  }

  checkIfNakeAlreadyExists()async {
    _checkKhatmaName = false;
    await _khatmaCollection.get().then((value){
      for(int i=0;i<value.docs.length;i++){
        if(name == value.docs[i].data()['khatmaName']){
          _checkKhatmaName = true;
          break;
        }
        else{
          _checkKhatmaName = false;
        }
      }
     // print(_checkKhatmaName);
      update();
    });
  }

}
