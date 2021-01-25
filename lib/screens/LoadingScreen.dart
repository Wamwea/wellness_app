import 'package:flutter/material.dart';
import 'package:wellness_app/screens/home_screen.dart';
import 'package:wellness_app/services/networking.dart';
import 'package:wellness_app/Models/thoughtBubbleModel.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Networking networking = Networking();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomeScreen();
    }));
  }

  void getData() async {
    await networking.getPoems();
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
