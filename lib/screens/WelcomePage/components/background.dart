import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            child: Image.asset(
              "assets/images/main_top.png",
              width: size.width * 0.35,
            ),
            top: 0,
            left: 0,
          ),
          Positioned(
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: size.width * 0.15,
            ),
            bottom: 0,
            left: 0,
          ),
          child
        ],
      ),
    );
  }
}
