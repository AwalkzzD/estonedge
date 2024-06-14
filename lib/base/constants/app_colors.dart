import 'dart:math';

import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF7F1417);
const Color white = Colors.white;
const Color black = Colors.black;
const Color disableBgColor = Color(0xFF08263A);
const Color gray75Color = Color(0xFF526775);
const Color buttonGradientBgColor = Color(0xFFBC7072);
const Color buttonInnerBgColor = Color(0xFFF3E3E3);

const Color bulletBorderColor = Color(0xFFF2E7E7);
const Color borderB0Color = Color(0xFFD3AFB0);
const Color border26B = Color(0x26BC212C);

const Color green = Color(0xFF51BB76);
const Color red = Color(0xFF7F1417);
const Color blueSignature = Color(0xFF0000FF);

const Color subPrimaryColor = Color(0x1F7F1417);
const Color subSecondaryColor = Color(0x1FBC212C);
const Color borderUnSelectedColor = Color(0x297F1417);

Color hintTextColor = const Color(0xFF08263A).withOpacity(0.5);

const Color borderDAColor = Color(0xFFEAD9DA);
const Color lineChartColor = Color(0xFFFEBB08);
const Color columnChartColor = Color(0xFF1F78B4);
const Color gray5AColor = Color(0xFF5A5A5A);
Color underLineColor = const Color(0x52200A4D).withOpacity(0.16);

List<Color> backgroundColors = const [
  Color(0xFFFFF6DF),
  Color(0xFFEDECEB),
  Color(0xFFF9EDEC),
  Color(0xFFEEEEF9),
  Color(0xFFF7F1EB),
  Color(0xFFE9F4F2),
  Color(0xFFE4EEEF),
  Color(0xFFEEECF2),
  Color(0xFFF5EFF5),
  Color(0xFFF3F6EC),
];

List<Color> borderColors = const [
  Color(0xFFFEBB08),
  Color(0xFF514836),
  Color(0xFFC05248),
  Color(0xFF2121B2),
  Color(0xFFD5B191),
  Color(0xFF4DA896),
  Color(0xFF0B666B),
  Color(0xFFC44F49),
  Color(0xFF60518A),
  Color(0xFF924B91),
  Color(0xFF8FA951),
  Color(0xFF1F78B4),
  Color(0xFF299EB0),
];

Color fromHex(String? hexString) {
  if(hexString != null && hexString.isNotEmpty){
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }else{
    return borderColors[Random().nextInt(borderColors.length)];
  }
}