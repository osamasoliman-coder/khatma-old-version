import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreChatKhatma {
  final CollectionReference _chatListCollection =
  FirebaseFirestore.instance.collection('PublicChat');

  final CollectionReference _addToPublicChat = FirebaseFirestore.instance.collection('PublicChat');
   CollectionReference get addToPublicChat => _addToPublicChat;


  Future<List<QueryDocumentSnapshot>> getKhatmaPublicChat() async {
    var value = await _chatListCollection.get();
    return value.docs;
  }

}