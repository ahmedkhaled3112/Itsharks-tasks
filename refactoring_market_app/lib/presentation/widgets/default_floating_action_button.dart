import 'package:flutter/material.dart';

class DefaultFloatingActionButton extends StatelessWidget {
  const DefaultFloatingActionButton({
    Key? key,
    required this.onPressed,
    required this.widget,
  }) : super(key: key);

  final void Function()? onPressed;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: widget,
    );
  }
}
