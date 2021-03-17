import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:khatma/constance/constance.dart';
import 'package:khatma/core/viewmodel/myprofile_view_model.dart';
import 'package:khatma/view/control_view.dart';
import 'package:khatma/view/widget/custom_text.dart';

class MyProfile extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: GetBuilder<MyProfileViewModel>(
          init: MyProfileViewModel(),
          builder: (controller) => Stack(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Card(
                          elevation: 10,
                          shadowColor: Colors.orange.shade200,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50))),
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/person.jpg'),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: '${controller.currentUsername}',
                              color: primaryColor,
                              fontSize: 20,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              text: '${controller.currentEmail}',
                              fontSize: 17,
                              color: Colors.grey.shade500,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    (controller.myWerd.length == 0)
                        ? Center(
                            child: CustomText(
                            text: 'No New Werd Until Now',
                            fontSize: 25,
                            color: Colors.grey.shade500,
                          ))
                        : ListView.builder(
                            itemCount: controller.myKhatmaWithWerd.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 5,
                                shadowColor: primaryColor,
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            text: 'My Werd',
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                          CustomText(
                                            text:
                                                'from ${controller.myKhatmaWithWerd[index].khatmaName}',
                                            fontSize: 17,
                                            color: Colors.deepOrange,
                                          ),
                                        ],
                                      ),
                                      ListView.builder(
                                          itemCount: controller
                                              .myKhatmaWithWerd[index]
                                              .reserved
                                              .length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, position) {
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: int.parse(controller
                                                  .myKhatmaWithWerd[index]
                                                  .reserved[position]['quran']
                                                  .length
                                                  .toString()),
                                              itemBuilder: (context, quran) =>
                                                  Column(
                                                children: [
                                                  (controller
                                                                      .myKhatmaWithWerd[
                                                                          index]
                                                                      .reserved[
                                                                  position][
                                                              'memberReservedEmail'] ==
                                                          _auth.currentUser
                                                              .email)
                                                      ? Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10),
                                                          child: CustomText(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            text: controller
                                                                        .myKhatmaWithWerd[
                                                                            index]
                                                                        .reserved[
                                                                    position]['quran']
                                                                [
                                                                quran]['quranEn'],
                                                            fontSize: 18,
                                                          ),
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                            );
                                          }),
                                      FlatButton(
                                        onPressed: () {
                                          Get.defaultDialog(
                                            title: 'Read',
                                            content: Center(
                                              child: CustomText(
                                                  text:
                                                      'Are You Really Read This Werd ?!'),
                                            ),
                                            confirm: RaisedButton(
                                              onPressed: () {
                                                controller
                                                    .automationWerd(index);
                                                Get.offAll(ControlView());
                                              },
                                              child: Text('Ok'),
                                            ),
                                            cancel: RaisedButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text('Cancel'),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: CustomText(
                                            text: 'Submit',
                                            fontSize: 18,
                                            color: Colors.green,
                                            alignment: Alignment.bottomRight,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
