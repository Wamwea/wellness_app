import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wellness_app/screens/login_screen.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startApp();
  }

  Future<void> startApp() async {
    await Firebase.initializeApp();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Loading")),
    );
  }
}
