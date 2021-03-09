import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatma/Animations/FadeAnimation.dart';
import 'package:khatma/constance/constance.dart';
import 'package:khatma/core/viewmodel/search_view_model.dart';
import 'package:khatma/view/widget/custom_text_form_field.dart';
import 'package:khatma/view/widget/custome_drawer.dart';

import 'widget/custom_text.dart';

class SearchView extends StatelessWidget {
  //bool added = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchViewModel>(
      init: SearchViewModel(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Container(
            height: 40,
            padding: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: TextFormField(
              onSaved: (value) {
                controller.search = value;
              },
              validator: (value) {},
              onChanged: (value) {
                controller.search = value;
                if (controller.search == "") {
                  controller.onSearchEmptyValue();
                }
                // print(controller.search);
              },
              decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "Search Khatma",
                hintStyle: TextStyle(
                  color: Colors.grey.shade600,
                ),
                fillColor: Colors.white,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                  onTap: () {
                    // controller.getAllKhatma();
                    controller.searchKhatmaMethod(controller.search);
                  },
                  child: Icon(
                    Icons.search,
                    size: 25,
                  )),
            ),
          ],
        ),
        drawer: customDrawer(context),
        body: FadeAnimation(
          1.5,
            (!controller.isLoading) ? Center(child: CircularProgressIndicator(),) :
          ListView.builder(
              itemCount: controller.khatmaModel.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  shadowColor: Colors.orange.shade500,
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
                                    backgroundColor: primaryColor,
                                    radius: 30,
                                    child: Text(
                                      controller.khatmaModel[index].khatmaName
                                          .substring(0, 1)
                                          .toLowerCase(),
                                      style: TextStyle(
                                          fontSize: 35, color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    CustomText(
                                      text: controller
                                          .khatmaModel[index].khatmaName
                                          .toString(),
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomText(
                                      text: controller.khatmaModel[index].type,
                                      fontSize: 16,
                                      color: Colors.grey.shade600,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                CustomText(
                                  text:
                                      "${controller.khatmaModel[index].members.length} /60",
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (controller.khatmaModel[index].type ==
                                        "Public") {
                                      return controller
                                          .addNewMemberToPublicKhatma(
                                              int.parse(controller
                                                  .khatmaModel[index].khatmaId),
                                              index);
                                    } else if (controller
                                            .khatmaModel[index].type ==
                                        "Private") {
                                      return _showDialog(
                                          context,
                                          index,
                                          int.parse(controller
                                              .khatmaModel[index].khatmaId));
                                    }
                                  },
                                  child: (controller.test(index) == true)
                                      ? Container()
                                      : Icon(
                                          Icons.add,
                                          color: Colors.green,
                                        ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  Future<Widget> _showDialog(BuildContext context, int index, int khatmaId) {
    return showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return GetBuilder<SearchViewModel>(
            init: SearchViewModel(),
            builder: (controller) => AlertDialog(
              title: Text('Enter The PAssword To Join'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: CustomTextFormField(
                        onSave: (value) {
                          controller.password = value;
                        },
                        validator: (value) {},
                        text: "Password",
                        hint: "Enter Password ",
                      ),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Approve'),
                  onPressed: () {
                    _formKey.currentState.save();
                    if (_formKey.currentState.validate()) {
                      controller.addNewMemberTpPrivateKhatma(khatmaId, index);
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
