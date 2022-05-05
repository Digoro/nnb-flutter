import 'package:flutter/material.dart';

class NCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  NCard({Key? key, required this.child, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(7)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            spreadRadius: 0,
            blurRadius: 7,
            offset: Offset(2, 3), // changes position of shadow
          )
        ],
        color: Colors.white,
      ),
      padding: padding ?? EdgeInsets.all(20),
      child: child,
    );
  }
}
