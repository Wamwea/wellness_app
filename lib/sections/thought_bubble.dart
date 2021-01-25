import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThoughtBubbleSection extends StatelessWidget {
  const ThoughtBubbleSection({Key key}) : super(key: key);
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
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return FeedBubble(
                            PageStorageKey("MyState"), "${index * 10}");
                      })),
            ),
          )
        ],
      ),
    );
  }
}

class FeedBubble extends StatelessWidget {
  FeedBubble(
    Key key,
    this.text,
  ) : super(key: key);
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
                              image: AssetImage("assets/man.png"),
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "User $text",
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
                        "The World’s Oldest Animal Paintings Are on This Cave Wall",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${"In the Western imagination, ancient cave paintings tend to conjure images of Lascaux, the cave complex in southwestern France that is famous for its exceptionally detailed depictions of humans and animals. The Lascaux paintings, however, are a mere 17,000 years old. The oldest known examples of figurative art, or imagery that shows more than just abstractions, occur in Southeast Asia. Now a painting of pigs discovered in a cave in Indonesia sets a new record for the earliest figurative art—at least 45,500 years old—according to research published on Wednesday in Science Advances.We stress that this is only a minimum age,” says co-author Maxime Aubert, a professor of archeological science at Griffith University in Australia. “The rock art in this region could very well be 60,000 to 65,000 years old. We just need more samples.”"}",
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
