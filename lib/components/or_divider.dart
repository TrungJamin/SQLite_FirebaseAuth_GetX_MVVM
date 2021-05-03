import 'package:flutter/material.dart';

import 'build_divider.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BuildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "OR",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
          ),
          BuildDivider(),
        ],
      ),
    );
  }
}
