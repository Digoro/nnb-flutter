import 'package:flutter/material.dart';
import 'package:nnb_flutter/pages/product_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../widgets/divider.dart';
import 'my_product_page.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (user?.profilePhoto != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(user?.profilePhoto ?? '', width: 90, height: 90, fit: BoxFit.cover),
                      ),
                    SizedBox(width: 20),
                    Text(user?.nickname ?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  ],
                ),
              ],
            )
          ]),
          NDivider(),
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
          ListTile(
            leading: Text('로그아웃', style: TextStyle(fontSize: 16, color: Colors.grey)),
            onTap: () {
              logout();
            },
          )
        ],
      ),
    );
  }
}
