import 'package:first_project_login_and_register/components/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  const RoundedInputField({
    Key key,
    this.icon = Icons.person,
    this.hintText,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: hintText,
            icon: Icon(
              icon,
              color: Colors.deepPurple,
            ),
            border: InputBorder.none),
      ),
    );
  }
}
