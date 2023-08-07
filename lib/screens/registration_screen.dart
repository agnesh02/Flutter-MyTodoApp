import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_riverpod/models/common.dart';
import 'package:todo_app_riverpod/providers/registration_provider.dart';
import 'package:todo_app_riverpod/screens/login_screen.dart';
import 'package:todo_app_riverpod/widgets/field_input_widget.dart';

class RegistrationScreen extends ConsumerWidget {
  RegistrationScreen({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Registration Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FieldInputWidget(
              onChange: (val) =>
                  ref.read(registrationProvider.notifier).updateUsername(val),
              hint: "Username",
              textEditingController: usernameController,
              borderColor: Colors.transparent),
          FieldInputWidget(
              onChange: (val) =>
                  ref.read(registrationProvider.notifier).updateEmail(val),
              hint: "Email",
              textEditingController: emailController,
              borderColor: Colors.transparent),
          FieldInputWidget(
              onChange: (val) =>
                  ref.read(registrationProvider.notifier).updatePassword(val),
              hint: "Password",
              textEditingController: passwordController,
              borderColor: Colors.transparent),
          FieldInputWidget(
              onChange: (val) => ref
                  .read(registrationProvider.notifier)
                  .updateConfirmPassword(val),
              hint: "Confirm password",
              textEditingController: confirmPasswordController,
              borderColor: Colors.transparent),
          const SizedBox(height: 24.0),
          Container(
            width: 200,
            height: 40,
            decoration: ShapeDecoration(
              color: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                elevation: 2,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                ref.read(registrationProvider.notifier).registerUser(context);
              },
              child: const Text('Register'),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: InkWell(
                onTap: () => Common.navigateTo(context, LoginScreen()),
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Existing user?",
                        style: TextStyle(
                          color: Color(0xFF252525),
                          fontSize: 15,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(text: "  "),
                      TextSpan(
                        text: "Login now.",
                        style: TextStyle(
                          color: Color(0xFF6C63FF),
                          fontSize: 15,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
