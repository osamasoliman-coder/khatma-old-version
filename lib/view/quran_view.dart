import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatma/constance/constance.dart';
import 'package:khatma/core/viewmodel/quran_view_model.dart';
import 'package:khatma/model/khatma_model.dart';
import 'package:khatma/view/control_view.dart';
import 'package:khatma/view/widget/custom_text.dart';

class QuranView extends StatelessWidget {
  KhatmaModel model;

  QuranView({this.model});

  int x = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avilable'),
        centerTitle: false,
        backgroundColor: primaryColor,
        actions: [
          GetBuilder<QuranViewModel>(
            init: QuranViewModel(),
            builder: (controller) => Row(
              children: [
                Container(
                  height: 36,
                  padding: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                      color: Colors.yellowAccent,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: new DropdownButton<String>(
                    hint: CustomText(text:'Size',color: Colors.black,),
                    items: <int>[2, 4].map((int value) {
                      return new DropdownMenuItem<String>(
                        value: int.parse(value.toString()).toString(),
                        child: new Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.incrementValue(int.parse(value));
                      print(controller.changeGridValue);
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                (controller.addToMap.length > 0)
                    ? Container(
                        margin: EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            controller.reserveQoz(model.khatmaId);
                            Get.offAll(ControlView());
                          },
                          child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text('Submit')),
                        ),
                      )
                    : Container()
              ],
            ),
          )
        ],
      ),
      body: GetBuilder<QuranViewModel>(
        init: QuranViewModel(),
        builder: (controller) => GridView.builder(
            itemCount: model.quran.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: controller.changeGridValue.value),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  controller.getValueSelected(index, model.quran[index]);
                  // Get.defaultDialog(
                  //     title: 'Reserve This part?',
                  //     content: Text(
                  //         'Are You Sure You Want To Reserve This Part!!!!'),
                  //     confirm: FlatButton(
                  //         onPressed: () {
                  //           controller.reserveQoz(model.khatmaId, index);
                  //           // Get.offAll(ControlView());
                  //         },
                  //         child: CustomText(
                  //           text: 'Submit',
                  //           color: primaryColor,
                  //         )),
                  //     cancel: FlatButton(
                  //         onPressed: () {
                  //           Get.back();
                  //         },
                  //         child: CustomText(
                  //           text: 'Cancel',
                  //           color: primaryColor,
                  //         )));
                },
                child: Card(
                  shadowColor: Colors.orange,
                  elevation: (controller.changeGridValue.value == 4)? 0 : 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: (controller.changeGridValue.value == 4)
                          ? BorderRadius.only(
                              topLeft: Radius.circular(1),
                              topRight: Radius.circular(1),
                              bottomLeft: Radius.circular(1),
                              bottomRight: Radius.circular(0))
                          : BorderRadius.only(
                              topLeft: Radius.circular(100),
                              topRight: Radius.circular(100),
                              bottomLeft: Radius.circular(100),
                              bottomRight: Radius.circular(100))),
                  child: Container(
                    padding: EdgeInsets.only(left: 10, top: 5, right: 10),
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color:
                            (controller.addToMap.contains(model.quran[index]))
                                ? Colors.deepOrange
                                : gridColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Expanded(
                          child: CustomText(
                            text: model.quran[index]['quranEn'],
                            alignment: Alignment.center,
                            color: Colors.white,
                            fontSize: (controller.changeGridValue.value == 2)
                                ? 30
                                : 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
