import 'package:flutter/material.dart';

import 'no_account_text.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: loginAppBar(),
      body: loginBody(),
    );
  }

  SafeArea loginBody() {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(
                height: 30,
              ),
              Text(
                "Hello",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Login With Your Email ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 100),
              LoginForm(),
              SizedBox(
                height: 20,
              ),
              NoAccountText(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar loginAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text("Login Page"),
    );
  }
}
