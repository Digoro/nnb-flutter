import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nnb_flutter/pages/chat_page.dart';
import 'package:nnb_flutter/pages/home_page.dart';
import 'package:nnb_flutter/pages/profile_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..maxConnectionsPerHost = 10;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '노는법 ',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomePage(),
                ChatPage(),
                ProfilePage(),
              ],
            ),
            bottomNavigationBar: Container(
              color: Colors.white,
              child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    text: "홈",
                    icon: Icon(Icons.home),
                  ),
                  Tab(
                    text: "대화",
                    icon: Icon(Icons.chat_bubble),
                  ),
                  Tab(
                    text: "프로필",
                    icon: Icon(Icons.person),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
