import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      color: Color(0xffFFF1E5),
      child: Center(
          child: Column(
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
                "Chat",
                style: GoogleFonts.shadowsIntoLight(
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              )),
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                  itemCount: 14,
                  itemBuilder: (context, index) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.14,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 0.8))),
                      width: double.infinity,
                      child: Text("19238yjdksnfaksjnda"),
                    );
                  }),
            ),
          )
        ],
      )),
    );
  }
}
