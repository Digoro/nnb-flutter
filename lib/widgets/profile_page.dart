import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:nnb_flutter/pages/home_page.dart';
import 'package:nnb_flutter/pages/login_page.dart';
import 'package:nnb_flutter/pages/product_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import 'divider.dart';
import '../pages/my_product_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;

  @override
  void initState() {
    super.initState();
    getUser().then((res) {
      setState(() {
        user = res;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('마이페이지', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
      body: Column(
        children: [
          getBox([
            if (user != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(user?.profilePhoto ?? '', width: 90, height: 90, fit: BoxFit.cover),
                  ),
                  SizedBox(width: 20),
                  Text(user?.nickname ?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  NDivider(),
                ],
              )
          ]),
          if (user == null)
            ListTile(
                leading: Text('로그인 / 회원가입', style: TextStyle(fontSize: 16)),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
                }),
          if (user != null)
            ListTile(
                leading: Text('참여한 모임', style: TextStyle(fontSize: 16)),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => MyProductPage()));
                }),
          ListTile(
            leading: Text('비즈니스 센터', style: TextStyle(fontSize: 16)),
            trailing: Icon(Icons.open_in_new),
            onTap: () {
              launchUrl(
                Uri.parse('https://nonunbub.com/host'),
                mode: LaunchMode.externalApplication,
              );
            },
          ),
          ListTile(
            leading: Text('카카오톡 고객센터', style: TextStyle(fontSize: 16)),
            trailing: Icon(Icons.open_in_new),
            onTap: () {
              launchUrl(
                Uri.parse('https://pf.kakao.com/_lyeixb/chat'),
                mode: LaunchMode.externalApplication,
              );
            },
          ),
          if (user != null)
            ListTile(
              leading: Text('로그아웃', style: TextStyle(fontSize: 16, color: Colors.grey)),
              onTap: () async {
                logout();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('로그아웃 되었습니다.')));
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));

                try {
                  await kakao.UserApi.instance.logout();
                  print('카카오 로그아웃 성공');
                } catch (error) {
                  print('카카오 로그아웃 실패 $error');
                }

                try {
                  FlutterNaverLogin.logOut();
                  print('네이버 로그아웃 성공');
                } catch (error) {
                  print('네이버 로그아웃 실패 $error');
                }
              },
            )
        ],
      ),
    );
  }
}
