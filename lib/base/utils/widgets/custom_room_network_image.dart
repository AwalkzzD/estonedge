import 'package:estonedge/base/src_constants.dart';
import 'package:flutter/material.dart';

Widget buildCustomRoomNetworkImage({
  required String imageUrl,
  bool useColorFiltered = false,
}) {
  if (useColorFiltered) {
    return ColorFiltered(
      colorFilter: const ColorFilter.mode(
        Colors.black26,
        BlendMode.darken,
      ),
      child: buildNetworkImage(imageUrl),
    );
  } else {
    return buildNetworkImage(imageUrl);
  }
}

Widget buildNetworkImage(String imageUrl) {
  return Image.network(
    filterQuality: FilterQuality.high,
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
          backgroundColor: Colors.transparent,
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
