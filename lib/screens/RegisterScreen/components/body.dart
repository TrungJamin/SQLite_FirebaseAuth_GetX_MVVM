import 'package:first_project_login_and_register/components/already_have_an_account_check.dart';
import 'package:first_project_login_and_register/components/or_divider.dart';
import 'package:first_project_login_and_register/components/rounded_button.dart';
import 'package:first_project_login_and_register/components/rounded_input_field.dart';
import 'package:first_project_login_and_register/components/rounded_password_field.dart';
import 'package:first_project_login_and_register/screens/HomeScreen/home_screen.dart';
import 'package:first_project_login_and_register/screens/LoginPage/components/body.dart';
import 'package:first_project_login_and_register/screens/LoginPage/login_screen.dart';
import 'package:first_project_login_and_register/services/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'background.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGN UP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.3,
            ),
            RoundedInputField(
              hintText: "Your Email",
              controller: emailController,
              onChanged: (value) {},
            ),
            RoundedPassWordField(
              onChanged: (value) {},
              controller: passwordController,
            ),
            RoundedButton(
                text: "SIGN UP",
                press: () async {
                  dynamic result =
                      await context.read<AuthenticationService>().signUp(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                  if (result == "Signed up") {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text("Invalid email"),
                            actions: [
                              new ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ok"))
                            ],
                          );
                        });
                  }
                }),
            SizedBox(
              height: size.height * 0.02,
            ),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final String iconSrc;
  final Function press;
  const SocialIcon({
    Key key,
    this.iconSrc,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: Color(0xFFF1E6FF)),
          shape: BoxShape.circle),
      child: GestureDetector(
        onTap: press,
        child: SvgPicture.asset(
          iconSrc,
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}
