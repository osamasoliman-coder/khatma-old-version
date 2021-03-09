class KhatmaChatModel {
  String khatmaId, userId, currentUserName, currentUserPic, message, timeSend;

  KhatmaChatModel({
    this.khatmaId,
    this.userId,
    this.currentUserName,
    this.currentUserPic,
    this.message,
    this.timeSend,
  });

  KhatmaChatModel.fromJson(Map<dynamic, dynamic> map) {
    khatmaId = map['khatmaId'];
    userId = map['userId'];
    currentUserName = map['currentUserName'];
    currentUserPic = map['currentUserPic'];
    message = map['message'];
    timeSend = map['timeSend'];
  }

  toJson() {
    return {
      'khatmaId': khatmaId,
      'userId': userId,
      'currentUserName': currentUserName,
      'currentUserPic': currentUserPic,
      'message': message,
      'timeSend': timeSend
    };
  }
}
