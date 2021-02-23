import 'package:flutter/cupertino.dart';
import 'package:wellness_app/Data%20Classes/ThoughtPost.dart';

class ThoughtBubbleModel extends ChangeNotifier {
  List<ThoughtPost> postList = new List();
  int getPostNumber() {
    return postList.length;
  }

  void resetList() {
    postList = [];
    notifyListeners();
  }

  void addPost(ThoughtPost post) {
    postList.add(post);
    notifyListeners();
  }

  ThoughtPost getPost(int index) {
    return postList[index];
  }

  void removePost(int index) {
    postList.removeAt(index);
    notifyListeners();
  }
}
