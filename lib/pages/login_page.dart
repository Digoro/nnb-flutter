import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:nnb_flutter/pages/home_page.dart';
import 'package:nnb_flutter/pages/login_other_page.dart';
import 'package:nnb_flutter/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network("https://nonunbub.com/assets/home/event04.png"),
            SizedBox(height: 40),
            Text('카카오톡으로 1초만에 가입하고', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromRGBO(142, 70, 236, 1),
                      ),
                      padding: EdgeInsets.all(5.0),
                      child: Text("2만원 쿠폰팩", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                  TextSpan(
                    text: ' 받으세요!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Column(
          children: [
            SizedBox(height: 10),
            outlinedButton(
              context,
              '카카오톡으로 시작하기',
              Color.fromRGBO(62, 64, 66, 1),
              Color.fromRGBO(251, 226, 0, 1),
              "https://nonunbub.com/assets/sns-logo/kakaotalk-logo.png",
              () async {
                try {
                  await UserApi.instance.loginWithKakaoAccount();
                  User kakaoUser = await UserApi.instance.me();
                  loginWithOath('kakao', kakaoUser).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('환영합니다.')));
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
                  });
                } catch (error) {
                  print('카카오톡으로 로그인 실패 $error');
                }
              },
            ),
            SizedBox(height: 3),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              RichText(
                text: TextSpan(
                  text: '다른 방법으로 시작하기 ',
                  style: TextStyle(fontSize: 13, color: Colors.black),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginOtherPage()));
                    },
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}
