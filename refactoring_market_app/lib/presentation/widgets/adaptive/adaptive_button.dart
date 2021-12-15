import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../constants.dart';

class AdaptiveButton extends StatelessWidget {
  const AdaptiveButton({
    Key? key,
    required this.textButton,
    required this.onPressed,
  }) : super(key: key);

  final String textButton;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    if (getOS() == "android") {
      return ElevatedButton(
        onPressed: onPressed,
        child: Text(textButton),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      );
    } else {
      return CupertinoButton(
        onPressed: onPressed,
        child: Text(textButton),
      );
    }
  }
}
