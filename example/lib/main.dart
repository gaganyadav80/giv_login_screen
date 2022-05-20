import 'package:flutter/material.dart';
import 'package:giv_login_screen/giv_login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GivLoginScreen(
      onLoginButtonPressed: (_, __) {
        print("EMAIL $_, PASSWORD $__");
        print("SIGN IN TAPPED");
      },
      onSignupButtonPressed: (_, __, ___) {
        print("EMAIL $_, PASSWORD $__");
        print("SIGN UP TAPPED");
      },
    );
  }
}
