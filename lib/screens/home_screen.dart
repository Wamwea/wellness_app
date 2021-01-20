import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellness_app/sections/thought_bubble.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class FeedBubble extends StatelessWidget {
  FeedBubble(
    this.text,
  );
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xffEBE4DC), borderRadius: BorderRadius.circular(5)),
        height: MediaQuery.of(context).size.height * 0.4,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.045,
                      width: MediaQuery.of(context).size.height * 0.045,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("assets/logo.jpg"),
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Account $text",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "8 March 2019",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        "Title goes here",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "$text Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor i"
                        "ncididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exe"
                        "rcitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor i"
                        "n reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur"
                        " sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id "
                        "est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor i"
                        "ncididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exe"
                        "rcitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor i"
                        "n reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur"
                        " sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id "
                        "est laborum",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      color: Colors.blue,
      child: Center(child: Text("PAGE 2")),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.yellow,
      width: double.infinity,
      child: Center(child: Text("PAGE 3")),
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> pages = [Page1(), Page2(), Page3()];
  int currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(child: pages[currentIndex]),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.black, width: 0.5))),
          child: SnakeNavigationBar.color(
            showSelectedLabels: true,
            showUnselectedLabels: false,
            backgroundColor: Color(0xffF2DFCE),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            shadowColor: Colors.black,
            snakeViewColor: Colors.black,
            currentIndex: currentIndex,
            onTap: changePage,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.comment), label: "Bubble"),
              BottomNavigationBarItem(icon: Icon(Icons.face), label: "Chat"),
              BottomNavigationBarItem(icon: Icon(Icons.lock), label: "Journal"),
            ],
          ),
        ),
      ),
    );
  }
}
