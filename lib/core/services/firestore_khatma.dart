import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeService {

FirebaseAuth _auth = FirebaseAuth.instance;

final CollectionReference _khatmaCollection =
      FirebaseFirestore.instance.collection('Khatma');

final CollectionReference _khatmaLeaveMemberCollection =
FirebaseFirestore.instance.collection('Khatma');


  Future<List<QueryDocumentSnapshot>> getOnyMyKhatma()async{
   var value =  await _khatmaCollection.get();

   return value.docs;
  }

}
