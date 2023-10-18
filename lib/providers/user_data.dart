import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ninjain/models/user_model.dart';

class UserData extends ChangeNotifier {
  Users user = Users();
  bool isUpdated = false;
  void setUser(Users u) {
    user = u;
    notifyListeners();
  }

  void changeUserName(String name) {
    user.name = name;
    isUpdated = true;
    notifyListeners();
  }

  void changeUserPass(String pass) {
    user.password = pass;
    isUpdated = true;
    notifyListeners();
  }

  void setUserPic(Uint8List? img) {
    user.img = img;
    isUpdated = true;
    notifyListeners();
  }

  void resetObject() {
    user = Users();
    notifyListeners();
  }
}
