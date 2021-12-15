import 'package:flutter/material.dart';

import '../signup/sign_up_screen.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: const Text(
            "Create Account",
            style: TextStyle(
              fontSize: 15,
              decoration: TextDecoration.underline,
              color: Colors.cyan,
            ),
          ),
        ),
      ],
    );
  }
}
