import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wellness_app/Models/thoughtBubbleModel.dart';

class Networking {
  PoemModel poemModel = PoemModel();
  Future<void> getPoems() async {
    print("Call starting");
    http.Response response =
        await http.get("https://poetrydb.org/author,title/Shakespeare;Sonnet");
    if (response.statusCode == 200) {
      dynamic poemData = jsonDecode(response.body);
      int noOfPoems = poemData.length;

      for (int x = 0; x < noOfPoems; x++) {
        int lineCount = int.parse(poemData[x]["linecount"]);
        String myPoem = "";
        for (int y = 0; y < lineCount; y++) {
          myPoem = myPoem + "\n" + poemData[x]["lines"][y];
        }
        poemModel.addPoem(myPoem);
        String myTitle;
        String myAuthor;
        myAuthor = poemData[x]["author"];
        myTitle = poemData[x]["title"];
        poemModel.addAuthor(myAuthor);
        poemModel.addTitle(myTitle);
      }
    } else {
      print("Error ${response.statusCode}");
    }
  }
}
