// ignore_for_file: use_build_context_synchronously

import 'package:clifftest/functions/authfunction.dart';
import 'package:clifftest/homepage.dart';
import 'package:clifftest/registerpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          TextFormField(
            controller:
                emailController, //  <=======ASSIGN THE CONTROLLER THE TEXTFORMFIELD TO GET THE VALUE WHEN THE USER TYPES
            decoration: const InputDecoration(hintText: 'Enter email address'),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller:
                passwordController, // <=======ASSIGN THE CONTROLLER THE TEXTFORMFIELD TO GET THE VALUE WHEN THE USER TYPES ,
            decoration: const InputDecoration(hintText: 'Enter password'),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () => handleUserAuthentication(),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(16)),
              child: const Center(
                child: Text(
                  'Login Now',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Dont have an accont?'),
              const SizedBox(
                width: 3,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => const RegisterPage())),
                child: Text(
                  'Register here',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> handleUserAuthentication() async {
    if (emailController.text.isEmpty) {
      return EasyLoading.showInfo('Email field cannot be empty');
    }
    if (passwordController.text.isEmpty) {
      return EasyLoading.showInfo('Password field cannot be empty');
    }
    final isloggedIn = await authController.loginUser(
        emailController.text, passwordController.text);
    EasyLoading.show(status: 'Authenticatiing....');
    if (isloggedIn) {
      EasyLoading.dismiss();
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => const HomePage()));
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('Authentication Failed');
    }
  }
}
