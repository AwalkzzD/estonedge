import 'package:flutter/material.dart';

import '../../constants/app_styles.dart';

// class CustomButton extends StatelessWidget {
//   final String btnText;
//   final double width;
//   final Color color;
//   final Function() onPressed;

//   const CustomButton({
//     super.key,
//     required this.btnText,
//     required this.onPressed,
//     required this.width,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: onPressed,
//       style: ButtonStyle(
//         shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0), // Rounded corners
//             side: BorderSide(
//               color: Colors.transparent, // Transparent border
//             ),
//           ),
//         ),
//         backgroundColor: WidgetStateProperty.all<Color>(
//           color, // Use the passed color
//         ),
//         minimumSize: WidgetStateProperty.all<Size>(
//           Size(width, 50), // Full width
//         ),
//       ),
//       child: Text(
//         btnText,
//         style: const TextStyle(
//           fontFamily: 'Lexend',
//           fontWeight: FontWeight.w600,
//           fontSize: 14,
//           color: Colors.white, // Text color
//         ),
//       ),
//     );
//   }

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

//}
