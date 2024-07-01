import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/constants/app_styles.dart';
import 'package:estonedge/base/widgets/image_view.dart';
import 'package:flutter/material.dart';

class CustomAuthAppBar extends StatelessWidget {
  const CustomAuthAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            children: [
              ImageView(  
                image: AppImages.appLogo,
                imageType: ImageType.svg,
              ),
              SizedBox(width: 12),
              Text(
                'EstonEdge',
                style: fs34BlackRegular,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
