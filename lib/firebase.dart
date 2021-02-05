import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthMethods {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print("You have error");
      print(e.message);

    }
  }
}