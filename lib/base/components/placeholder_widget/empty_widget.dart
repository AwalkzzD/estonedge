import 'package:estonedge/base/src_components.dart';
import 'package:flutter/cupertino.dart';

import '../../src_constants.dart';
import '../../src_widgets.dart';
import '../../theme/app_theme.dart';

Widget getEmptyWidget(String? title) {
  final e = ImageView(
      height: 100.h,
      width: 100.w,
      image: AppImages.appLogo,
      imageType: ImageType.svg);

  final t = title == null
      ? Container()
      : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(title,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: styleMedium2Regular.copyWith(
                    color: themeOf().textPrimaryColor),
                textAlign: TextAlign.center),
          ),
        );

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [e, t],
  );
}
