import 'package:flutter/material.dart';
import 'package:nnb_flutter/home_page.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '노는법',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: '노는법'),
      debugShowCheckedModeBanner: true,
    );
  }
}
