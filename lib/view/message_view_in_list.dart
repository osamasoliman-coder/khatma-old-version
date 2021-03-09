// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:khatma/core/viewmodel/message_view_model.dart';
//
// import 'widget/custom_text.dart';
//
// class MessageViewInList extends StatefulWidget {
//
//   String receiverId;
//   String receiverName;
//
//   MessageViewInList({
//     this.receiverId,
//     this.receiverName
//   });
//
//   @override
//   _MessageViewInListState createState() => _MessageViewInListState();
// }
//
// class _MessageViewInListState extends State<MessageViewInList> {
//   GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
//
//   TextEditingController messageText = TextEditingController();
//
//   FirebaseAuth _auth = FirebaseAuth.instance;
//
//   final MessageViewModel controller = Get.put(MessageViewModel());
//
//   @override
//   void initState() {
//
//     Future.delayed(Duration.zero, () async {
//       await controller.getMessages(widget.receiverId);
//     });
//     controller.myChatList.clear();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     controller.myChatList.clear();
//     //controller.myChatList.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         brightness: Brightness.light,
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         flexibleSpace: SafeArea(
//           child: Container(
//             padding: EdgeInsets.only(right: 16),
//             child: Row(
//               children: <Widget>[
//                 IconButton(
//                   onPressed: () {
//                     // controllers.messageModel.clear();
//                     //Navigator.pop(context);
//                     Get.back();
//                   },
//                   icon: Icon(
//                     Icons.arrow_back,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 2,
//                 ),
//                 CircleAvatar(
//                   maxRadius: 20,
//                 ),
//                 SizedBox(
//                   width: 12,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         widget.receiverName,
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w600),
//                       ),
//                       // SizedBox(
//                       //   height: 6,
//                       // ),
//                       // Text(
//                       //   "",
//                       //   style: TextStyle(
//                       //       color: Colors.green.shade600, fontSize: 13),
//                       // ),
//                       // Text("Offline",style: TextStyle(color: Colors.red.shade600, fontSize: 13),),
//                     ],
//                   ),
//                 ),
//                 Icon(
//                   Icons.settings,
//                   color: Colors.black54,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Stack(
//         children: <Widget>[
//           // _drawChatScreen(),
//           // _drawChatTest(context),
//           _drawChat(),
//           _drawSendMessage(context),
//         ],
//       ),
//     );
//   }
//
//
//   _drawChat() {
//     return Obx(
//           () => ListView.builder(
//           itemCount: controller.messageModel.length,
//           shrinkWrap: true,
//           itemBuilder: (context, index) {
//             return Row(
//               mainAxisAlignment: (controller.messageModel[index].senderId ==
//                   _auth.currentUser.uid)
//                   ? MainAxisAlignment.end
//                   : MainAxisAlignment.start,
//               children: <Widget>[
//                 Container(
//                   decoration: BoxDecoration(
//                     color: (controller.messageModel[index].senderId ==
//                         _auth.currentUser.uid)
//                         ? Colors.blue
//                         : Colors.blueGrey,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(14),
//                         topRight: Radius.circular(14),
//                         bottomLeft: (controller.messageModel[index].senderId ==
//                             _auth.currentUser.uid)
//                             ? Radius.circular(14)
//                             : Radius.circular(0),
//                         bottomRight: (controller.messageModel[index].senderId ==
//                             _auth.currentUser.uid)
//                             ? Radius.circular(0)
//                             : Radius.circular(14)),
//                   ),
//                   width: MediaQuery.of(context).size.width * .50,
//                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                   margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Column(
//                         children: [
//                           CustomText(
//                             text: controller.messageModel[index].message,
//                             alignment:
//                             (controller.messageModel[index].senderId ==
//                                 _auth.currentUser.uid)
//                                 ? Alignment.topRight
//                                 : Alignment.topLeft,
//                             color: Colors.white,
//                             fontSize: 16,
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           CustomText(
//                             text: controller.messageModel[index].timeSend,
//                             color: Colors.grey.shade300,
//                             alignment:
//                             (controller.messageModel[index].senderId ==
//                                 _auth.currentUser.uid)
//                                 ? Alignment.bottomLeft
//                                 : Alignment.bottomRight,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }),
//     );
//   }
//
//   _drawSendMessage(BuildContext context) {
//     return GetBuilder<MessageViewModel>(
//       builder: (controller) => Align(
//         alignment: Alignment.bottomLeft,
//         child: Container(
//           padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
//           height: 60,
//           width: double.infinity,
//           color: Colors.white,
//           child: Row(
//             children: <Widget>[
//
//               SizedBox(
//                 width: 15,
//               ),
//               Form(
//                 key: _keyForm,
//                 child: Expanded(
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           padding: EdgeInsets.only(left: 20),
//                           decoration: BoxDecoration(
//                               color: Colors.grey.shade300,
//                               borderRadius: BorderRadius.circular(20)),
//                           child: TextFormField(
//                             controller: messageText,
//                             onSaved: (value) {
//                               messageText.text = value;
//                             },
//                             decoration: InputDecoration(
//                                 hintText: "Write message...",
//                                 hintStyle: TextStyle(color: Colors.black54),
//                                 border: InputBorder.none),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 15,
//                       ),
//                       FloatingActionButton(
//                         onPressed: () {
//                           _keyForm.currentState.save();
//                           if (messageText.text != "") {
//                             controller.createMessage(context, messageText.text,widget.receiverId,widget.receiverName);
//                             messageText.clear();
//                           }
//                           // controller.getDataSender();
//                           //controller.getAllMessageBasedOnIdTest();
//                           //controller.getMessages();
//                           // print(controller.messageModel.length);
//                         },
//                         child: Icon(
//                           Icons.send,
//                           color: Colors.white,
//                           size: 18,
//                         ),
//                         backgroundColor: Colors.blue,
//                         elevation: 0,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
