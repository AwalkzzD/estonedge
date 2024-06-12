import 'package:flutter/material.dart';

import '../src_constants.dart';
import '../theme/app_theme.dart';

class ButtonView extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final Color? disableColor;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;
  final double radius;
  final bool disable;
  final AlignmentGeometry alignment;
  final Widget? postfix;
  final double height;
  final double width;
  final double minWidth;
  final TextStyle? textStyle;
  final VoidCallback? isForceClick;
  final double? borderWidth;
  final Color? borderColor;

  const ButtonView(this.text, this.onPressed,
      {Key? key,
      this.color,
      this.textColor,
      this.disableColor,
      this.height = 56,
      this.width = double.infinity,
      this.minWidth = double.infinity,
      this.radius = 30,
      this.textStyle,
      this.disable = false,
      this.borderColor,
      this.borderWidth,
      this.alignment = Alignment.center,
      this.postfix,
      this.isForceClick,
      this.padding = const EdgeInsets.all(16)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: double.infinity,
      child: MaterialButton(
        elevation: 0,
        padding: padding,
        minWidth: minWidth,
        height: height,
        color: disable
            ? (disableColor ?? black.withOpacity(0.5))
            : (color ?? themeOf().accentColor),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            side: BorderSide(
                color: borderColor ?? Colors.transparent,
                width: borderWidth ?? 0.0)),
        onPressed: isForceClick ?? (disable ? () => null : onPressed),
        child: Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                  alignment: alignment,
                  child: Text(text,
                      maxLines: 1,
                      style: textStyle ??
                          TextStyle(
                              color: textColor ?? white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              fontFamily: fontFamilyPoppins))),
              postfix == null
                  ? const SizedBox()
                  : Container(
                      margin: const EdgeInsets.only(left: 12), child: postfix)
            ],
          ),
        ),
      ),
    );
  }
}
