import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_riverpod/models/common.dart';

class RegistrationCredentials {
  String username;
  String emailId;
  String password;
  String confirmPassword;

  RegistrationCredentials({
    required this.username,
    required this.emailId,
    required this.password,
    required this.confirmPassword,
  });
}

class RegistrationNotifier extends StateNotifier<RegistrationCredentials> {
  RegistrationNotifier()
      : super(
          RegistrationCredentials(
              username: "", emailId: "", password: "", confirmPassword: ""),
        );

  void updateUsername(String newVal) {
    state.username = newVal;
  }

  void updateEmail(String newVal) {
    state.emailId = newVal;
  }

  void updatePassword(String newVal) {
    state.password = newVal;
  }

  void updateConfirmPassword(String newVal) {
    state.confirmPassword = newVal;
  }

  void registerUser(BuildContext context) async {
    try {
      UserCredential userCredential =
          await Common.firebaseAuthInstance.createUserWithEmailAndPassword(
        email: state.emailId,
        password: state.password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(state.username);
      }
      Common.firebaseFirestoreInstance
          .collection(user!.email!)
          .doc("STAT")
          .set({"completed": 0, "inProgress": 0});
      Common.showSnack(context,
          "Your registration is successfull.\nYou can login and start using the app right away!.");
    } catch (e) {
      print(e.toString());
    }
  }
}

final registrationProvider =
    StateNotifierProvider<RegistrationNotifier, RegistrationCredentials>(
  (ref) => RegistrationNotifier(),
);
