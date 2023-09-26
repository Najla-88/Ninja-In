import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  String username = '';
  String uemail = '';
  String upassword = '';
  String picURL = '';

  void setUsername(String name) {
    username = name;
    notifyListeners();
  }

  void setUserEmail(String email) {
    uemail = email;
    notifyListeners();
  }

  void setUserPassword(String password) {
    upassword = password;
    notifyListeners();
  }

  void setUserPic(String url) {
    picURL = url;
    notifyListeners();
  }

  void resetObject() {
    username = '';
    uemail = '';
    upassword = '';
    picURL = '';
  }
}
