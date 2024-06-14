import 'package:flutter/material.dart';

import '../src_constants.dart';

class AppBarView extends StatelessWidget implements PreferredSize {
  final Color? color;
  final Widget? title;
  final bool? centerTitle;
  final double? elevation;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final List<Widget>? actionItems;
  final Size? height;
  final Widget? leading;
  final bool? automaticallyImplyLeading;
  final Widget? bottomLineWidget;
  final double? leadingWidth;

  AppBarView(
      {Key? key,
      this.color = white,
      this.title,
      this.centerTitle,
      this.elevation = 0.0,
      this.leadingWidth = 56,
      this.scaffoldKey,
      this.actionItems,
      this.height,
      this.leading,
      this.automaticallyImplyLeading,
      this.bottomLineWidget})
      : preferredSize = const Size.fromHeight(60),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget get child => Container();

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: height ?? preferredSize,
        child: SafeArea(
            child: AppBar(
          backgroundColor: color,
          leadingWidth: leadingWidth,
          automaticallyImplyLeading: automaticallyImplyLeading ?? false,
          titleSpacing: 0.0,
          centerTitle: centerTitle ?? true,
          leading: leading,
          title: title,
          actions: actionItems,
        )));
  }
}
