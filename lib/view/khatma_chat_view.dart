import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatma/constance/constance.dart';
import 'package:khatma/core/viewmodel/khatma_chat_view_model.dart';
import 'package:khatma/view/widget/custom_text.dart';

class KhatmaChatView extends StatefulWidget {
  String khatmaId;
  String khatmaName;

  KhatmaChatView({
    this.khatmaId,
    this.khatmaName,
  });

  @override
  _KhatmaChatViewState createState() => _KhatmaChatViewState();
}

class _KhatmaChatViewState extends State<KhatmaChatView> {
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  ScrollController _controller = new ScrollController();
  TextEditingController messageText = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  KhatmaChatViewModel khatmaChatViewModel = Get.put(KhatmaChatViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    khatmaChatViewModel.khatmaChatModel.clear();
    Future.delayed(Duration.zero, () async {
      khatmaChatViewModel.khatmaChatModel.clear();
      await khatmaChatViewModel.getAllChatInKhatmaById(widget.khatmaId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Khatma',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey.shade300),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              widget.khatmaName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
          ],
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back)),
      ),
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: <Widget>[
          _drawChatPublic(),
          _drawSendMessage(context),
        ],
      ),
    );
  }

  _drawChatPublic() {
    return GetBuilder<KhatmaChatViewModel>(
      init: KhatmaChatViewModel(),
      builder: (controller) => ListView.builder(
        itemCount: controller.khatmaChatModel.length,
        shrinkWrap: false,
        controller: _controller,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return (controller.khatmaChatModel[index].userId ==
                  _auth.currentUser.uid)
              ? _drawIsMe(_auth.currentUser.uid, index)
              : _drawIsMembers(index);
        },
      ),
    );
  }

  _drawIsMe(String userId, int index) {
    return GetBuilder<KhatmaChatViewModel>(
      init: KhatmaChatViewModel(),
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                      bottomRight: Radius.circular(0)),
                ),
                width: MediaQuery.of(context).size.width * .60,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      children: [
                        CustomText(
                          text: controller.khatmaChatModel[index].message,
                          alignment: Alignment.topRight,
                          color: Colors.white,
                          fontSize: 17,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: controller.khatmaChatModel[index].timeSend,
                              color: Colors.grey.shade300,
                              alignment: Alignment.bottomRight,
                            ),
                            Row(
                              children: [
                                CustomText(
                                  text: 'From',
                                  color: Colors.grey.shade100,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CustomText(
                                  text: controller
                                      .khatmaChatModel[index].currentUserName,
                                  color: Colors.grey.shade300,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 6, top: 30),
            width: 50,
            height: 50,
            alignment: Alignment.bottomRight,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: (controller.currentUserPic == '')
                      ? AssetImage('assets/images/person.jpg')
                      : NetworkImage(controller.currentUserPic),
                  fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ],
      ),
    );
  }

  _drawIsMembers(int index) {
    return GetBuilder<KhatmaChatViewModel>(
      init: KhatmaChatViewModel(),
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 6, top: 30),
            width: 50,
            height: 50,
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image:
                      (controller.khatmaChatModel[index].currentUserPic == '')
                          ? AssetImage('assets/images/person.jpg')
                          : NetworkImage(
                              controller.khatmaChatModel[index].currentUserPic),
                  fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(14)),
                ),
                width: MediaQuery.of(context).size.width * .60,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: [
                        CustomText(
                          text: controller.khatmaChatModel[index].message,
                          alignment: Alignment.topLeft,
                          color: Colors.white,
                          fontSize: 17,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CustomText(
                                  text: 'From',
                                  color: Colors.grey.shade100,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CustomText(
                                  text: controller
                                      .khatmaChatModel[index].currentUserName,
                                  color: Colors.grey.shade300,
                                ),
                              ],
                            ),
                            CustomText(
                              text: controller.khatmaChatModel[index].timeSend,
                              color: Colors.grey.shade300,
                              alignment: Alignment.bottomRight,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _drawSendMessage(BuildContext context) {
    return GetBuilder<KhatmaChatViewModel>(
      init: KhatmaChatViewModel(),
      builder: (controller) => Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: EdgeInsets.only(left: 10, bottom: 10, top: 15),
          height: 70,
          width: double.infinity,
          color: Colors.grey.shade300,
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: TextFormField(
                            maxLines: null,
                            expands: true,
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
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: FloatingActionButton(
                          onPressed: () {
                            _keyForm.currentState.save();
                            if (messageText.text != "") {
                              controller.createNewMessageToKhatma(
                                  context,
                                  widget.khatmaId,
                                  widget.khatmaName,
                                  messageText.text);
                              messageText.clear();
                              Timer(
                                Duration(milliseconds: 300),
                                () => _controller.jumpTo(
                                    _controller.position.maxScrollExtent),
                              );
                            }
                            // controller.getCurrentUserData();
                            print(controller.getCurrentUserData());
                          },
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18,
                          ),
                          backgroundColor: Colors.blue,
                          elevation: 0,
                        ),
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
