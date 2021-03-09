class PublicChatListModel {
  String khatmaId, khatmaName, timeSend, message;

  PublicChatListModel({
    this.khatmaId,
    this.khatmaName,
    this.timeSend,
    this.message,
  });

  PublicChatListModel.fromJson(Map map) {
    khatmaId = map['khatmaId'];
    khatmaName = map['khatmaName'];
    timeSend = map['timeSend'];
    message = map['message'];
  }

  toJson() {
    return {
      'khatmaId': khatmaId,
      'khatmaName' : khatmaName,
      'timeSend': timeSend,
      'message': message,
    };
  }
}
