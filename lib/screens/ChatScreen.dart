import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellness_app/Data Classes/Message.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatScreen extends StatefulWidget {
  ChatScreen(this.userEmail, this.userName);
  final String userEmail;
  final String userName;
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> messages = [];
  String myMessage;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    String collectionName = _auth.currentUser.email + "to" + widget.userEmail;
    String inverseCollectionName =
        widget.userEmail + "to" + _auth.currentUser.email;
    return StreamBuilder<QuerySnapshot>(
        stream: _firebaseFirestore
            .collection('Users')
            .doc('${_auth.currentUser.email}')
            .collection('$collectionName')
            .orderBy('time')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageBubble> myMessages = [];
            final documents = snapshot.data.docs.reversed;
            for (var document in documents) {
              Timestamp myTime = document.get('time');
              MessageBubble myMessage = MessageBubble(
                message: document.get('content'),
                time: timeago.format(myTime.toDate()).toString(),
                isUser: document.get('sender') == _auth.currentUser.email
                    ? false
                    : true,
              );
              myMessages.add(myMessage);
            }
            return SafeArea(
              child: Scaffold(
                body: Container(
                  height: maxHeight,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(color: Color(0xff001838)),
                        height: maxHeight * 0.09,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back_sharp,
                                size: 30,
                                color: Colors.lime,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Center(
                                  child: Text(
                                    "${widget.userName}",
                                    style: GoogleFonts.shadowsIntoLight(
                                        textStyle: TextStyle(
                                            fontSize: 20,
                                            color: Colors.lime,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                              padding: EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xff56ab2f),
                                      Color(0xffa8e063)
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft),
                              ),
                              width: double.infinity,
                              child: ListView(
                                reverse: true,
                                children: myMessages,
                              ))),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff001838),
                        ),
                        width: double.infinity,
                        height: maxHeight * 0.07,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 6.0, right: 0, top: 6, bottom: 6),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(35)),
                                child: TextFormField(
                                  onChanged: (value) {
                                    myMessage = value;
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      hintText: "Type your message",
                                      border: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    print(
                                        "Hey there tapped ${documents.length}");
                                    Message newMessage = Message(
                                        sender: _auth.currentUser.email,
                                        receiver: widget.userEmail,
                                        content: myMessage,
                                        timeStamp: Timestamp.now().toDate());
                                    _firebaseFirestore
                                        .collection('Users')
                                        .doc('${_auth.currentUser.email}')
                                        .collection('$collectionName')
                                        .add({
                                      'sender': newMessage.sender,
                                      'receiver': newMessage.receiver,
                                      'content': newMessage.content,
                                      'time': newMessage.timeStamp
                                    });
                                    _firebaseFirestore
                                        .collection('Users')
                                        .doc('${widget.userEmail}')
                                        .collection('$inverseCollectionName')
                                        .add({
                                      'sender': newMessage.sender,
                                      'receiver': newMessage.receiver,
                                      'content': newMessage.content,
                                      'time': newMessage.timeStamp
                                    });
                                    setState(() {
                                      print("${snapshot.connectionState}");
                                    });
                                  },
                                  child: Container(
                                    height: maxHeight * 1,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.lime,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key key,
    @required this.message,
    this.isUser,
    @required this.time,
  }) : super(key: key);

  final String message;
  final bool isUser;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerLeft : Alignment.centerRight,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 6.0, right: 6.0, bottom: 5, top: 5),
        child: Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.5),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: isUser
                  ? LinearGradient(colors: [
                      Colors.purple.shade600,
                      Colors.deepPurpleAccent.shade700,
                    ])
                  : null,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Text(
                message,
                style: GoogleFonts.comfortaa(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isUser ? Colors.white : Colors.black)),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "$time",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
