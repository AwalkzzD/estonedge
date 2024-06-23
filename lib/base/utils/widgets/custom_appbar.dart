import 'package:estonedge/base/src_constants.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final String appBarTrailingImage;
  final Function()? trailingIconAction;
  final bool centerTitle;
  final TextStyle titleStyle;

  const CustomAppbar(BuildContext context,
      {super.key,
      required this.title,
      this.appBarTrailingImage = AppImages.appBarPlusIcon,
      this.centerTitle = false,
      this.titleStyle = fs32BlackBold,
      this.trailingIconAction});

  @override
  Widget build(BuildContext context) {
    /// Row widget to create a custom appbar
    return Padding(
      padding: const EdgeInsets.only(
        right: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              textAlign: (centerTitle) ? TextAlign.center : TextAlign.start,
              title,
              overflow: TextOverflow.ellipsis,
              style: titleStyle,
            ),
          ),
          InkWell(
              onTap: trailingIconAction,
              child: Image.asset(appBarTrailingImage)),
        ],
      ),
    );
  }
}
