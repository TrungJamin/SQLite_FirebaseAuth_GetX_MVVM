import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
//      color: Colors.black,
      width: size.width,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            child: Image.asset(
              "assets/images/signup_top.png",
              width: size.width * 0.3,
            ),
            left: 0,
            top: 0,
          ),
          Positioned(
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: size.width * 0.15,
            ),
            left: 0,
            bottom: 0,
          ),
          child
        ],
      ),
    );
  }
}
