import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Function press;

  const RoundedButton({
    Key key,
    this.text,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.deepPurple,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      margin: EdgeInsets.symmetric(vertical: 10),
//      color: backgroundColor,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            primary: backgroundColor,
          ),
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
          onPressed: press,
        ),
      ),
    );
  }
}
