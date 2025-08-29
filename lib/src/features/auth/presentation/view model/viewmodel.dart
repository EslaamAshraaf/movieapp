import 'package:flutter/foundation.dart';
import 'package:movieapp/src/core/firebase/firbase_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/model.dart';

class LoginViewModel extends ChangeNotifier {
  final FirebaseManager _firebaseManager = FirebaseManager();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AuthUser? _user;
  AuthUser? get user => _user;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loginWithEmail(String email, String password) async {
    _setLoading(true);
    try {
      final UserCredential? credential = await _firebaseManager
          .signInWithEmailAndPassword(emailAddress: email, password: password);

      if (credential != null) {
        _user = AuthUser(
          uid: credential.user?.uid,
          email: credential.user?.email,
          displayName: credential.user?.displayName,
        );
      } else {
        _errorMessage = "Login failed, check credentials.";
      }
    } catch (e) {
      _errorMessage = e.toString();
    }
    _setLoading(false);
  }

  Future<void> loginWithGoogle() async {
    _setLoading(true);
    try {
      final UserCredential? credential = await _firebaseManager.signInWithGoogle();
      if (credential != null) {
        _user = AuthUser(
          uid: credential.user?.uid,
          email: credential.user?.email,
          displayName: credential.user?.displayName,
        );
      } else {
        _errorMessage = "Google login failed";
      }
    } catch (e) {
      _errorMessage = e.toString();
    }
    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
