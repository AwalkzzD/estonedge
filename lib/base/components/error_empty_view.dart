// ignore_for_file: library_private_types_in_public_api

import 'package:estonedge/base/components/screen_utils/flutter_screenutil.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: Colors.blueAccent,
        elevation: 1,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.w)),
      ),
      onPressed: onRetry,
      child: Padding(
        padding:
            EdgeInsetsDirectional.symmetric(vertical: 12.w, horizontal: 32.w),
        child: const Text(
          'Retry',
          maxLines: 1,
          style: TextStyle(color: Colors.white),
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
    return Container(
      padding: EdgeInsetsDirectional.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget button() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        elevation: 1,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.w)),
      ),
      onPressed: onRetry,
      child: Padding(
        padding:
            EdgeInsetsDirectional.symmetric(vertical: 12.w, horizontal: 32.w),
        child: const Text(
          'Retry',
          maxLines: 1,
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
