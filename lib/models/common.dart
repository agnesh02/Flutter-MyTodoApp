import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Common {
  Common._(); // Private constructor to prevent external instantiation
  static final Common _instance =
      Common._(); // The single instance of the class
  factory Common() => _instance; // Factory method to access the single instance

  static String username = "";
  static String email = "";
  static FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestoreInstance = FirebaseFirestore.instance;
  static Map<String,int> stats = {};

  static void showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static void navigateTo(BuildContext context, Widget screen) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}
