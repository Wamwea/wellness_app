import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wellness_app/Components/TextBoxComponent.dart';
import 'package:wellness_app/Models/thoughtBubbleModel.dart';
import 'package:wellness_app/screens/LoadingScreen.dart';
import 'package:wellness_app/Components/ButtonComponent.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String username;
  String email;
  String password;
  String confirmPassword;
  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Container(
            height: maxHeight,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blueGrey, Colors.indigo],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: "asf",
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/logo.jpg"),
                            fit: BoxFit.cover)),
                  ),
                ),
                TextBoxComponent(
                  hintText: "Username",
                  icon: Icon(Icons.face),
                  onChanged: (value) {
                    username = value;
                  },
                ),
                TextBoxComponent(
                  hintText: "Email",
                  icon: Icon(Icons.email_outlined),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                TextBoxComponent(
                  hintText: "Password",
                  icon: Icon(Icons.lock_outlined),
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                TextBoxComponent(
                  obscureText: true,
                  icon: Icon(Icons.lock_outlined),
                  hintText: "Confirm Password",
                  onChanged: (value) {
                    confirmPassword = value;
                  },
                ),
                ButtonComponent(
                    label: "Sign Up",
                    onTap: () async {
                      if (confirmPassword == password) {
                        _auth
                            .createUserWithEmailAndPassword(
                                email: email, password: password)
                            .then((fireBaseUser) async {
                          if (fireBaseUser == null) {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text(
                                    "Error creating user.Please try again")));
                          } else {
                            print("User Created Successfully");
                            await _firestore
                                .collection("Users")
                                .doc("$email")
                                .set({
                              "username": "$username",
                              "password": "$password",
                              "email": "$email",
                            }).then((value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return LoadingScreen();
                                }),
                              );
                            });
                          }
                        });
                      } else {
                        _scaffoldKey.currentState.showSnackBar(
                            SnackBar(content: Text("passwords do not match")));
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
