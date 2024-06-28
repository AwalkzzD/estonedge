import 'package:estonedge/base/src_constants.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? appBarTrailingImage;
  final Function()? trailingIconAction;
  final bool centerTitle;
  final TextStyle titleStyle;
  final double? trailingIconWidth;
  final double? trailingIconHeight;

  const CustomAppbar(
    BuildContext context, {
    super.key,
    required this.title,
    this.appBarTrailingImage,
    this.centerTitle = false,
    this.titleStyle = fs24BlackBold,
    this.trailingIconAction,
    this.trailingIconWidth = 30,
    this.trailingIconHeight = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              textAlign: (centerTitle) ? TextAlign.center : TextAlign.start,
              title,
              overflow: TextOverflow.ellipsis,
              style: fs24BlackBold,
            ),
          ),
          InkWell(
            onTap: trailingIconAction,
            child: (appBarTrailingImage != null)
                ? Image.asset(
                    appBarTrailingImage!,
                    width: trailingIconWidth,
                    height: trailingIconHeight,
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
