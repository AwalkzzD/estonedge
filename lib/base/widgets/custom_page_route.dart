import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({required super.builder, super.settings});
}

class CustomCupertinoPageRoute<T> extends CupertinoPageRoute<T> {
  CustomCupertinoPageRoute({required super.builder, super.settings});

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.linear, // Adjust the curve for linear animation
        ),
      ),
      child: child,
    );
  }
}
