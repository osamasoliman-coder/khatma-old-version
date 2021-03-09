import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khatma/Animations/FadeAnimation.dart';
import 'package:khatma/constance/constance.dart';
import 'package:khatma/core/viewmodel/home_view_model.dart';
import 'package:khatma/core/viewmodel/khatma_chat_view_model.dart';
import 'package:khatma/view/details_khatma.dart';
import 'package:khatma/view/widget/custom_text.dart';
import 'package:khatma/view/widget/custome_drawer.dart';

class HomeView extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;

  KhatmaChatViewModel khatmaChatViewModel = Get.put(KhatmaChatViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('My Khatma'),
        centerTitle: true,
      ),
      drawer: customDrawer(context),
      body: FadeAnimation(
        1.5,
        GetBuilder<HomeViewModel>(
          init: HomeViewModel(),
          builder: (controller) => (controller.myKhatma.length == 0)
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/nodata.svg',
                      width: 200,
                      height: 200,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomText(
                      text: 'No Data',
                      fontSize: 25,
                      color: Colors.grey.shade500,
                    )
                  ],
                ))
              : ListView.builder(
                  itemCount: controller.myKhatma.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 10,
                      shadowColor: Colors.orange.shade500,
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.myKhatma[index].khatmaName,
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                (controller.myKhatma[index].ownerEmail ==
                                        _auth.currentUser.email)
                                    ? CustomText(
                                        text: "Admin",
                                        color: primaryColor,
                                        fontSize: 17,
                                      )
                                    : Container(),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Badge(
                                  badgeColor: primaryColor,
                                  badgeContent: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: CustomText(
                                      text:
                                          '${(controller.myKhatma[index].members.length - 1).toString()}',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: CustomText(
                                    text:
                                        'Members      ',
                                    color: primaryColor,
                                    fontSize: 17,
                                  ),
                                ),
                                Container(
                                  child: GestureDetector(
                                    onTap: () {
                                      khatmaChatViewModel.khatmaId.value =
                                          controller.myKhatma[index].khatmaId;
                                      Get.to(DetailsView(
                                        model: controller.myKhatma[index],
                                      ));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: CustomText(
                                        text: "View Details",
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
