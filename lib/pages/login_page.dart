import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
      body: Column(
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
      bottomNavigationBar: SizedBox(
        height: 85,
        child: Column(
          children: [
            SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: Container(
                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: OutlinedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network("https://nonunbub.com/assets/sns-logo/kakaotalk-logo.png", width: 26, height: 26),
                      SizedBox(width: 5),
                      Text(
                        '카카오톡으로 시작하기',
                        style: TextStyle(color: Color.fromRGBO(62, 64, 66, 1)),
                      ),
                    ],
                  ),
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    backgroundColor: Color.fromRGBO(251, 226, 0, 1),
                  ),
                  onPressed: () {
                    // login('kakao');
                  },
                ),
              ),
            ),
            SizedBox(height: 3),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              RichText(
                text: TextSpan(
                  text: '다른 방법으로 시작하기 ',
                  style: TextStyle(fontSize: 13, color: Colors.black),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print("다른 방법으로 시작하기 클릭");
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
