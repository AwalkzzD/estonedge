import 'package:another_flushbar/flushbar.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../src_constants.dart';

/// to get main navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// to get all app context
final BuildContext globalContext = navigatorKey.currentState!.context;

/// base image asset
imageAsset(context, path, {width, height, color, fit = BoxFit.contain}) =>
    Image.asset("assets/images/$path",
        width: width, height: height, color: color, fit: fit);

/// base image asset
assetImage(context, path) => AssetImage('assets/images/$path');

/// hide keyboard
hideKeyboard(BuildContext context) =>
    FocusScope.of(context).requestFocus(FocusNode());

/// show const back arrow
backArrow(context, {onTap, arrowColor = black, path = 'left_arrow'}) {
  return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Center(
              child: imageAsset(context, path,
                  height: 20.0, width: 20.0, color: arrowColor ?? black))));
}

showMessageBar(String message) {
  Flushbar(
    flushbarPosition: FlushbarPosition.BOTTOM,
    flushbarStyle: FlushbarStyle.GROUNDED,
    isDismissible: true,
    duration: const Duration(seconds: 3),
    messageText: Text(
      message,
      maxLines: 3,
      style: fs14WhiteRegular.copyWith(color: white),
    ),
  ).show(globalContext);
}

showMessageBarFloating(String message) {
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    isDismissible: true,
    duration: const Duration(seconds: 3),
    messageText: Text(
      message,
      maxLines: 3,
      style: fs14WhiteRegular.copyWith(color: white),
    ),
  ).show(globalContext);
}

void showCustomDialog({
  bool isBarrierDismissable = true,
  required BuildContext context,
  required List<Widget> children,
  required String buttonText,
  Color buttonColor = Colors.blueAccent,
  required Function() onButtonPress,
}) {
  showDialog<String>(
    barrierDismissible: isBarrierDismissable,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
      actions: <Widget>[
        CustomButton(
            btnText: buttonText,
            width: MediaQuery.of(context).size.width,
            color: buttonColor,
            onPressed: () {
              Navigator.pop(context);
              onButtonPress();
            })
      ],
    ),
  );
}
