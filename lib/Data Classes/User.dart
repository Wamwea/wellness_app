import 'package:flutter/material.dart';

class MyUser extends ChangeNotifier {
  MyUser(this.username, this.email, this.password);
  String username;
  String email;
  String password;
}
