import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatma/constance/constance.dart';
import 'package:khatma/core/viewmodel/khatma_chat_view_model.dart';
import 'package:khatma/view/khatma_chat_view.dart';
import 'package:khatma/view/widget/custom_text.dart';

class PublicChatListView extends StatefulWidget {
  @override
  _PublicChatListViewState createState() => _PublicChatListViewState();
}

class _PublicChatListViewState extends State<PublicChatListView> {

  KhatmaChatViewModel khatmaChatViewModel = Get.put(KhatmaChatViewModel());

  @override
  void initState() {
    khatmaChatViewModel.publicChatList.clear();
    Future.delayed(Duration.zero, () async {
      khatmaChatViewModel.getKhatmaChatList();
        });
    super.initState();
  }

  @override
  void dispose() {
   khatmaChatViewModel.publicChatList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KhatmaChatViewModel>(
      init: KhatmaChatViewModel(),
      builder: (controller) =>
          ListView.builder(
          itemCount: controller.publicChatList.length,
          itemBuilder: (context,index){
        return GestureDetector(
          onTap: (){
            Get.to(KhatmaChatView(
              khatmaId: controller.publicChatList[index].khatmaId,
              khatmaName: controller.publicChatList[index].khatmaName,
            ));
          },
          child: Card(
            elevation: 30,
            shadowColor: Colors.brown,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     CustomText(
                       text: controller.publicChatList[index].khatmaName,
                       fontSize: 23,
                       color: primaryColor,
                     ),
                     CustomText(
                       text: controller.publicChatList[index].timeSend,
                       fontSize: 19,
                       color: Colors.black,
                     ),
                   ],
                 ),
                  SizedBox(height: 20,),
                  CustomText(
                    text: controller.publicChatList[index].message,
                    fontSize: 18,
                    color: Colors.grey,
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
