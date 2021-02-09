import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellness_app/Data%20Classes/ThoughtPost.dart';
import 'package:wellness_app/Data%20Classes/User.dart';
import 'package:wellness_app/Models/userModel.dart';
import 'package:wellness_app/main.dart';
import 'package:wellness_app/screens/home_screen.dart';
import 'package:wellness_app/services/networking.dart';
import 'package:wellness_app/Models/thoughtBubbleModel.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
ThoughtBubbleModel thoughtBubbleModel = ThoughtBubbleModel();
UserModel userModel = UserModel();

class _LoadingScreenState extends State<LoadingScreen> {
  void getData() async {
    await _firebaseFirestore.collection('Users').get().then((value) {
      value.docs.forEach((element) {
        MyUser newUser =
            MyUser(element['username'], element['email'], element['password']);
        context.read(userProvider).addToUserList(newUser);
        print("no of users: ${userModel.userList.length}");
      });
    });
    await _firebaseFirestore.collection('ThoughtFeed').get().then((value) {
      value.docs.forEach((element) async {
        ThoughtPost newThought = ThoughtPost(element['username'].toString(),
            element['title'].toString(), element['content'].toString());
        print('${element['username']}');
        context.read(thoughtFeedProvider).addPost(newThought);
        print("No of thoughts: ${thoughtBubbleModel.getPostNumber()}");
      });
    });
    print("Finished getting");
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomeScreen();
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator(), Text("Loading Data")],
        ),
      ),
    );
  }
}
