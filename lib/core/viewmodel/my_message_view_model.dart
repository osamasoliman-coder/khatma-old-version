import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:khatma/core/services/firestore_chat.dart';
import 'package:khatma/model/chat_list_model.dart';

class MyMessageViewModel extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  List<ChatListModel> _myChatList = [];

  List<ChatListModel> get myChatList => _myChatList;

  final List<ChatListModel> _list = [];

  List<ChatListModel> get list => _list;

  List<ChatListModel> _myList = [];

  List<ChatListModel> get myList => _myList;

  CollectionReference _chatList =
      FirebaseFirestore.instance.collection('ChatList');

  MyMessageViewModel() {
    getAllMyMessages();
    test2();
  }

  getAllMyMessages() async {
    _myChatList.clear();
    List<ChatListModel> list = [];
    ChatService().getMyChatList().then((value) {
      for (int i = 0; i < value.length; i++) {
        if (value[i].data()['senderId'] == _auth.currentUser.uid &&
            value[i].data()['receiverId'] == value[i].data()['receiverId']) {
          _myChatList.add(ChatListModel.fromJson(value[i].data()));
        } else if (value[i].data()['receiverId'] == _auth.currentUser.uid &&
            value[i].data()['senderId'] == value[i].data()['senderId']) {
          _myChatList.add(ChatListModel.fromJson(value[i].data()));
        }
      }
      update();
    });
  }

  test() async {
    List<ChatListModel> list = [];

    for (int i = 0; i < _myChatList.length; i++) {
      for (int i = 0; i < _myChatList.length; i++) {
        if (_myChatList[i].senderId == _auth.currentUser.uid) {
          //sender
          FirebaseFirestore.instance
              .collection('ChatList')
              .doc(_auth.currentUser.uid + _myChatList[i].receiverId)
              .get()
              .then((value) {
            list.add(ChatListModel.fromJson(value.data()));
          });
          break;
        }
      }
    }
    print(list.length);
  }

  test2() async {
    _myList.clear();
    _list.clear();
    _chatList.get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        _list.add(ChatListModel.fromJson(value.docs[i].data()));
      }
      for (int i = 0; i < _list.length; i++) {
     if (_list[i].receiverId == _auth.currentUser.uid){
          _chatList
              .doc(_list[i].senderId + _list[i].receiverId)
              .get()
              .then((value) {
            _myList.add(ChatListModel.fromJson(value.data()));
            update();
          });
        }
      }
      update();
    });


  }
}
