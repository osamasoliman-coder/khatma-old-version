class MessageModel {
  String senderId, receiverId,senderName,receiverName, message, timeSend, status;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.senderName,
    this.receiverName,
    this.message,
    this.timeSend,
    this.status,
  });

  MessageModel.fromJson(Map<dynamic,dynamic> maps){
    senderId = maps['senderId'];
    receiverId = maps['receiverId'];
    senderName = maps['senderName'];
    receiverName = maps['receiverName'];
    message = maps['message'];
    timeSend = maps['timeSend'];
    status = maps['status'];
  }

  toJson(){
    return {
      'senderId' : senderId,
      'receiverId' : receiverId,
      'receiverName' : receiverName,
      'message' : message,
      'timeSend' : timeSend,
      'status' : status
    };
  }

}
