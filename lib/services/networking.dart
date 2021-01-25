import 'dart:convert';

import 'package:http/http.dart' as http;

class Networking {
  Future<String> getPoems() async {
    print("Call starting");
    http.Response response =
        await http.get("https://poetrydb.org/title/Ozymandias/lines.json");
    if (response.statusCode == 200) {
      dynamic myPoem = jsonDecode(response.body);
      List<dynamic> poemData = myPoem[0]["lines"];
      List<String> myString = new List();
      for (dynamic poem in poemData) {
        myString.add(poem.toString());
      }
      print(myString);
      String finalPoem = "";
      for (String line in myString) {
        finalPoem = finalPoem + "\n " + line;
      }
      print(finalPoem);
      return finalPoem;
    } else {
      print("Error ${response.statusCode}");
    }
  }
}
