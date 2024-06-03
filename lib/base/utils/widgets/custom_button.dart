import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btnText;

  final Function() onPressed;

  const CustomButton(
      {super.key, required this.btnText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // Rounded corners
            side: const BorderSide(
                color: Colors.transparent), // Transparent border
          ),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(
            Colors.blueAccent // Blue background color
            ),
        minimumSize: WidgetStateProperty.all<Size>(
          const Size(double.infinity, 50), // Full width
        ),
      ),
      child: Text(
        btnText,
        style: const TextStyle(
          fontFamily: 'Lexend',
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Colors.white, // Text color
        ),
      ),
    );
  }
}
