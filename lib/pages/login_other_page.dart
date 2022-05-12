import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:nnb_flutter/pages/home_page.dart';
import 'package:nnb_flutter/services/auth_service.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginOtherPage extends StatefulWidget {
  LoginOtherPage({Key? key}) : super(key: key);

  @override
  State<LoginOtherPage> createState() => _LoginOtherPageState();
}

class _LoginOtherPageState extends State<LoginOtherPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String email = '';
    String password = '';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => {
            Navigator.pop(context),
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            outlinedButton(
              context,
              '네이버로 시작하기',
              Colors.white,
              Color.fromRGBO(70, 188, 37, 1),
              "https://nonunbub.com/assets/sns-logo/naver-logo.png",
              () async {
                try {
                  final NaverLoginResult result = await FlutterNaverLogin.logIn();
                  loginWithOath('naver', result.account).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('환영합니다.')));
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
                  });
                } catch (error) {
                  print('네이버로 로그인 실패 $error');
                }
              },
            ),
            SizedBox(height: 7),
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
            SizedBox(height: 7),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '이용약관',
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(
                          Uri.parse('https://www.notion.so/43b16b117aa840d397a71350a8d08412'),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                  ),
                  TextSpan(text: ', '),
                  TextSpan(
                    text: '개인정보 수집 및 이용',
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(
                          Uri.parse('https://www.notion.so/gdgdaejeon/5ad28ab509bb461090e2bca00af5ac59'),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                  ),
                ],
              ),
            ),
            Text('을 확인하였고 동의합니다.'),
            SizedBox(height: 20),
            Text('또는'),
            SizedBox(height: 20),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    textFormField(email, '이메일', '이메일 주소를 입력해주세요.', (value) {
                      setState(() {
                        email = value as String;
                      });
                    }, (value) {
                      if (value == null || value.isEmpty) return '이메일을 입력해주세요.';
                      return null;
                    }),
                    SizedBox(height: 10),
                    textFormField(password, '비밀번호', '비밀번호를 입력해주세요.', (value) {
                      setState(() {
                        password = value as String;
                      });
                    }, (value) {
                      if (value == null || value.isEmpty) return '비밀번호를 입력해주세요.';
                      return null;
                    }, obscureText: true),
                    SizedBox(height: 3),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                login(email, password).then((value) {
                                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('환영합니다.')));
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
                                }, onError: (error) {
                                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('로그인이 실패하였습니다.'),
                                    ),
                                  );
                                });
                              } else {
                                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('입력한 값이 올바르지 않습니다.'),
                                  ),
                                );
                              }
                            },
                            child: const Text('노는법 로그인'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Text('비밀번호 찾기'),
                          onTap: () {},
                        ),
                        SizedBox(width: 12),
                        Text('|'),
                        SizedBox(width: 12),
                        Text('회원가입'),
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  TextFormField textFormField(String email, String labelText, String hintText, onSaved, validator,
      {keyboardType = TextInputType.text, obscureText = false, autovalidateMode = AutovalidateMode.onUserInteraction}) {
    return TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        keyboardType: keyboardType,
        autovalidateMode: autovalidateMode,
        onSaved: onSaved,
        validator: validator,
        obscureText: obscureText);
  }
}

Widget outlinedButton(BuildContext context, String label, Color labelColor, Color color, String? icon, onPressed) {
  return SizedBox(
    height: 55,
    child: OutlinedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Image.network(icon, width: 26, height: 26),
          SizedBox(width: 5),
          Text(label, style: TextStyle(color: labelColor)),
        ],
      ),
      style: TextButton.styleFrom(
        textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        backgroundColor: color,
      ),
      onPressed: onPressed,
    ),
  );
}
