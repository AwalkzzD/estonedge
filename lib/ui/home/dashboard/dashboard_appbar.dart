import 'package:estonedge/base/utils/widgets/common_appbar.dart';
import 'package:flutter/material.dart';

import '../../../base/src_constants.dart';

class DashboardAppbar {
  static AppBar build({
    required String title,
    required Function() onLeadingPressed,
    List<Widget>? trailing,
  }) {
    return CommonAppbar.build(
        leading: IconButton(
          icon: Image.asset(AppImages.drawerIcon),
          onPressed: onLeadingPressed,
        ),
        title: title,
        trailing: trailing);
  }
}
