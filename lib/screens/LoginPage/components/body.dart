import 'package:first_project_login_and_register/components/already_have_an_account_check.dart';
import 'package:first_project_login_and_register/components/rounded_button.dart';
import 'package:first_project_login_and_register/components/rounded_input_field.dart';
import 'package:first_project_login_and_register/components/rounded_password_field.dart';
import 'package:first_project_login_and_register/screens/HomeScreen/home_screen.dart';
import 'package:first_project_login_and_register/screens/RegisterScreen/register_screen.dart';
import 'package:first_project_login_and_register/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'background.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.4,
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
              controller: emailController,
            ),
            RoundedPassWordField(
              onChanged: (value) {},
              controller: passwordController,
            ),
            RoundedButton(
                text: "LOGIN",
                press: () async {
                  dynamic result =
                      await context.read<AuthenticationService>().signIn(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );

                  if (result == "Signed in") {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text("Invalid email or password"),
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

//                  Navigator.pushNamed(context, HomeScreen.routeName);
                  /* Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              ,*/
                }),
            SizedBox(height: size.height * 0.02),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
