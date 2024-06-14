import 'package:flutter/cupertino.dart';

Widget getEmptyWidget(String? title) {
  return const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [Text('Empty')],
  );
}
