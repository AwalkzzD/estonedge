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
      required this.errorText,
      this.onChanged});

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

class CustomTextfieldWiFi extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  const CustomTextfieldWiFi(
      {super.key,
      required this.labelText,
      required this.hintText,
      this.controller,
      this.onChanged,
      this.errorText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: const TextStyle(fontFamily: 'Lexend'),
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Colors.blue), // Set the border color to blue
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Colors.blue
                    .shade300), // Set the border color to blue when focused
          ),
          labelText: labelText,
          labelStyle: const TextStyle(
              fontFamily:
                  'Lexend'), // Set label color to black when inside TextField
          floatingLabelStyle: TextStyle(
              color: Colors.blue.shade300,
              fontFamily: 'Lexend'), // Set label color to blue when floating
          floatingLabelBehavior:
              FloatingLabelBehavior.auto, // Automatically float the label
          hintText: hintText,
          errorText: errorText),
    );
  }
}
