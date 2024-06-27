import 'package:cached_network_image/cached_network_image.dart';
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
  return CachedNetworkImage(
    filterQuality: FilterQuality.high,
    fit: BoxFit.fill,
    errorWidget: (context, err, stackTrace) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, color: Colors.red),
          Text("Can't load image",
              overflow: TextOverflow.ellipsis, style: fs12BlackRegular)
        ],
      );
    },
    progressIndicatorBuilder: (context, url, progress) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          color: Colors.blueAccent,
          value: progress.progress,
        ),
      );
    },
    imageUrl: imageUrl,
  );
}
