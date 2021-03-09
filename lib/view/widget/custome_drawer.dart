import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatma/constance/constance.dart';
import 'package:khatma/view/auth/login_screen.dart';
import 'package:khatma/view/chat_control_view.dart';
import 'package:khatma/view/create_khatma_view.dart';
import 'package:khatma/view/history_view.dart';
import 'package:khatma/view/my_chat_view.dart';

Widget customDrawer(BuildContext context) {
  FirebaseAuth auth = FirebaseAuth.instance;
  return Drawer(
    child: Container(
      color: primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * .20,
          ),
          ListTile(
            title: Text('Create Khatma',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
            contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
            leading: Icon(
              Icons.create,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
              Get.to(CreateKhatmaView());
            },
          ),
          ListTile(
            title: Text('Language',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
            contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
            leading: Icon(
              Icons.language,
              color: Colors.white,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('My Chat',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
            contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
            leading: Icon(
              Icons.chat,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
              Get.to(ChatControlView());
            },
          ),
          ListTile(
            title: Text('History',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
            contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
            leading: Icon(
              Icons.history,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
              Get.to(HistoryView());
            },
          ),
          ListTile(
            title: Text('Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
            contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
            leading: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onTap: () {
              auth.signOut();
              Get.offAll(LoginScreen());
            },
          ),
          SizedBox(
            height: 30,
          ),
          ListTile(
            title: Text('About Us',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
            contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
            leading: Icon(
              Icons.account_box_outlined,
              color: Colors.white,
            ),
            onTap: () {
              auth.signOut();
              Get.offAll(LoginScreen());
            },
          ),
          ListTile(
            title: Text('Contact Us',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
            contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
            leading: Icon(
              Icons.contact_mail,
              color: Colors.white,
            ),
            onTap: () {
              auth.signOut();
              Get.offAll(LoginScreen());
            },
          ),
        ],
      ),
    ),
  );
}
