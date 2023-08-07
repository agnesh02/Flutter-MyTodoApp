import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_riverpod/models/common.dart';
import 'package:todo_app_riverpod/screens/home_screen.dart';

class LoginCredentials {
  String emailId;
  String password;

  LoginCredentials({required this.emailId, required this.password});
}

class LoginNotifier extends StateNotifier<LoginCredentials> {
  LoginNotifier() : super(LoginCredentials(emailId: "", password: ""));

  void updateEmail(String email) {
    state.emailId = email;
  }

  void updatePassword(String password) {
    state.password = password;
  }

  Future<void> loginUser(BuildContext context) async {
    try {
      UserCredential userCredential = await Common.firebaseAuthInstance
          .signInWithEmailAndPassword(
              email: state.emailId, password: state.password);
      Common.email = userCredential.user!.email!;
      Common.username = userCredential.user!.displayName!;
      Common.navigateTo(context, const HomeScreen());
      Common.showSnack(context, "Welcome ${Common.username}");
    } catch (e) {
      print(e);
      Common.showSnack(context, "$e");
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginCredentials>(
  (ref) => LoginNotifier(),
);
