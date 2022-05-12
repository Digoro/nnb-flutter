import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:nnb_flutter/config.dart';
import 'package:nnb_flutter/pages/feed_page.dart';
import 'package:nnb_flutter/pages/home_page.dart';
import 'package:nnb_flutter/services/auth_interceptor.dart';
import 'package:nnb_flutter/widgets/profile_page.dart';
import 'package:intl/date_symbol_data_local.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..maxConnectionsPerHost = 100;
  }
}

void main() async {
  KakaoSdk.init(nativeAppKey: Config.kakaoNativekey);
  WidgetsFlutterBinding.ensureInitialized();
  await setInterceptor();
  HttpOverrides.global = MyHttpOverrides();
  initializeDateFormatting().then((_) => runApp(Main()));
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '노는법 ',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomePage(),
                FeedPage(),
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
                    text: "모임",
                    icon: Icon(Icons.space_dashboard),
                  ),
                  Tab(
                    text: "커뮤니티",
                    icon: Icon(Icons.feed_rounded),
                  ),
                  Tab(
                    text: "마이페이지",
                    icon: Icon(Icons.person),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
