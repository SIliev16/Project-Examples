import 'package:flutter/material.dart';

import '../login_page.dart';
import '../register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool isLoginPage = true;

  void togglePage() {
    setState(() {
      isLoginPage = !isLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if  (isLoginPage) {
    return LoginPage(onTap: togglePage);
  }else {
    return RegisterPage(onTap: togglePage);
  }
  }
}