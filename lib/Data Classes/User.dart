import 'package:flutter/material.dart';
import 'package:wellness_app/Data Classes/Task.dart';

class MyUser extends ChangeNotifier {
  MyUser(this.username, this.email, this.password);
  String username;
  String email;
  String password;

  List<Task> userTasks;
}
