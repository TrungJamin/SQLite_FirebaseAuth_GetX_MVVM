import 'package:first_project_login_and_register/components/rounded_button.dart';
import 'package:first_project_login_and_register/components/rounded_input_field.dart';
import 'package:first_project_login_and_register/components/rounded_password_field.dart';
import 'package:first_project_login_and_register/utils/database.dart';
import 'file:///D:/Dev/Flutter/first_project_login_and_register/lib/models/user_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    usernameController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RoundedInputField(
            icon: Icons.person,
            hintText: 'User name',
            onChanged: (value) {},
            controller: usernameController,
          ),
          RoundedPassWordField(
            controller: passwordController,
          ),
          RoundedButton(
            text: "Create User",
            press: () {
              if (usernameController.text.isEmpty ||
                  passwordController.text.isEmpty) {
                showAlertDialog(context, "Invalid username or password");
              } else {
                Random random = new Random();
                int randomNumber = random.nextInt(100);
                var newUser = User(
                    id: randomNumber,
                    username: usernameController.text,
                    password: passwordController.text);
                // Insert user into the table
                DBProvider.db.newUser(newUser);
                showAlertDialog(context, "Created Successfully");
                FocusScope.of(context).unfocus();
              }
            },
          )
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context, String res) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Status"),
    content: Text(res),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
