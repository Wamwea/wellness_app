import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  ButtonComponent({@required this.label, @required this.onTap});
  Function onTap;
  String label;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(colors: [
                Colors.purple.shade600,
                Colors.deepPurpleAccent.shade700,
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            height: 50,
            width: double.infinity,
            child: Center(
                child: Text(
              label,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ),
    );
  }
}
