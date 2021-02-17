import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellness_app/Components/FeedBubbleComponent.dart';
import 'package:wellness_app/Models/thoughtBubbleModel.dart';
import 'package:wellness_app/main.dart';
import 'package:wellness_app/screens/LoadingScreen.dart';
import 'package:wellness_app/Data Classes/ThoughtPost.dart';
import 'package:wellness_app/Data Classes/User.dart';
import 'package:timeago/timeago.dart' as timeago;

class ThoughtBubbleSection extends ConsumerWidget {
  String newPostTitle;

  String newPostText;

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  FirebaseAuth _auth = FirebaseAuth.instance;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void getStream() async {
    await _firebaseFirestore.collection('Users').get().then((value) {
      value.docs.forEach((element) {
        MyUser newUser =
            MyUser(element['username'], element['email'], element['password']);
        userModel.addToUserList(newUser);

        print("no of users: ${userModel.userList.length}");
      });
    });
    dynamic myUsername;
    await _firebaseFirestore
        .collection('Users')
        .doc('${_auth.currentUser.email}')
        .get()
        .then((snapshot) {
      myUsername = snapshot.data()['username'];
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
        "Hello $myUsername",
        textAlign: TextAlign.center,
      )));
    });
    print("${ThoughtBubbleModel().getPostNumber()}");
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    ThoughtBubbleModel thoughtBubbleProvider = watch(thoughtFeedProvider);
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          Material(
            elevation: 10,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xff001838),
                  border: Border(
                      bottom: BorderSide(color: Colors.black, width: 0.2))),
              height: MediaQuery.of(context).size.height * 0.08,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          getStream();
                        },
                        child: Icon(
                          Icons.settings_rounded,
                          color: Colors.lime,
                        )),
                    Text(
                      "Thought Bubble",
                      style: GoogleFonts.shadowsIntoLight(
                          textStyle: TextStyle(
                              color: Colors.lime,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState.showBottomSheet((context) {
                          return Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xff56ab2f),
                                    Color(0xffa8e063)
                                  ],
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft),
                            ),
                            height: maxHeight * 0.6,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)),
                                color: Color(0xff001838),
                              ),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(8),
                                        height: constraints.maxHeight * 0.1,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 18.0,
                                          ),
                                          child: TextFormField(
                                            onChanged: (value) {
                                              newPostTitle = value;
                                            },
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                                hintText: "Insert Title Here",
                                                hintStyle: TextStyle(
                                                    color: Colors.black)),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        width: constraints.maxWidth,
                                        height: constraints.maxHeight * 0.7,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: TextFormField(
                                          onChanged: (value) {
                                            newPostText = value;
                                          },
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              filled: true,
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.all(5)),
                                          maxLines: null,
                                          keyboardType: TextInputType.multiline,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 3.0, bottom: 3),
                                          child: GestureDetector(
                                            onTap: () async {
                                              print('submitting data');
                                              dynamic myUsername;
                                              await _firebaseFirestore
                                                  .collection('Users')
                                                  .doc(
                                                      '${_auth.currentUser.email}')
                                                  .get()
                                                  .then((snapshot) {
                                                myUsername =
                                                    snapshot.data()['username'];
                                              });
                                              print('username obtained');
                                              await _firebaseFirestore
                                                  .collection("ThoughtFeed")
                                                  .add({
                                                'content': newPostText,
                                                'username': myUsername,
                                                'email':
                                                    _auth.currentUser.email,
                                                'title': newPostTitle,
                                                'time': Timestamp.now(),
                                              }).then((value) {
                                                ThoughtPost newPost =
                                                    ThoughtPost(
                                                        username: myUsername,
                                                        title: newPostTitle,
                                                        content: newPostText,
                                                        email: _auth
                                                            .currentUser.email,
                                                        time: Timestamp.now());
                                                thoughtBubbleProvider
                                                    .addPost(newPost);
                                              });
                                              print(
                                                  "Data submitted succesfully");
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.purple.shade600,
                                                        Colors.deepPurpleAccent
                                                            .shade700,
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end: Alignment
                                                          .bottomRight),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              width: constraints.maxWidth * 0.5,
                                              child: Center(
                                                  child: Text(
                                                "Submit",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                        });
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.lime,
                        size: 40,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff56ab2f), Color(0xffa8e063)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft),
              ),
              width: double.infinity,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 5.0,
                ),
                child: ListView.builder(
                    itemCount: thoughtBubbleProvider.postList.length,
                    itemBuilder: (context, index) {
                      return FeedBubbleComponent(
                        PageStorageKey("MyState"),
                        time: timeago
                            .format(thoughtBubbleProvider.postList[index].time
                                .toDate())
                            .toString(),
                        poemText: thoughtBubbleProvider.postList[index].content,
                        poemTitle: thoughtBubbleProvider.postList[index].title,
                        poemAuthor:
                            thoughtBubbleProvider.postList[index].username,
                      );
                    }),
              )),
            ),
          )
        ],
      ),
    );
  }
}
