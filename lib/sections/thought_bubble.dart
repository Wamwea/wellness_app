import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 10,
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xffF2DFCE),
                border: Border(
                    bottom: BorderSide(color: Colors.black, width: 0.2))),
            height: MediaQuery.of(context).size.height * 0.08,
            width: double.infinity,
            child: Center(
                child: Text(
              "Thought Bubble",
              style: GoogleFonts.shadowsIntoLight(
                  textStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            )),
          ),
        ),
        Expanded(
          child: Container(
            color: Color(0xffFFF1E5),
            width: double.infinity,
            child: Center(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return FeedBubble("${index * 10}");
                    })),
          ),
        )
      ],
    );
  }
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
