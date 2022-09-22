// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthFunction {
  Future<bool> loginUser(String email, String password);
  Future<bool> registerUser(String email, String password);
  Future<bool> signOutUser();
}

class AuthController implements AuthFunction {
  var mAuth = FirebaseAuth.instance;

  @override
  Future<bool> loginUser(String email, String password) async {
    try {
      final res = await mAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (res.user != null) {
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> registerUser(String email, String password) async {
    try {
      final res = await mAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (res.user != null) {
        //Save user data  to Database or CLoud firestore
        
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> signOutUser() async {
    await mAuth.signOut();
    return true;
  }
}
