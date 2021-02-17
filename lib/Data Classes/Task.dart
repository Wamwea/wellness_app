import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Task extends ChangeNotifier {
  Task({this.taskTitle, this.isDone, this.taskText, this.time});
  String taskTitle;
  String taskText;
  bool isDone;
  Timestamp time;
}
