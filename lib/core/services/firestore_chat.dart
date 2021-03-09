import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService{
  final CollectionReference _chatListCollection =
  FirebaseFirestore.instance.collection('ChatList');

  Future<List<QueryDocumentSnapshot>> getMyChatList()async{
    var value =  await _chatListCollection.get();

    return value.docs;
  }
}