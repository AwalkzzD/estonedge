import 'package:estonedge/base/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CommonAppbar {
  static AppBar build({
    Widget? leading,
    required String title,
    List<Widget>? trailing,
  }) {
    return AppBar(
      leading: Builder(
        builder: (context) {
          return leading ?? const SizedBox();
        },
      ),
      title: Builder(builder: (context) {
        return SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                  top: 10,
                ),
                child: Wrap(
                  children: [
                    Text(
                      title,
                      style: fs32BlackBold,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      }),
      actions: trailing,
    );
  }
}
