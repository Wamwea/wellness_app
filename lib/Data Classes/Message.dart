import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Message {
  Message(
      {@required this.sender,
      @required this.receiver,
      @required this.content,
      @required this.timeStamp});
  String sender;
  String receiver;
  String content;
  DateTime timeStamp;
}
