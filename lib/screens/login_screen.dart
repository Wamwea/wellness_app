import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellness_app/screens/LoadingScreen.dart';
import 'package:wellness_app/screens/RegistrationScreen.dart';
import 'package:wellness_app/Components/TextBoxComponent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wellness_app/Components/ButtonComponent.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: Container(
          height: maxHeight,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
//                  colors: [Colors.lime, Colors.teal],
                  colors: [Colors.blueGrey, Colors.indigo],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft)),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          child: Hero(
                            tag: "asf",
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.height * 0.3,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage("assets/logo.jpg"),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          child: Container(
                              child: TypewriterAnimatedTextKit(
                            text: ["Welcome To Wellness App"],
                            speed: Duration(milliseconds: 100),
                            textAlign: TextAlign.justify,
                            textStyle: GoogleFonts.lobster(
                                textStyle: TextStyle(
                                    color: Color(0xff002241),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          )),
                        ),
                        TextBoxComponent(
                          onChanged: (value) {
                            email = value;
                          },
                          hintText: "Email",
                          icon: Icon(Icons.email_outlined),
                        ),
                        TextBoxComponent(
                          onChanged: (value) {
                            password = value;
                          },
                          hintText: "PassWord",
                          icon: Icon(Icons.lock_outlined),
                          obscureText: true,
                        ),
                        ButtonComponent(
                            label: "Log in",
                            onTap: () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(content: Text("Loading")));
                              await _auth
                                  .signInWithEmailAndPassword(
                                      email: email, password: password)
                                  .then((value) {
                                preferences.setString("email", email);
                                preferences.setString("password", password);
                              });
                              print("Sign In Successful");

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return LoadingScreen();
                              }));
                            }),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xff002241),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return RegistrationScreen();
                                    }));
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff002241),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
