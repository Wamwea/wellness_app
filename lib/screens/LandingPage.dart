import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellness_app/screens/LoadingScreen.dart';
import 'package:wellness_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startApp();
  }

  Future<void> startApp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey("email")) {
      await _auth.signInWithEmailAndPassword(
          email: preferences.getString("email"),
          password: preferences.getString("password"));
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LoadingScreen();
      }));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Loading")),
    );
  }
}
