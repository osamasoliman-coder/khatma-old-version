import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:khatma/core/viewmodel/my_message_view_model.dart';

import 'message_view.dart';
import 'widget/custom_text.dart';

class MyChatView extends StatefulWidget {
  @override
  _MyChatViewState createState() => _MyChatViewState();
}

class _MyChatViewState extends State<MyChatView> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyMessageViewModel>(
      init: MyMessageViewModel(),
      builder: (controller) => (controller.myChatList.length == 0)
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/nochat.svg',
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                  height: 15,
                ),
                CustomText(
                  text: 'Begin Chat',
                  fontSize: 25,
                  color: Colors.grey.shade500,
                )
              ],
            ))
          : ListView.builder(
              itemCount: controller.myChatList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (_auth.currentUser.uid !=
                        controller.myChatList[index].receiverId) {
                      //print("hi");
                      Get.off(MessageView(
                          receiverId: controller.myChatList[index].receiverId,
                          receiverName:
                              controller.myChatList[index].receiverName));
                    }
                    if (_auth.currentUser.uid !=
                        controller.myChatList[index].senderId) {
                      Get.to(MessageView(
                        receiverId: controller.myChatList[index].senderId,
                        receiverName: controller.myChatList[index].senderName,
                      ));
                    }
                    //Get.to(MessageView())
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: CircleAvatar(
                                      backgroundColor:
                                          Colors.deepOrange.shade400,
                                      radius: 30,
                                      child: Text(
                                        'o'.toLowerCase(),
                                        style: TextStyle(
                                            fontSize: 35, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: (controller.myChatList[index]
                                                    .receiverId ==
                                                _auth.currentUser.uid)
                                            ? controller
                                                .myChatList[index].senderName
                                            : controller
                                                .myChatList[index].receiverName,
                                        fontSize: 19,
                                        color: Colors.deepOrange.shade500,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      CustomText(
                                        text: "tab to see the Chat",
                                        fontSize: 16,
                                        color: Colors.grey.shade500,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  // Container(
                                  //   width: 20,
                                  //   height: 20,
                                  //   decoration: BoxDecoration(
                                  //       color: Colors.red,
                                  //       borderRadius: BorderRadius.circular(50)
                                  //   ),
                                  //   child: CustomText(
                                  //     text: "3",
                                  //     alignment: Alignment.center,
                                  //     color: Colors.white,
                                  //     fontSize: 16,
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.test();
                                    },
                                    child: CustomText(
                                      text: "test",
                                      fontSize: 16,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
