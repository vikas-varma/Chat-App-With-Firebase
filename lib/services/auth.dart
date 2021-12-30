// ignore_for_file: non_constant_identifier_names, unused_local_variable, empty_catches, import_of_legacy_library_into_null_safe, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/modal/user.dart';

class Authmethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _userfromfirebaseuser(FirebaseUser user) {
    return user != null ? User(userId: user.uid) : null;
  }

  Future Signinwithemailandpassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userfromfirebaseuser(firebaseUser);
    } catch (e) {
      print(e);
    }
  }

  Future signupwithemailandpassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userfromfirebaseuser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetpass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future singnout() async {
    try {
      return await _auth.signOut();
    } catch (e) {}
  }
}
