import 'package:estonedge/base/src_components.dart';
import 'package:flutter/material.dart';

import '../../constants/app_styles.dart';
import '../../theme/app_theme.dart';

class ConfirmationDialog {
  static void showAlertDialog(
    BuildContext context, {
    String title = "Alert",
    String message = "Are you sure?",
    String positiveButtonText = "Yes",
    String negativeButtonText = "No",
    Function()? onPositiveButtonClicked,
    Function()? onNegativeButtonClicked,
  }) {
    Widget cancelButton = TextButton(
      onPressed: onNegativeButtonClicked ?? () => Navigator.of(context).pop(),
      child: Text(negativeButtonText,
          style: TextStyle(
              fontSize: 13.sp,
              fontFamily: fontFamilyLexend,
              color: themeOf().appBarTextColor)),
    );
    Widget continueButton = TextButton(
      onPressed: onPositiveButtonClicked ?? () {},
      child: Text(positiveButtonText,
          style: TextStyle(
              fontSize: 13.sp,
              fontFamily: fontFamilyLexend,
              color: themeOf().appBarTextColor)),
    );

    AlertDialog alert = AlertDialog(
      title: Text(title,
          style: TextStyle(
              fontSize: 16.sp,
              fontFamily: fontFamilyLexend,
              color: themeOf().textPrimaryColor,
              fontWeight: FontWeight.w600)),
      content: Text(message,
          style: TextStyle(
              fontSize: 14.sp,
              fontFamily: fontFamilyLexend,
              color: themeOf().textPrimaryColor)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
