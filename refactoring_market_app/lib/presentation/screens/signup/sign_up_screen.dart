import 'package:flutter/material.dart';

import 'sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const String routeName = "/sign_up";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: signupAppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Create New Account",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Please Enter your Information Correctly",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 30,
                ),
                const SignUpForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar signupAppBar() {
    return AppBar(
      title: const Text("Create New Account"),
    );
  }
}
