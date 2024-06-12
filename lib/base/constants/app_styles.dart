import 'package:estonedge/base/src_components.dart';
import 'package:flutter/material.dart';

import '../src_constants.dart';
import '../theme/app_theme.dart';

const String fontFamilyPoppins = "Poppins";
const String sf_pro_text_bold = "sf_pro_text_bold";

double fSmall1 = 8.sp;
double fSmall2 = 10.sp;
double fSmall3 = 12.sp;
double fSmall13 = 13.sp;
double fSmall4 = 14.sp;

double fMedium1 = 16.sp;
double fMedium2 = 18.sp;
double fMedium3 = 20.sp;
double fMedium4 = 22.sp;

double fLarge1 = 24.sp;
double fLarge2 = 26.sp;
double fLarge3 = 28.sp;
double fLarge4 = 30.sp;
double fLarge5 = 32.sp;
double fLarge6 = 34.sp;
double fLarge7 = 36.sp;
double fLarge8 = 38.sp;

/// Small
TextStyle styleSmall1 =
    TextStyle(fontSize: fSmall1, color: black, fontFamily: fontFamilyPoppins);

TextStyle styleSmall1Regular = TextStyle(
    fontSize: fSmall1,
    color: black,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.normal);

TextStyle styleSmall1Bold = TextStyle(
    fontSize: fSmall1,
    color: black,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.bold);

TextStyle styleSmall2 =
    TextStyle(fontSize: fSmall2, color: black, fontFamily: fontFamilyPoppins);

TextStyle styleSmall2MediumWhite = TextStyle(
    fontSize: fSmall2,
    color: Colors.white,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.w500);

TextStyle styleSmall2Normal = TextStyle(
    fontSize: fSmall2,
    color: themeOf().textPrimaryColor,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.normal);

TextStyle styleSmall2NormalItalic = TextStyle(
    fontSize: fSmall2,
    color: themeOf().textPrimaryColor,
    fontFamily: fontFamilyPoppins,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.normal);

TextStyle styleSmall2Medium = TextStyle(
    fontSize: fSmall2,
    color: themeOf().textPrimaryColor,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.w500);

TextStyle styleSmall2Bold = TextStyle(
    fontSize: fSmall2,
    color: black,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.bold);

TextStyle styleSmall2SemiBold = TextStyle(
    fontSize: fSmall2,
    color: themeOf().accentColor,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.w600);

TextStyle styleSmall3 =
    TextStyle(fontSize: fSmall3, color: black, fontFamily: fontFamilyPoppins);

TextStyle styleSmall = TextStyle(
    fontSize: fSmall3,
    color: themeOf().textPrimaryColor,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.normal);

TextStyle styleSmallDarkBlueMedium = TextStyle(
    fontSize: fSmall3,
    color: themeOf().textPrimaryColor,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.w500);

TextStyle styleSmall3MediumGray = TextStyle(
    fontSize: fSmall3,
    color: gray75Color,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.w500);

TextStyle styleSmall3Medium = TextStyle(
    fontSize: fSmall3,
    color: themeOf().textPrimaryColor,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.w500);

TextStyle styleSmall3MediumWhite = TextStyle(
    fontSize: fSmall3,
    color: Colors.white,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.w500);

TextStyle styleSmall3SemiBold = TextStyle(
    fontSize: fSmall3,
    color: black,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.w600);

TextStyle styleSmall3Bold = TextStyle(
    fontSize: fSmall3,
    color: black,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.bold);

TextStyle styleSmall13Medium = TextStyle(
    fontSize: fSmall13,
    color: themeOf().textPrimaryColor,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.w500);

TextStyle styleSmall13MediumWhite = TextStyle(
    fontSize: fSmall13,
    color: Colors.white,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.w500);

TextStyle styleSmall4 =
    TextStyle(fontSize: fSmall4, color: black, fontFamily: fontFamilyPoppins);

TextStyle styleSmall4Medium = TextStyle(
    fontSize: fSmall4,
    color: black,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.w500);

TextStyle dateCalendarStyleWhite = TextStyle(
    fontSize: fSmall4, color: Colors.white, fontFamily: fontFamilyPoppins);

TextStyle dateCalendarStylePrimary = TextStyle(
    fontSize: fSmall4,
    color: themeOf().accentColor,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.w500);

TextStyle styleSmall4SemiBold = TextStyle(
    fontSize: fSmall4,
    color: themeOf().accentColor,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.w600);

TextStyle styleSmall4Regular = TextStyle(
    fontSize: fSmall4,
    color: Colors.white,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.normal);

TextStyle styleSmall4RegularDarkBlue = TextStyle(
    fontSize: fSmall4,
    color: themeOf().textPrimaryColor,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.normal);

TextStyle styleSmall4Bold = TextStyle(
    fontSize: fSmall4,
    color: black,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.bold);

/// Medium
TextStyle styleMedium1 =
    TextStyle(fontSize: fMedium1, color: black, fontFamily: fontFamilyPoppins);

TextStyle calendarDateStyle = TextStyle(
    fontSize: fMedium1,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.w500);

TextStyle styleMedium1SemiBold = TextStyle(
    fontSize: fMedium1,
    color: themeOf().accentColor,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.w600);

TextStyle styleMediumRegular = TextStyle(
    fontSize: fMedium1,
    color: white,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.normal);

TextStyle fMedium1NormalTextColor = TextStyle(
    fontSize: fMedium1,
    color: themeOf().textPrimaryColor,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.normal);

TextStyle styleMediumMedium = TextStyle(
    fontSize: fMedium1,
    color: themeOf().accentColor,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.w500);

TextStyle styleMedium1Bold = TextStyle(
    fontSize: fMedium1,
    color: black,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.bold);

TextStyle styleBoldSfProBold = TextStyle(
    fontSize: 17.sp,
    color: black,
    fontFamily: sf_pro_text_bold,
    fontWeight: FontWeight.bold);

TextStyle styleMedium2 =
    TextStyle(fontSize: fMedium2, color: black, fontFamily: fontFamilyPoppins);

TextStyle styleMedium2Regular = TextStyle(
    fontSize: fMedium2,
    color: Colors.white,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.normal);

TextStyle styleMedium2RegularGray = TextStyle(
    fontSize: fMedium2,
    color: gray75Color,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.normal);

TextStyle styleMedium2Bold = TextStyle(
    fontSize: fMedium2,
    color: black,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.bold);

TextStyle styleMedium3 =
    TextStyle(fontSize: fMedium3, color: black, fontFamily: fontFamilyPoppins);

TextStyle styleMedium3Bold = TextStyle(
    fontSize: fMedium3,
    color: black,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.bold);

TextStyle styleMedium4 =
    TextStyle(fontSize: fMedium4, color: black, fontFamily: fontFamilyPoppins);

TextStyle styleMedium4Bold = TextStyle(
    fontSize: fMedium4,
    color: black,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.bold);

/// Large
TextStyle styleLarge1 =
    TextStyle(fontSize: fLarge1, color: black, fontFamily: fontFamilyPoppins);

TextStyle styleLarge1Bold = TextStyle(
    fontSize: fLarge1,
    color: black,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.bold);

TextStyle styleLarge2 =
    TextStyle(fontSize: fLarge2, color: black, fontFamily: fontFamilyPoppins);

TextStyle styleLarge2Bold = TextStyle(
    fontSize: fLarge2,
    color: black,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.bold);

TextStyle styleLarge3 =
    TextStyle(fontSize: fLarge3, color: black, fontFamily: fontFamilyPoppins);

TextStyle styleLarge3Bold = TextStyle(
    fontSize: fLarge3,
    color: black,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.bold);

TextStyle styleLarge4 =
    TextStyle(fontSize: fLarge4, color: black, fontFamily: fontFamilyPoppins);

TextStyle styleLarge4Bold = TextStyle(
    fontSize: fLarge4,
    color: black,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.bold);

TextStyle styleLarge5 =
    TextStyle(fontSize: fLarge5, color: black, fontFamily: fontFamilyPoppins);

TextStyle styleLarge5Bold = TextStyle(
    fontSize: fLarge5,
    color: black,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.bold);

TextStyle styleLarge6 =
    TextStyle(fontSize: fLarge6, color: black, fontFamily: fontFamilyPoppins);

TextStyle styleLarge6Bold = TextStyle(
    fontSize: fLarge6,
    color: black,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.bold);

TextStyle styleLarge7 =
    TextStyle(fontSize: fLarge7, color: black, fontFamily: fontFamilyPoppins);

TextStyle styleLarge7Bold = TextStyle(
    fontSize: fLarge7,
    color: black,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.bold);

TextStyle styleLarge8 =
    TextStyle(fontSize: fLarge8, color: black, fontFamily: fontFamilyPoppins);

TextStyle styleLarge8Bold = TextStyle(
    fontSize: fLarge8,
    color: black,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.bold);

TextStyle scheduleWeekStyle = TextStyle(
    fontSize: fSmall2,
    color: Colors.white,
    fontFamily: fontFamilyPoppins,
    fontWeight: FontWeight.w500);
