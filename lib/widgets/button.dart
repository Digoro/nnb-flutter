import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final String type;
  final VoidCallback onPressed;

  Button({Key? key, required this.label, this.type = 'secondary', required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = type == 'primary'
        ? TextButton.styleFrom(
            primary: Colors.white,
            textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            backgroundColor: Color.fromRGBO(142, 70, 236, 1),
          )
        : TextButton.styleFrom(primary: Colors.black);
    return SizedBox(
      height: 40,
      child: OutlinedButton(
        style: style,
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
