import 'package:estonedge/base/constants/app_images.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            children: [
              Image.asset(AppImages.appLogo),
              const SizedBox(width: 12),
              const Text(
                'EstonEdge',
                style: TextStyle(
                    fontSize: 34,
                    fontFamily: 'RubikMedium-DRPE',
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
