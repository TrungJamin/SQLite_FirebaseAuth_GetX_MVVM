import 'package:first_project_login_and_register/components/rounded_button.dart';
import 'package:first_project_login_and_register/screens/LoginPage/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This will provide us the whole size of our screen
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "WELCOME TO EDU",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        SvgPicture.asset(
          "assets/icons/chat.svg",
          height: size.height * 0.5,
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        RoundedButton(
          text: "LOGIN",
          press: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        ),
        RoundedButton(
          text: "REGISTER",
          backgroundColor: Color(0xFFF1E6FF),
          textColor: Colors.black,
          press: () {},
        )
      ],
    ));
  }
}
