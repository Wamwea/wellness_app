import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellness_app/Data%20Classes/Task.dart';

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  FirebaseAuth _auth = FirebaseAuth.instance;
  String taskTitle;
  String taskText;
  bool isDone;
  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Scaffold.of(context).showBottomSheet((context) {
            return Container(
              height: maxHeight * 0.4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff56ab2f), Color(0xffa8e063)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Color(0xff001838),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(8),
                          height: constraints.maxHeight * 0.1,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18.0,
                            ),
                            child: TextFormField(
                              onChanged: (value) {
                                taskTitle = value;
                              },
                              style: TextStyle(fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: "Enter Goal here",
                                  hintStyle: TextStyle(
                                      color: Colors.black, fontSize: 14)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          width: constraints.maxWidth,
                          height: constraints.maxHeight * 0.7,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            onChanged: (value) {
                              taskText = value;
                            },
                            decoration: InputDecoration(
                                hintText: "Describe your goal",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                filled: true,
                                isDense: true,
                                contentPadding: EdgeInsets.all(5)),
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              print("Task Submission Started");
                              await _firebaseFirestore
                                  .collection('Users')
                                  .doc('${_auth.currentUser.email}')
                                  .collection('Tasks')
                                  .add({
                                'taskTitle': taskTitle,
                                'taskText': taskText,
                                'time': Timestamp.now(),
                                'isDone': false,
                              });
                              print("Task Pushed successfully");
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 3.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.purple.shade600,
                                        Colors.deepPurpleAccent.shade700,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                                ),
                                child: Center(
                                    child: Text(
                                  "Add Task",
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.12,
          height: MediaQuery.of(context).size.width * 0.12,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.purple.shade600,
                Colors.deepPurpleAccent.shade700,
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              color: Colors.red,
              shape: BoxShape.circle),
          child: Icon(Icons.add),
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff56ab2f), Color(0xffa8e063)],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
          ),
          child: StreamBuilder(
            stream: _firebaseFirestore
                .collection("Users")
                .doc(_auth.currentUser.email)
                .collection("Tasks")
                .orderBy("time", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var myDocs = snapshot.data.docs;
                List<TaskTile> myTaskList = [];
                for (var document in myDocs) {
                  Task myTask = Task(
                      taskTitle: document.get('taskTitle'),
                      taskText: document.get('taskText'),
                      isDone: document.get('isDone'),
                      time: document.get('time'));
                  TaskTile newTaskTile = TaskTile(
                    isDone: myTask.isDone,
                    taskDescription: myTask.taskText,
                    taskTitle: myTask.taskTitle,
                  );
                  myTaskList.add(newTaskTile);
                }
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Material(
                      elevation: 10,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xff001838),
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black, width: 0.2))),
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: double.infinity,
                        child: Center(
                            child: Text(
                          "My Goals",
                          style: GoogleFonts.shadowsIntoLight(
                              color: Colors.lime,
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        )),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              return TaskTile(
                                onTap: () async {
                                  print("isTapped");
                                  QuerySnapshot myTaskLocation =
                                      await _firebaseFirestore
                                          .collection("Users")
                                          .doc('${_auth.currentUser.email}')
                                          .collection("Tasks")
                                          .get();
                                  QueryDocumentSnapshot documentSnapShot =
                                      myTaskLocation.docs[index];
                                  print("${documentSnapShot.get("isDone")}");
                                  await documentSnapShot.reference.update({
                                    "isDone":
                                        snapshot.data.docs[index].get('isDone')
                                            ? false
                                            : true
                                  });
                                },
                                isDone: snapshot.data.docs[index].get('isDone'),
                                taskTitle:
                                    snapshot.data.docs[index].get('taskTitle'),
                                taskDescription:
                                    snapshot.data.docs[index].get('taskText'),
                              );
                            }),
                      ),
                    ),
                  ],
                ));
              } else {
                return CircularProgressIndicator();
              }
            },
          )),
    );
  }
}

class TaskTile extends StatelessWidget {
  const TaskTile({
    this.taskDescription,
    this.isDone,
    this.taskTitle,
    this.onTap,
    Key key,
  }) : super(key: key);
  final Function onTap;
  final String taskDescription;
  final String taskTitle;
  final bool isDone;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Color(0xff001838),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$taskTitle",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "$taskDescription",
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  isDone
                      ? Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.purple.shade600,
                                    Colors.deepPurpleAccent.shade700,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.check,
                                size: 20.0,
                                color: Colors.white,
                              )),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.check,
                                size: 20.0,
                                color: Colors.white,
                              )),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
