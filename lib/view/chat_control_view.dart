import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:khatma/constance/constance.dart';
import 'package:khatma/view/my_chat_view.dart';
import 'package:khatma/view/public_chat_list_view.dart';


class ChatControlView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Chat'),
          centerTitle: false,
          backgroundColor: primaryColor,
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'private chat',
                icon: Badge(
                    badgeContent: Text('4'),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.person),
                    )),
              ),
              Tab(
                text: 'Khatma chat',
                icon: Badge(
                    badgeContent: Text('2'),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.group),
                    )),
              )
            ],
          ),
        ),
        body: TabBarView(
         children: [
           MyChatView(),
           PublicChatListView(),
         ],
        ),
      ),
    );
  }
}
