import 'package:flutter/material.dart';

class BuildDivider extends StatelessWidget {
  const BuildDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Divider(
        color: Colors.deepPurple,
        height: 1.5,
        thickness: 1,
      ),
    );
  }
}
