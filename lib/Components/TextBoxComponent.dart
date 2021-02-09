import 'package:flutter/material.dart';

class TextBoxComponent extends StatelessWidget {
  TextBoxComponent(
      {this.onChanged, this.hintText, this.icon, this.obscureText = false});
  final String hintText;
  final Function onChanged;
  final Icon icon;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: InputDecoration(
            filled: true,
            prefixIcon: icon,
            fillColor: Colors.white,
            hintText: hintText,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.black))),
      ),
    );
  }
}
