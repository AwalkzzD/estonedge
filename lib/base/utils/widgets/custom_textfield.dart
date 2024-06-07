import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final bool isPassword;
  const CustomTextField({super.key, required this.hintText, required this.icon, required this.isPassword});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.black,
      keyboardType: TextInputType.emailAddress,
      obscureText: isPassword,
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
