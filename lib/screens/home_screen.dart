import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:wellness_app/sections/thought_bubble.dart';
import 'package:wellness_app/sections/chatSection.dart';
import 'package:wellness_app/sections/goals_section.dart';
import 'package:wellness_app/Models/thoughtBubbleModel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PoemModel poemModel = PoemModel();

  final List<Widget> pages = [
    ThoughtBubbleSection(
      key: PageStorageKey("Page 1"),
      poems: PoemModel.myPoems,
      poemTitles: PoemModel.poemTitles,
      poemAuthors: PoemModel.poemAuthor,
    ),
    Page2(),
    Page3()
  ];
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
              border: Border(top: BorderSide(color: Colors.black, width: 0.9))),
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
                  icon: Icon(CupertinoIcons.square_stack_fill),
                  label: "Bubble"),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.bubble_left_bubble_right_fill),
                  label: "Chat"),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.bandage_fill), label: "Journal"),
            ],
          ),
        ),
      ),
    );
  }
}
