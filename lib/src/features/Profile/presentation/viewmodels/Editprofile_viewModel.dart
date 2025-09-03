import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Data/Model_profile.dart';

class UserViewModel extends ChangeNotifier {
  UserModel _user = UserModel(
    avatar: "assets/Profiles/profile1.png",
    name: "Loading...",
    phone: "",
  );

  UserModel get user => _user;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  /// ✅ تحميل بيانات المستخدم من Firestore
  Future<void> loadUserData() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final doc = await _firestore.collection("users").doc(uid).get();
    if (doc.exists) {
      final data = doc.data()!;
      _user = UserModel(
        avatar: data["avatar"] ?? "assets/Profiles/profile1.png",
        name: data["name"] ?? "No Name",
        phone: data["phone"] ?? "",
      );
      notifyListeners();
    }
  }

  /// ✅ تحديث الصورة
  Future<void> updateAvatar(String avatar) async {
    _user.avatar = avatar;
    notifyListeners();
    await _saveToFirestore();
  }

  /// ✅ تحديث الاسم
  Future<void> updateName(String name) async {
    _user.name = name;
    notifyListeners();
    await _saveToFirestore();
  }

  /// ✅ تحديث الهاتف
  Future<void> updatePhone(String phone) async {
    _user.phone = phone;
    notifyListeners();
    await _saveToFirestore();
  }

  /// ✅ تحديث البيانات كلها مع بعض
  Future<void> updateUser({
    String? avatar,
    String? name,
    String? phone,
  }) async {
    if (avatar != null) _user.avatar = avatar;
    if (name != null) _user.name = name;
    if (phone != null) _user.phone = phone;
    notifyListeners();
    await _saveToFirestore();
  }

  /// ✅ حفظ البيانات في Firestore
  Future<void> _saveToFirestore() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    await _firestore.collection("users").doc(uid).set({
      "avatar": _user.avatar,
      "name": _user.name,
      "phone": _user.phone,
    }, SetOptions(merge: true));
  }
}
