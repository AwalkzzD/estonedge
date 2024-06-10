import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final bool isPassword;
  final TextEditingController? controller;

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.icon,
      required this.isPassword,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.black,
      keyboardType: TextInputType.emailAddress,
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        prefixIcon: icon,
        prefixIconColor: Colors.black,
        border: OutlineInputBorder(
          borderSide: BorderSide.none, // No border
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
        ),
        hintText: hintText,
      ),
    );
  }
}
