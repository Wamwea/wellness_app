import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> messages = [];
  String myMessage;
  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          height: maxHeight,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                color: Color(0xffF2DFCE),
                height: maxHeight * 0.09,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_sharp,
                        size: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 100.0),
                      child: Text(
                        "Brian Wamwea",
                        style: GoogleFonts.shadowsIntoLight(
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                color: Color(0xffFFF1E5),
                width: double.infinity,
                child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          alignment: index.isEven
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          height: 30,
                          child: Text(messages[index]),
                        ),
                      );
                    }),
              )),
              Container(
                color: Color(0xffF2DFCE),
                width: double.infinity,
                height: maxHeight * 0.07,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 6.0, right: 0, top: 6, bottom: 6),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35)),
                        child: TextFormField(
                          onChanged: (value) {
                            myMessage = value;
                          },
                          decoration: InputDecoration(
                              filled: true,
                              hintText: "Type your message",
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide: BorderSide(color: Colors.white))),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              messages.add(myMessage);
                            });
                          },
                          child: Container(
                            height: maxHeight * 1,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
