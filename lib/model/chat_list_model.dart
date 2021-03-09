
class ChatListModel{
  String senderId,receiverId,senderName,receiverName;

  ChatListModel({this.senderId, this.receiverId,this.senderName,this.receiverName});

  ChatListModel.fromJson(Map<dynamic,dynamic>map){
    senderId = map['senderId'];
    receiverId = map['receiverId'];
    senderName = map['senderName'];
    receiverName = map['receiverName'];
  }

  toJson(){
    return {
      "senderId" : senderId,
      "receiverId" : receiverId,
      "senderName": senderName,
      "receiverName" : receiverName
    };
  }
}