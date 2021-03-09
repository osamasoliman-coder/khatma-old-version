
class KhatmaModel {
  String khatmaId,
      ownerId,
      ownerName,
      ownerEmail,
      khatmaName,
      password,
      type,
      renewal,
      notification;
  int days;
  String dateTime;
  int membersCount;
  String subject;
  String about;
  List<Map<dynamic,dynamic>> members;
  List<Map<dynamic,dynamic>> quran;
  List<Map<dynamic,dynamic>> reserved;
  List<Map<dynamic,dynamic>> allQuran;
  List<Map<dynamic,dynamic>> notReading;
  List<Map<dynamic,dynamic>> history;

  KhatmaModel({
    this.khatmaId,
    this.ownerId,
    this.ownerName,
    this.ownerEmail,
    this.khatmaName,
    this.password,
    this.type,
    this.renewal,
    this.notification,
    this.days,
    this.membersCount,
    this.dateTime,
    this.members,
    this.quran,
    this.reserved,
    this.allQuran,
    this.notReading,
    this.history,
    this.subject,
    this.about
  });

  KhatmaModel.fromJson(Map<dynamic,dynamic> maps){
    khatmaId = maps['khatmaId'];
    ownerId = maps['ownerId'];
    ownerName = maps['ownerName'];
    ownerEmail = maps['ownerEmail'];
    khatmaName = maps['khatmaName'];
    password = maps['password'];
    type = maps['type'];
    renewal = maps['renewal'];
    notification = maps['notification'];
    days = maps['days'];
    membersCount = maps['membersCount'];
    dateTime = maps['dateTime'];
    members = List.from(maps['members']);
    quran = List.from(maps['quran']);
    reserved = List.from(maps['reserved']);
    allQuran = List.from(maps['allQuran']);
    notReading = List.from(maps['notReading']);
    history = List.from(maps['history']);
    subject = maps['subject'];
    about = maps['about'];
  }

  toJson(){
    return {
      'khatmaId' : khatmaId,
       'ownerId' : ownerId,
      'ownerName' : ownerName,
      'ownerEmail' : ownerEmail,
      'khatmaName' : khatmaName,
      'password' : password,
      'type' : type,
      'renewal' : renewal,
      'notification' : notification,
      'days' :days ,
      'membersCount':membersCount,
      'dateTime' : dateTime,
      'members' : members,
      'quran' : quran,
      'reserved' : reserved,
      'allQuran' : allQuran,
      'notReading' : notReading,
      'history' : history,
      'subject' : subject,
      'about' : about
    };
  }

}
