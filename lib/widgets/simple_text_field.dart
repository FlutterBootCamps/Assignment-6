import 'package:assignment_6/utils/colors.dart';
import 'package:flutter/material.dart';

class SimpleTextField extends StatelessWidget {
  const SimpleTextField({
    super.key, required this.labelText, required this.hintText, this.controller, this.textStyle, this.fillColor = whiteColor, this.hintLabelColor, this.isObscured = false,
  });

  final String labelText;
  final String hintText;
  final TextStyle? textStyle;
  final Color? fillColor;
  final TextEditingController? controller;
  final Color? hintLabelColor;
  final bool? isObscured;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscured!,
      controller: controller,
      style: textStyle,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(color: hintLabelColor),
        hintStyle: TextStyle(color: hintLabelColor),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          borderSide: BorderSide.none
        ),
        filled: true,
        fillColor: fillColor,
      ),
    );
  }
}