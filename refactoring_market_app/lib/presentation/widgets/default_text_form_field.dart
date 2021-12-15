import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({
    Key? key,
    required this.textFieldLabel,
    required this.hintTextField,
    required this.prefixIcon,
    required this.keyboardTybe,
    required this.obsecureText,
    required this.validator,
    this.controller,
    this.suffixIcon,
    this.onChange,
    this.minLines,
    this.maxLines,
  }) : super(key: key);
  final TextEditingController? controller;
  final TextInputType keyboardTybe;
  final bool obsecureText;
  final String textFieldLabel;
  final String hintTextField;
  final Widget? suffixIcon;
  final Widget prefixIcon;
  final String Function(String?) validator;
  final void Function(String?)? onChange;
  final int? minLines;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardTybe,
      obscureText: obsecureText,
      validator: validator,
      onChanged: onChange,
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          gapPadding: 10,
          borderSide: const BorderSide(color: Colors.cyan),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          gapPadding: 10,
        ),
        labelText: textFieldLabel,
        hintText: hintTextField,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          gapPadding: 10,
        ),
      ),
    );
  }
}
