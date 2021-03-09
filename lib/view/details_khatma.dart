import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatma/constance/constance.dart';
import 'package:khatma/core/viewmodel/details_view_model.dart';
import 'package:khatma/core/viewmodel/khatma_chat_view_model.dart';
import 'package:khatma/model/khatma_model.dart';
import 'package:khatma/view/control_view.dart';
import 'package:khatma/view/khatma_chat_view.dart';
import 'package:khatma/view/message_view.dart';
import 'package:khatma/view/not_reading_view.dart';
import 'package:khatma/view/quran_view.dart';
import 'package:khatma/view/widget/custom_text.dart';
import 'widget/custom_text_form_field.dart';

class DetailsView extends StatelessWidget {
  KhatmaModel model;
  FirebaseAuth _auth = FirebaseAuth.instance;

  DetailsView({this.model});

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  KhatmaChatViewModel khatmaChatViewModel = Get.find();

  // var messageViewModel = Get.put(MessageViewModel());

  // MessageViewModel messageViewModel = MessageViewModel();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailsViewModewl>(
      init: DetailsViewModewl(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text("Details Khatma"),
          centerTitle: true,
          backgroundColor: primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Get.off(ControlView());
              // print(messageViewModel.messageModel.length);
            },
          ),
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          CustomText(
                            text: 'Khatma',
                            fontSize: 23,
                            color: Colors.grey.shade500,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CustomText(
                            text: (controller.isUpdate)
                                ? controller.khatmaName
                                : model.khatmaName,
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    (model.ownerEmail == _auth.currentUser.email)
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              // messageViewModel.receiverId.value = model.ownerId;
                              // messageViewModel.receiverName.value =
                              model.ownerName;
                              Get.to(MessageView(
                                receiverId: model.ownerId,
                                receiverName: model.ownerName,
                              ));
                              // print( messageViewModel.receiverId );
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Admin",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Icon(
                                    Icons.chat_rounded,
                                    color: primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                (model.subject == null)
                    ? Container()
                    : Column(
                        children: [
                          CustomText(
                            text: "Subject",
                            fontSize: 18,
                            alignment: Alignment.topLeft,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 7),
                            alignment: Alignment.topLeft,
                            child: Text(
                              (controller.isUpdate)
                                  ? controller.subject
                                  : model.subject,
                              style: TextStyle(letterSpacing: .4, height: 1.8),
                            ),
                          )
                        ],
                      ),
                SizedBox(height: 20),
                (model.about == null)
                    ? Container()
                    : Column(
                        children: [
                          CustomText(
                            text: "About",
                            fontSize: 18,
                            alignment: Alignment.topLeft,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 7),
                            alignment: Alignment.topLeft,
                            child: Text(
                              (controller.isUpdate)
                                  ? controller.about
                                  : model.about,
                              style: TextStyle(letterSpacing: .4, height: 1.8),
                            ),
                          )
                        ],
                      ),
                SizedBox(height: 20),
                (model.ownerEmail == _auth.currentUser.email)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Edit Khatma",
                            fontSize: 17,
                            color: Colors.blue,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                _showDialogEdit(context, model.khatmaId);
                              }),
                        ],
                      )
                    : Container(),
                (model.ownerEmail == _auth.currentUser.email)
                    ? SizedBox(
                        height: 10,
                      )
                    : Container(),
                (model.ownerEmail == _auth.currentUser.email)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Leave Khatma",
                            fontSize: 17,
                            color: Colors.red,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.exit_to_app,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                controller.leaveKhatma(model.khatmaId);
                                Get.offAll(ControlView());
                              }),
                        ],
                      )
                    : Container(),
                (model.ownerEmail == _auth.currentUser.email)
                    ? SizedBox(
                        height: 10,
                      )
                    : Container(),
                (model.ownerEmail == _auth.currentUser.email)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Delete Khatma",
                            fontSize: 17,
                            color: Colors.red,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.remove_circle_outline_outlined,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                controller.deleteKhatma(model.khatmaId);
                                Get.offAll(ControlView());
                              }),
                        ],
                      )
                    : Container(),
                GestureDetector(
                  onTap: (){
                    Get.to(QuranView(model: model,));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                   decoration: BoxDecoration(
                     color: primaryColor,
                     borderRadius: BorderRadius.circular(10)
                   ),
                    child: CustomText(
                      text: 'View Status',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    Get.to(NotReadingView(model: model,));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: CustomText(
                      text: 'Not Reading',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Badge(
                          badgeContent: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CustomText(
                              text: '${model.members.length - 1}',
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        CustomText(
                          text: "Members",
                          color: primaryColor,
                          fontSize: 17,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: 'Chat Khatma',
                          fontSize: 17,
                          color: Colors.grey.shade500,
                        ),
                        IconButton(
                            icon: Icon(Icons.chat_bubble),
                            color: primaryColor,
                            onPressed: () {
                              Get.to(KhatmaChatView(
                                khatmaId: model.khatmaId,
                                khatmaName: model.khatmaName,
                              ));
                            }),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                _drawListMembers(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _drawListMembers(BuildContext context) {
    return GetBuilder<DetailsViewModewl>(
      init: Get.find(),
      builder: (controller) => ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: model.members.length,
          itemBuilder: (context, int index) {
            return (model.members[index]["memberEmail"] == model.ownerEmail)
                ? Container()
                : Container(
                    child: Card(
                      elevation: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/person.jpg'))),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: model.members[index]['memberName'],
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    (model.ownerEmail ==
                                            _auth.currentUser.email)
                                        ? GestureDetector(
                                            onTap: () {
                                              Get.to(MessageView(
                                                receiverId: model.members[index]
                                                    ['memberId'],
                                                receiverName:
                                                    model.members[index]
                                                        ['memberName'],
                                              ));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Icon(
                                                Icons
                                                    .mark_chat_unread_sharp,
                                                color: primaryColor,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                                (model.members[index]['memberEmail'] ==
                                        _auth.currentUser.email)
                                    ? Container(
                                        alignment: Alignment.bottomRight,
                                        child: Row(
                                          children: [
                                            Text(
                                              "Leave",
                                              style: TextStyle(
                                                  color: Colors.red.shade500,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            IconButton(
                                                icon: Icon(Icons.exit_to_app),
                                                color: Colors.red.shade500,
                                                onPressed: () {
                                                  controller.MemberLeaveKhatma(
                                                      model.khatmaId,
                                                      model.ownerId,
                                                      model.ownerName,
                                                      model.ownerEmail);
                                                  Get.offAll(ControlView());
                                                }),
                                          ],
                                        ),
                                      )
                                    : (model.ownerEmail ==
                                            _auth.currentUser.email)
                                        ? Container(
                                            alignment: Alignment.bottomRight,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                    icon: Icon(Icons
                                                        .highlight_remove_outlined),
                                                    color: Colors.red.shade500,
                                                    onPressed: () {
                                                      controller
                                                          .MemberLeaveKhatma(
                                                              model.khatmaId,
                                                              model.ownerId,
                                                              model.ownerName,
                                                              model.ownerEmail);
                                                      Get.offAll(ControlView());
                                                    }),
                                              ],
                                            ),
                                          )
                                        : Container(),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          }),
    );
  }

  Future<Widget> _showDialogEdit(BuildContext context, String khatmaId) {
    return showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return GetBuilder<DetailsViewModewl>(
            init: Get.find(),
            builder: (controller) => AlertDialog(
              title: Text('Edit Your Khatma'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            initialValue: model.khatmaName,
                            onSave: (value) {
                              controller.khatmaName = value;
                            },
                            validator: (value) {},
                            text: "Khatma Name",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                            initialValue: model.subject,
                            onSave: (value) {
                              controller.subject = value;
                            },
                            validator: (value) {},
                            text: "Subject",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                            initialValue: model.about,
                            onSave: (value) {
                              controller.about = value;
                            },
                            validator: (value) {},
                            text: "Subject",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Edit'),
                  onPressed: () {
                    _formKey.currentState.save();
                    if (_formKey.currentState.validate()) {
                      controller.updateKhatma(model.khatmaId);
                    }
                  },
                ),
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
