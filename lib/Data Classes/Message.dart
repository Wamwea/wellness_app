import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String sender;
  String receiver;
  String content;
  Timestamp timeStamp;
}
