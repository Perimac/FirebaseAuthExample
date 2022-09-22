import 'package:clifftest/functions/authfunction.dart';
import 'package:clifftest/homepage.dart';
import 'package:clifftest/loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 0,
          title: Text('Register'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration:
                    const InputDecoration(hintText: 'Enter Fullname here'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration:
                    const InputDecoration(hintText: 'Enter email address'),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(hintText: 'Enter password'),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => handleAccountCreation(),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(16)),
                  child: const Center(
                    child: Text(
                      'Create Account',
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
                  const Text('Already have an accont?'),
                  const SizedBox(
                    width: 3,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      'Login here',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Future<void> handleAccountCreation() async {
    if (nameController.text.isEmpty) {
      return EasyLoading.showInfo('Email field cannot be empty');
    }
    if (emailController.text.isEmpty) {
      return EasyLoading.showInfo('Email field cannot be empty');
    }
    if (passwordController.text.isEmpty) {
      return EasyLoading.showInfo('Password field cannot be empty');
    }
    final isloggedIn = await authController.registerUser(
        emailController.text, passwordController.text);
    EasyLoading.show(status: 'Authenticatiing....');
    if (isloggedIn) {
      EasyLoading.dismiss();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => const HomePage()));
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('Authentication Failed');
    }
  }
}
