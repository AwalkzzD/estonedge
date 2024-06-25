import 'package:flutter/material.dart';

class IconBackgroundView extends StatelessWidget {
  final Widget? icon;
  final double? radius;
  final Function? onPressed;
  final Color? color;

  const IconBackgroundView({super.key, this.icon, this.radius, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: SizedBox(
            width: radius ?? 80.0,
            height: radius ?? 80.0,
            child: Material(
              color: color,
              child: InkWell(
                onTap: onPressed as void Function()?,
                child: icon,
              ),
            ),
          ),
        )
    );
  }
}