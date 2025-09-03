import 'package:flutter/material.dart';

import '../../Data/Model_profile.dart';


class UserViewModel extends ChangeNotifier {
  final UserModel _user = UserModel(
    avatar: "assets/Profiles/profile1.png",
    name: "John Safwat",
    phone: "01200000000",
  );

  UserModel get user => _user;

  void updateAvatar(String avatar) {
    _user.avatar = avatar;
    notifyListeners();
  }

  void updateName(String name) {
    _user.name = name;
    notifyListeners();
  }

  void updatePhone(String phone) {
    _user.phone = phone;
    notifyListeners();
  }
}
