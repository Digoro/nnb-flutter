import 'package:flutter/material.dart';

class NDivider extends StatelessWidget {
  NDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 5,
      color: Color.fromARGB(255, 230, 230, 230),
    );
  }
}
