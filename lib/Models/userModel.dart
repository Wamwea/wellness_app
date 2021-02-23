import 'package:flutter/cupertino.dart';
import 'package:wellness_app/Data Classes/User.dart';
import 'package:wellness_app/Data Classes/Task.dart';

class UserModel extends ChangeNotifier {
  List<MyUser> userList = [];
  void addToUserList(MyUser newUser) {
    userList.insert(0, newUser);
    notifyListeners();
  }

  void resetList() {
    userList = [];
    notifyListeners();
  }

  MyUser getUser(int index) {
    return userList[index];
  }

  void removeUser(int index) {
    userList.removeAt(index);
    notifyListeners();
  }

  void addUserTask(int index, Task newTask) {
    userList[index].userTasks.add(newTask);
  }
}
