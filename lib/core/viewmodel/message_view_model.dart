import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khatma/model/chat_list_model.dart';
import 'package:khatma/model/message_model.dart';
import 'package:khatma/model/user_model.dart';

class MessageViewModel extends GetxController {

  final CollectionReference _chatCollection =
  FirebaseFirestore.instance.collection('Chat');
  final CollectionReference _userCollection =
  FirebaseFirestore.instance.collection('Users');
  final CollectionReference _chatListCollection =
  FirebaseFirestore.instance.collection('ChatList');
  final FirebaseAuth _auth = FirebaseAuth.instance;


  List<MessageModel> _messageModel = [];
  List<MessageModel> get messageModel => _messageModel;

  RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;


  RxList _userList = List<UserModel>().obs;
  RxList _chatList = List<ChatListModel>().obs;

  RxList get chatList => _chatList;

  RxList get userList => _userList;
  String currentName = "";
  bool found = false;

  String _receiverUserPic = '';
  String get receiverUserPic => _receiverUserPic;

  String _currentUserPic = '';
  String get currentUserPic => _currentUserPic;


  MessageViewModel(String receiverId){
    getMessages(receiverId);
    getReceiverPicture(receiverId);
    getCurrentUserPicture();
  }

  createMessage(BuildContext context, String messageText, String receiverId, String receiverName) async {
    FocusScope.of(context).unfocus();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm').format(now);


    _userCollection.doc(_auth.currentUser.uid).get().then((value) {
      currentName = value.data()['name'];
    });
    await _chatCollection
        .doc()
        .set(MessageModel(
        receiverId: receiverId,
        senderId: _auth.currentUser.uid,
        receiverName: receiverName,
        senderName: currentName,
        message: messageText,
        timeSend: formattedDate)
        .toJson());
    Map map;
    Map addToCurrentList;
    addToCurrentList = {
      "receiverId": receiverId,
      "senderId": _auth.currentUser.uid,
      "receiverName": receiverName,
      "senderName": currentName,
      "message": messageText,
      "timeSend": formattedDate
    };
    _messageModel.add(MessageModel.fromJson(addToCurrentList));

    await _chatListCollection.get().then((value){
      if(value.docs.length>0) {
        for (int i = 0; i < value.docs.length; i++) {
          if(value.docs[i].data()['senderId'] != _auth.currentUser.uid && value.docs[i]['receiverId'] != receiverId || value.docs[i]['receiverId'] != _auth.currentUser.uid &&  value.docs[i]['senderId'] != receiverId){
            //add to chatlist
            _chatListCollection.doc(_auth.currentUser.uid + receiverId).set(
                ChatListModel(
                    senderId: _auth.currentUser.uid,
                    receiverId: receiverId,
                    senderName: currentName,
                    receiverName: receiverName
                ).toJson()
            );
          }
        }
      }
      else{
        //add to chatlist
        _chatListCollection.doc(_auth.currentUser.uid + receiverId).set(
            ChatListModel(
                senderId: _auth.currentUser.uid,
                receiverId: receiverId,
                senderName: currentName,
                receiverName: receiverName
            ).toJson()
        );
      }
    });



    update();
  }

  Future<void> getMessages(String receiverId) async {
     await _chatCollection.orderBy('timeSend',descending: false).get().then((event) {
       for (int x = 0; x < event.docs.length; x++) {
         if (event.docs[x].data()['senderId'] == _auth.currentUser.uid &&
             event.docs[x].data()['receiverId'] == receiverId ||
             event.docs[x].data()['senderId'] == receiverId &&
                 event.docs[x].data()['receiverId'] == _auth.currentUser.uid)
           _messageModel.add(MessageModel.fromJson(event.docs[x].data()));
       }
       update();
     });
  }

  getReceiverPicture(String receiverId)async{
    //current user data
    await _userCollection.doc(receiverId).get().then((value) {
      _receiverUserPic = value.data()['pic'];
      update();
    });
  }

  getCurrentUserPicture()async{
    //current user data
    await _userCollection.doc(_auth.currentUser.uid).get().then((value) {
      _currentUserPic = value.data()['pic'];
      update();
    });
  }

}