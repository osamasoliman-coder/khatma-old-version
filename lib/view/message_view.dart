import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatma/constance/constance.dart';
import 'package:khatma/core/viewmodel/message_view_model.dart';
import 'widget/custom_text.dart';

class MessageView extends StatefulWidget {
  String receiverId;
  String receiverName;

  MessageView({this.receiverId, this.receiverName});

  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  TextEditingController messageText = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  // final CollectionReference _chatCollection =
  //     FirebaseFirestore.instance.collection('Chat');
  //
  // final MessageViewModel controller = Get.put(MessageViewModel());
  // List<MessageModel> messageModel = [];
  //
  // Future<void> getMessages(String receiverId) async {
  //   messageModel.clear();
  //   // await Future.delayed(Duration(seconds: 1));
  //   await _chatCollection
  //       .orderBy("timeSend", descending: false)
  //       .snapshots()
  //       .listen((event) {
  //     // print(event.docs[0].data());
  //     for (int x = 0; x < event.docs.length; x++) {
  //       if (event.docs[x].data()['senderId'] == _auth.currentUser.uid &&
  //               event.docs[x].data()['receiverId'] == receiverId ||
  //           event.docs[x].data()['senderId'] == receiverId &&
  //               event.docs[x].data()['receiverId'] == _auth.currentUser.uid)
  //         messageModel.add(MessageModel.fromJson(event.docs[x].data()));
  //     }
  //   });
  // }

  // @override
  // void initState() {
  //   Future.delayed(Duration.zero, () async {
  //     getMessages(widget.receiverId);
  //   });
  //   controller.messageModel.clear();
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   controller.messageModel.clear();
  //   //controller.myChatList.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                GetBuilder<MessageViewModel>(
                  init: MessageViewModel(widget.receiverId),
                  builder: (controller) =>
                      CircleAvatar(
                        maxRadius: 20,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                image: (controller.receiverUserPic == '')
                                    ? AssetImage('assets/images/person.jpg')
                                    : NetworkImage(controller.receiverUserPic),
                              )),
                        ),
                      ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.receiverName,
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w600),
                      ),
                      // SizedBox(
                      //   height: 6,
                      // ),
                      // Text(
                      //   "",
                      //   style: TextStyle(
                      //       color: Colors.green.shade600, fontSize: 13),
                      // ),
                      // Text("Offline",style: TextStyle(color: Colors.red.shade600, fontSize: 13),),
                    ],
                  ),
                ),
                Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          GetBuilder<MessageViewModel>(
            init: MessageViewModel(widget.receiverId),
            builder: (controller) =>
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.messageModel.length,
                  itemBuilder: (context, index) {
                    return (controller.messageModel[index].senderId ==
                        _auth.currentUser.uid) ? _drawIsMe(index) : _drawIsReceiver(index);
                  },
                ),
          ),

          _drawSendMessage(context),
        ],
      ),
    );
  }

  // _drawChat() {
  //   return GetBuilder<MessageViewModel>(
  //     init: MessageViewModel(widget.receiverId),
  //     builder: (controller) => ListView.builder(
  //       itemCount: controller.messageModel.length,
  //       shrinkWrap: true,
  //       itemBuilder: (context, index) {
  //         return Row(
  //           mainAxisAlignment:
  //               (controller.messageModel[index].senderId == _auth.currentUser.uid)
  //                   ? MainAxisAlignment.end
  //                   : MainAxisAlignment.start,
  //           children: <Widget>[
  //             Container(
  //               decoration: BoxDecoration(
  //                 color: (controller.messageModel[index].senderId == _auth.currentUser.uid)
  //                     ? Colors.blue
  //                     : Colors.blueGrey,
  //                 borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(14),
  //                     topRight: Radius.circular(14),
  //                     bottomLeft:
  //                         (controller.messageModel[index].senderId == _auth.currentUser.uid)
  //                             ? Radius.circular(14)
  //                             : Radius.circular(0),
  //                     bottomRight:
  //                         (controller.messageModel[index].senderId == _auth.currentUser.uid)
  //                             ? Radius.circular(0)
  //                             : Radius.circular(14)),
  //               ),
  //               width: MediaQuery.of(context).size.width * .50,
  //               padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
  //               margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Column(
  //                     children: [
  //                       CustomText(
  //                         text: controller.messageModel[index].message,
  //                         alignment: (controller.messageModel[index].senderId ==
  //                                 _auth.currentUser.uid)
  //                             ? Alignment.topRight
  //                             : Alignment.topLeft,
  //                         color: Colors.white,
  //                         fontSize: 16,
  //                       ),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                       CustomText(
  //                         text: controller.messageModel[index].timeSend,
  //                         color: Colors.grey.shade300,
  //                         alignment: (controller.messageModel[index].senderId ==
  //                                 _auth.currentUser.uid)
  //                             ? Alignment.bottomLeft
  //                             : Alignment.bottomRight,
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

  _drawIsMe(int index) {
    return  GetBuilder<MessageViewModel>(
      init: MessageViewModel(widget.receiverId),
      builder: (controller) => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14),
                          bottomLeft: Radius.circular(14),
                          bottomRight: Radius.circular(0),
                        ),
                      ),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .50,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: [
                              CustomText(
                                text: controller.messageModel[index].message,
                                alignment: Alignment.topRight,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                text: controller.messageModel[index].timeSend,
                                color: Colors.grey.shade300,
                                alignment: Alignment.bottomLeft,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                              image: (controller.currentUserPic == '')
                                  ? AssetImage('assets/images/person.jpg')
                                  : NetworkImage(controller.currentUserPic),
                              fit: BoxFit.cover)),
                    ),
                  ],
                ),
    );
  }

  _drawIsReceiver(int index) {
    return GetBuilder<MessageViewModel>(
      init: MessageViewModel(widget.receiverId),
      builder: (controller) =>
          Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                            image: (controller.receiverUserPic == '')
                                ? AssetImage('assets/images/person.jpg')
                                : NetworkImage(controller.receiverUserPic),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(14)),
                    ),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * .50,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: [
                            CustomText(
                              text: controller.messageModel[index].message,
                              alignment: (controller.messageModel[index]
                                  .senderId ==
                                  _auth.currentUser.uid)
                                  ? Alignment.topRight
                                  : Alignment.topLeft,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              text: controller.messageModel[index].timeSend,
                              color: Colors.grey.shade300,
                              alignment: Alignment.bottomRight,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }

  _drawSendMessage(BuildContext context) {
    return GetBuilder<MessageViewModel>(
      init: MessageViewModel(widget.receiverId),
      builder: (controller) =>
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Form(
                    key: _keyForm,
                    child: Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextFormField(
                                controller: messageText,
                                onSaved: (value) {
                                  messageText.text = value;
                                },
                                decoration: InputDecoration(
                                    hintText: "Write message...",
                                    hintStyle: TextStyle(color: Colors.black54),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              _keyForm.currentState.save();
                              if (messageText.text != "") {
                                controller.createMessage(
                                    context, messageText.text,
                                    widget.receiverId, widget.receiverName);
                                messageText.clear();
                              }
                              // controller.getDataSender();
                              //controller.getAllMessageBasedOnIdTest();
                              //controller.getMessages();
                              // print(controller.messageModel.length);
                            },
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                            backgroundColor: Colors.blue,
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
