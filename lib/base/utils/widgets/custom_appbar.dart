import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final String? appBarImage;
  final Function()? trailingIconAction;

  const CustomAppbar(BuildContext context,
      {super.key,
      required this.title,
      this.appBarImage,
      this.trailingIconAction});

  @override
  Widget build(BuildContext context) {
    /// Row widget to create a custom appbar
    return Padding(
      padding: const EdgeInsets.only(
        right: 10,
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 32,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          (appBarImage != null)
              ? InkWell(
            onTap: trailingIconAction,
            child: Image.asset(appBarImage!),
          )
              : const SizedBox(),
        ],
      ),
    );
  }

}