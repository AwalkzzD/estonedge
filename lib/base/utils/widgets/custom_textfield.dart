import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final bool isPassword;
  final String? errorText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged; 

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.icon,
      required this.isPassword,
      this.controller,
      required this.errorText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.black,
      keyboardType: TextInputType.emailAddress,
      obscureText: isPassword,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        errorText: errorText,
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
