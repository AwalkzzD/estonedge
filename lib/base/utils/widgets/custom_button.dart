import 'package:flutter/material.dart';

import '../../constants/app_styles.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  final double width;
  final Color color;
  final Function() onPressed;

  const CustomButton({
    super.key,
    required this.btnText,
    this.width = double.infinity,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
        side: BorderSide(color: color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Less rounded border
        ),
        minimumSize: Size(width, 40), // More width
      ),
      child: Text(btnText, style: fs14WhiteMedium),
    );
  }
}
