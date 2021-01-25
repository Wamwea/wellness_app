import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThoughtBubbleSection extends StatelessWidget {
  ThoughtBubbleSection({Key key, this.poemTitles, this.poems, this.poemAuthors})
      : super(key: key);
  final List<String> poems;
  final List<String> poemTitles;
  final List<String> poemAuthors;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.settings_rounded),
                    Text(
                      "Thought Bubble",
                      style: GoogleFonts.shadowsIntoLight(
                          textStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Icon(
                      Icons.add,
                      size: 40,
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Color(0xffFFF1E5),
              width: double.infinity,
              child: Center(
                  child: ListView.builder(
                      itemCount: poems.length,
                      itemBuilder: (context, index) {
                        return FeedBubble(
                          PageStorageKey("MyState"),
                          poemText: poems[index],
                          poemTitle: poemTitles[index],
                          poemAuthor: poemAuthors[index],
                        );
                      })),
            ),
          )
        ],
      ),
    );
  }
}

class FeedBubble extends StatelessWidget {
  FeedBubble(Key key, {this.poemText, this.poemTitle, this.poemAuthor})
      : super(key: key);
  final String poemText;
  final String poemTitle;
  final String poemAuthor;
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
                              image: AssetImage("assets/man.png"),
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$poemAuthor",
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
                        "$poemTitle",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "$poemText",
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
