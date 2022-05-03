import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('커뮤니티', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
      body: Center(child: Text('')),
    );
  }
}
