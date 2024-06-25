import 'package:flutter/material.dart';
import '../../constants/app_styles.dart';

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
      child: Text(negativeButtonText, style: fs13White),
    );
    Widget continueButton = TextButton(
      onPressed: onPositiveButtonClicked ?? () {},
      child: Text(positiveButtonText, style: fs13White),
    );

    AlertDialog alert = AlertDialog(
      title: Text(title, style: fs16BlueSemiBold),
      content: Text(message, style: fs14BlueRegular),
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
