import 'package:estonedge/base/constants/app_styles.dart';
import 'package:flutter/material.dart';

Widget buildCustomRoomNetworkImage({required String imageUrl}) {
  return Image.network(
    imageUrl,
    fit: BoxFit.fill,
    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red),
          Text("Can't load image",
              overflow: TextOverflow.ellipsis, style: fs12BlackRegular)
        ],
      );
    },
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) return child;
      return Center(
        child: CircularProgressIndicator(
          color: Colors.blueAccent,
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
              : null,
        ),
      );
    },
  );
}
