import 'package:cloud_firestore/cloud_firestore.dart';

class ThoughtPost {
  ThoughtPost({this.username, this.title, this.content, this.email, this.time});
  String username;
  String title;
  String content;
  String email;
  Timestamp time;
}
