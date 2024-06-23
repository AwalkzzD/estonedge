import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_theme.dart';

enum ImageType { asset, file, svg, networkSvg, base64 }

enum ImageShape { circle, rectangle, oval, none }

class ImageView extends StatelessWidget {
  /// image type is for provide different image loader with enum type
  /// it provide image changes as asset, file, network, or cached
  final ImageType imageType;

  /// image shape is for define the shape around the image
  /// as provided circle , rounded or none
  final ImageShape imageShape;

  /// image path is the path of the image that will be loaded from
  final String image;

  /// color for change tint image with different color, by default it's null
  final Color? color, defaultLoaderColor, defaultErrorBuilderColor;

  /// image height and width , by default is null
  final double? height, width;

  /// change image fit into source, default is null
  final BoxFit? boxFit;

  /// error and loader Builders have default value in case of null
  final Widget? errorBuilder, loaderBuilder;

  /// How to align the image within its bounds.
  ///
  /// The alignment aligns the given position in the image to the given position
  /// in the layout bounds. For example, an [Alignment] alignment of (-1.0,
  /// -1.0) aligns the image to the top-left corner of its layout bounds, while an
  /// [Alignment] alignment of (1.0, 1.0) aligns the bottom right of the
  /// image with the bottom right corner of its layout bounds. Similarly, an
  /// alignment of (0.0, 1.0) aligns the bottom middle of the image with the
  /// middle of the bottom edge of its layout bounds.
  ///
  /// To display a subpart of an image, consider using a [CustomPainter] and
  /// [Canvas.drawImageRect].
  ///
  /// If the [alignment] is [TextDirection]-dependent (i.e. if it is a
  /// [AlignmentDirectional]), then an ambient [Directionality] widget
  /// must be in scope.
  ///
  /// Defaults to [Alignment.center].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final Alignment alignment;

  /// image scale , default value is 1.0
  final double scale;

  /// work only when [ImageShape.rectangle]
  /// If non-null, the corners of this box are rounded by this [BorderRadius].
  ///
  /// Applies only to boxes with rectangular shapes; ignored if [shape] is not
  /// [BoxShape.rectangle].
  ///
  /// {@macro flutter.painting.BoxDecoration.clip}
  final BorderRadiusGeometry? borderRadius;

  const ImageView(
      {super.key,
      required this.image,
      required this.imageType,
      this.imageShape = ImageShape.none,
      this.color,
      this.height,
      this.width,
      this.boxFit,
      this.errorBuilder,
      this.loaderBuilder,
      this.alignment = Alignment.center,
      this.scale = 1.0,
      this.borderRadius,
      this.defaultLoaderColor,
      this.defaultErrorBuilderColor});

  @override
  Widget build(BuildContext context) {
    switch (imageShape) {
      case ImageShape.circle:
        return _circle;
      case ImageShape.rectangle:
        return _rounded;
      case ImageShape.none:
        return _loadImage;
      case ImageShape.oval:
        return _oval;
    }
  }

  Widget get _rounded => Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: borderRadius),
        child: _loadImage,
      );

  Widget get _circle => Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: _loadImage,
      );

  Widget get _oval => ClipOval(
        clipBehavior: Clip.antiAlias,
        child: _loadImage,
      );

  Widget get _loadImage {
    switch (imageType) {
      case ImageType.asset:
        return _asset;
      case ImageType.file:
        return _file;
      case ImageType.svg:
        return _svgLocalIcon;
      case ImageType.networkSvg:
        return _svgNetworkIcon;
      case ImageType.base64:
        return _base64;
    }
  }

  Widget get _svgLocalIcon => SvgPicture.asset(
        image,
        height: height,
        width: width,
        // ignore: deprecated_member_use
        color: color,
        fit: boxFit == null ? BoxFit.contain : boxFit!,
        alignment: alignment,
        placeholderBuilder: (context) => _errorBuilder,
      );

  Widget get _svgNetworkIcon => SvgPicture.network(
        image,
        height: height,
        width: width,
        // ignore: deprecated_member_use
        color: color,
        fit: boxFit == null ? BoxFit.contain : boxFit!,
        alignment: alignment,
        placeholderBuilder: (context) => _loaderBuilder,
      );

  Widget get _file => Image.file(File(image),
      color: color,
      cacheHeight: height!.toInt(),
      cacheWidth: width!.toInt(),
      height: height,
      width: width,
      fit: boxFit,
      errorBuilder: (context, error, stackTrace) => _errorBuilder,
      alignment: alignment,
      scale: scale);

  Widget get _asset => Image.asset(
        image,
        alignment: alignment,
        fit: boxFit,
        width: width,
        height: height,
        color: color,
        scale: scale,
        errorBuilder: (context, error, stackTrace) => _errorBuilder,
      );

  Widget get _base64 => image.isNotEmpty
      ? Image.memory(
          base64Decode(image),
          alignment: alignment,
          fit: boxFit,
          width: width,
          height: height,
          color: color,
          scale: scale,
          errorBuilder: (context, error, stackTrace) => _errorBuilder,
        )
      : _defaultErrorBuilder;

  Widget get _loaderBuilder => Container(
        width: width,
        height: height,
        color: themeOf().cardBorderColor,
        child: Center(
          child: _loader,
        ),
      );

  Widget get _errorBuilder =>
      errorBuilder == null ? _defaultErrorBuilder : errorBuilder!;

  Widget get _defaultErrorBuilder => Container(
        width: width,
        height: height,
        color: themeOf().cardBorderColor,
      );

/*  Widget get _loader => loaderBuilder == null
      ? CircularProgressIndicator(
    color: defaultLoaderColor,
    backgroundColor: Colors.transparent,
  ) : loaderBuilder!;*/

  Widget get _loader => loaderBuilder == null
      ? Container(
          color: defaultLoaderColor,
        )
      : loaderBuilder!;

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  String base64String(Uint8List data) {
    return base64Encode(data);
  }
}

String getBase64Image(String? image) {
  if (image != null && image.isNotEmpty == true) {
    String? convertedImage = image.replaceAll('-', '+');
    return convertedImage.replaceAll('_', '/');
  } else {
    return "";
  }
}
