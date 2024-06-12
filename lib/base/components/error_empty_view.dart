import 'package:estonedge/base/src_components.dart';
import 'package:flutter/material.dart';

import '../src_constants.dart';
import '../src_widgets.dart';
import '../theme/app_theme.dart';

enum _QuickViewType { error, empty }

/// A [QuickView] widget that provides out-of-the-box implementation
/// for quick and simple use cases.
class QuickView extends StatelessWidget {
  final _QuickViewType? type;
  final String? title;
  final Function()? onRetry;
  final Color? textColor;
  final double? textSize;

  const QuickView._(
      {this.type, this.title, this.onRetry, this.textColor, this.textSize});

  factory QuickView.error(
      {String? title,
      Function()? onRetry,
      String? retryText,
      Color? textColor,
      double? textSize}) {
    return QuickView._(
      type: _QuickViewType.error,
      title: title,
      onRetry: onRetry,
      textColor: textColor,
      textSize: textSize,
    );
  }

  factory QuickView.empty({String? title, Color? textColor, double? textSize}) {
    return QuickView._(
      type: _QuickViewType.empty,
      title: title,
      textColor: textColor,
      textSize: textSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    final e = (type == _QuickViewType.empty)
        ? ImageView(
            height: 100.h,
            width: 100.w,
            image: AppImages.appLogo,
            color: themeOf().iconColor,
            imageType: ImageType.svg)
        : Container();

    final t = title == null
        ? Container()
        : Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.w, 12.h, 12.w, 12.h),
            child: Center(
              child: Text(title!,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: styleMedium2Regular.copyWith(color: textColor),
                  textAlign: TextAlign.center),
            ),
          );

    final r = onRetry == null ? Container() : button();

    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsetsDirectional.all(16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    e,
                    t,
                    SizedBox(height: 8.h),
                    r,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget button() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: themeOf().accentColor,
        shadowColor: themeOf().accentColor,
        elevation: 1,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.w)),
      ),
      onPressed: onRetry,
      child: Padding(
        padding:
            EdgeInsetsDirectional.symmetric(vertical: 12.w, horizontal: 32.w),
        child: Text(
          "Retry",
          maxLines: 1,
          style: styleMedium1.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class QuickCustomView extends StatelessWidget {
  final _QuickViewType? type;
  final String? title;
  final Function()? onRetry;
  final Color? textColor;
  final double? textSize;

  const QuickCustomView._(
      {this.type, this.title, this.onRetry, this.textColor, this.textSize});

  factory QuickCustomView.error(
      {String? title,
      Function()? onRetry,
      String? retryText,
      Color? textColor,
      double? textSize}) {
    return QuickCustomView._(
      type: _QuickViewType.error,
      title: title,
      onRetry: onRetry,
      textColor: textColor,
      textSize: textSize,
    );
  }

  factory QuickCustomView.empty(
      {String? title, Color? textColor, double? textSize}) {
    return QuickCustomView._(
      type: _QuickViewType.empty,
      title: title,
      textColor: textColor,
      textSize: textSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = title == null
        ? Container()
        : Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.w, 0, 12.w, 12.h),
            child: Center(
              child: Text(title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: textSize ?? 18.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: fontFamilyPoppins,
                      color: textColor),
                  textAlign: TextAlign.center),
            ),
          );
    final r = onRetry == null ? Container() : button();

    return Container(
      padding: EdgeInsetsDirectional.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          t,
          SizedBox(height: 8.h),
          r,
        ],
      ),
    );
  }

  Widget button() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: themeOf().accentColor,
        shadowColor: themeOf().accentColor,
        elevation: 1,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.w)),
      ),
      onPressed: onRetry,
      child: Padding(
        padding:
            EdgeInsetsDirectional.symmetric(vertical: 12.w, horizontal: 32.w),
        child: Text(
          "Retry",
          maxLines: 1,
          style: styleMedium1.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class PlaceHolderView {
  final String? title;
  final Function()? onRetry;

  PlaceHolderView({this.title = "", this.onRetry});
}
