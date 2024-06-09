import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final String appBarImage;
  const CustomAppbar(BuildContext context,
      {super.key, required this.title, required this.appBarImage});

  @override
  Widget build(BuildContext context) {
    return buildCustomAppBar(context, title, appBarImage);
  }

  Widget buildCustomAppBar(BuildContext context, String title, String img) {
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
          Image.asset(img),
        ],
      ),
    );
  }
}
