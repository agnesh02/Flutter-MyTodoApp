import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_riverpod/models/common.dart';
import 'package:todo_app_riverpod/providers/backend_provider.dart';
import 'package:todo_app_riverpod/providers/login_provider.dart';
import 'package:todo_app_riverpod/screens/registration_screen.dart';
import 'package:todo_app_riverpod/widgets/field_input_widget.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final StateProvider<bool> loadingProvider =
      StateProvider<bool>((ref) => false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FieldInputWidget(
                    onChange: (val) =>
                        ref.read(loginProvider.notifier).updateEmail(val),
                    hint: "Email",
                    textEditingController: emailController,
                    borderColor: Colors.purple),
                FieldInputWidget(
                    onChange: (val) =>
                        ref.read(loginProvider.notifier).updatePassword(val),
                    hint: "Password",
                    textEditingController: passwordController,
                    borderColor: Colors.purple),
                const SizedBox(height: 30),
                Container(
                  width: 200,
                  height: isLoading ? 60 : 40,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF6C63FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      ref.read(loadingProvider.notifier).state = true;
                      ref.read(loginProvider.notifier).loginUser(context);
                      ref.read(serverProvider.notifier).fetchTodos();
                      ref.read(statProvider.notifier).updateStats();
                    },
                    child: (isLoading)
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Login"),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: InkWell(
                onTap: () {
                  Common.navigateTo(context, RegistrationScreen());
                },
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "New user ?",
                        style: TextStyle(
                          color: Color(0xFF252525),
                          fontSize: 15,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: ' ',
                      ),
                      TextSpan(
                        text: "Register now.",
                        style: TextStyle(
                          color: Color(0xFF6C63FF),
                          fontSize: 15,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w700,
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
