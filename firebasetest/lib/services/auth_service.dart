import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/listpage.dart';
import 'package:firebasetest/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final userCollection = FirebaseFirestore.instance.collection("users");
  final firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp(BuildContext context,
      {required String name,
      required String email,
      required String password}) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        Fluttertoast.showToast(
            msg: "Giriş Yapıldı", toastLength: Toast.LENGTH_LONG);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: ((context) => testWidget())));
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
    }
  }
}
