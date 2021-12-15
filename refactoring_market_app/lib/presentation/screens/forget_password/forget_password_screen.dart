import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);
  static const String routeName = "/forgot_password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: forgetPasswordAppBar(),
    );
  }

  AppBar forgetPasswordAppBar() {
    return AppBar(
      title:const Text("نسيت كلمة المرور"),
      centerTitle: true,
    );
  }
}
