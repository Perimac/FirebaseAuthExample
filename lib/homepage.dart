// ignore_for_file: use_build_context_synchronously
import 'package:clifftest/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mAuth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home Page'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'User ID is',
            ),
            const SizedBox(height: 16),
            Text(mAuth.currentUser!.uid),
            TextButton(
                onPressed: () async {
                  await mAuth.signOut();
                  Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: const Text(
                  'SIGN OUT',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w800,
                      fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
