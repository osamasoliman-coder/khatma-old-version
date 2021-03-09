import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:khatma/constance/constance.dart';
import 'package:khatma/core/viewmodel/home_view_model.dart';
import 'package:khatma/core/viewmodel/khatma_view_model.dart';
import 'package:khatma/model/khatma_model.dart';
import 'package:khatma/view/control_view.dart';
import 'package:khatma/view/home_view.dart';
import 'package:khatma/view/widget/custom_text.dart';

class CreateKhatmaView extends GetWidget {
  final homeViewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Khatma",
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Get.off(ControlView());
          },
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: GetBuilder<KhatmaViewModel>(
        init: KhatmaViewModel(),
        builder: (controller) => SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  margin: EdgeInsets.only(top: 30, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Name Of Khatma"),
                    onChanged: (value) {
                      controller.name = value;
                      //print(controller.name);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Type",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    DropdownButton<String>(
                      value: controller.dropdownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (String data) {
                        controller.typeChange(data);
                      },
                      items: controller.typeItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              (controller.dropdownValue == 'Private')
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 20),
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: "Password Of Khatma"),
                          onChanged: (value) {
                            controller.password = value;
                          },
                        ),
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  margin: EdgeInsets.only(top: 30, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextField(
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(50),
                    ],
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "subject    =>     this field is optional"),
                    onChanged: (value) {
                      controller.subject = value;
                      //print(controller.name);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  margin: EdgeInsets.only(top: 30, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextField(
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(300),
                    ],
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "about       =>  this field is optional"),
                    onChanged: (value) {
                      controller.about = value;
                      //print(controller.name);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Notification",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    DropdownButton<String>(
                      value: controller.notificationValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (String data) {
                        controller.notificationChange(data);
                      },
                      items: controller.notificationItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Renewal",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    DropdownButton<String>(
                      value: controller.renewValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (String data) {
                        controller.renewalChange(data);
                      },
                      items: controller.renewItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Period",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    DropdownButton<String>(
                      value: controller.daysValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (String data) {
                        controller.daysChange(data);
                        print(controller.daysValue);
                      },
                      items: controller.daysItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: Get.width * .1,
                  child: RaisedButton(
                    onPressed: () async {
                      // controller.createNewKhatma();
                      // ignore: unrelated_type_equality_checks
                      await controller.checkIfNakeAlreadyExists();
                      if (controller.checkKhatmaName == true) {
                        Get.defaultDialog(
                          title: 'Khatma Name',
                          content: CustomText(
                            text: 'Sorry This Name is Already Exists',
                          ),
                          confirm:
                              FlatButton(onPressed: () {
                                Get.back();
                              }, child: Text('ok')),
                        );
                      } else {
                        print('not found');
                         controller.createNewKhatma();
                         Get.offAll(ControlView());
                      }
                    },
                    child: Text(
                      "Create",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: primaryColor,
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
