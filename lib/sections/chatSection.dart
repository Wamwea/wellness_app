import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellness_app/Models/userModel.dart';
import 'package:wellness_app/screens/ChatScreen.dart';
import 'package:wellness_app/main.dart';

class Page2 extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    UserModel userModel = watch(userProvider);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xff56ab2f), Color(0xffa8e063)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft),
      ),
      child: Center(
          child: Column(
        children: [
          Material(
            elevation: 10,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xff001838),
                  border: Border(
                      bottom: BorderSide(color: Colors.black, width: 0.2))),
              height: MediaQuery.of(context).size.height * 0.08,
              width: double.infinity,
              child: Center(
                  child: Text(
                "Chat",
                style: GoogleFonts.shadowsIntoLight(
                    color: Colors.lime,
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              )),
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                  itemCount: userModel.userList.length,
                  itemBuilder: (context, index) {
                    String userEmail = userModel.userList[index].email;
                    String userName = userModel.userList[index].username;
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ChatScreen(userEmail, userName);
                          }));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.09,
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                              color: Color(0xff001838),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                    image: DecorationImage(
                                        image: AssetImage("assets/man.png"),
                                        fit: BoxFit.cover)),
                                width: MediaQuery.of(context).size.width * 0.13,
                                height:
                                    MediaQuery.of(context).size.width * 0.13,
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 14.0),
                                        child: Text(
                                          "${userModel.getUser(index).username}",
                                          style: TextStyle(
                                              color: Colors.lime,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      )),
    );
  }
}
