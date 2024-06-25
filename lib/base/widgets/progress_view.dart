import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ProgressView extends StatelessWidget {
  final Color? color;
  final double? size;

  const ProgressView({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    if (size != null) {
      return SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: color ?? (themeOf().accentColor),
        ),
      );
    } else {
      return CircularProgressIndicator(
        color: color ?? (themeOf().accentColor),
      );
    }
  }
}
