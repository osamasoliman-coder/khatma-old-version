class MyWerdModel {
  String  memberReservedEmail;
  String memberReservedId;
  String khatmaName;

  List<Map<dynamic,dynamic>> quranForCurrentUser;

  MyWerdModel({
    this.memberReservedId,
    this.memberReservedEmail,
    this.quranForCurrentUser,
    this.khatmaName,
  });

  MyWerdModel.fromJson(Map<dynamic,dynamic> map){
    memberReservedId = map['memberReservedId'];
    memberReservedEmail = map['memberReservedEmail'];
    quranForCurrentUser = List.from(map['quran']);
    khatmaName = map['khatmaName'];
  }

  toJson(){
    return{
      'memberReservedId' : memberReservedId,
      'memberReservedEmail' : memberReservedEmail,
      'quranForCurrentUser' : quranForCurrentUser,
      'khatmaName' : khatmaName,
    };

  }

}