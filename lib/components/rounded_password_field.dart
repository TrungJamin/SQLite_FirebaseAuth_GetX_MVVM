import 'package:first_project_login_and_register/components/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedPassWordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  const RoundedPassWordField({
    Key key,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        obscureText: true,
        decoration: InputDecoration(
            hintText: "Password",
            suffixIcon: Icon(Icons.visibility),
            icon: Icon(
              Icons.lock,
              color: Colors.deepPurple,
            ),
            border: InputBorder.none),
      ),
    );
  }
}
