import 'dart:io';

import 'package:flutter/widgets.dart';

Widget buildLocalImage(
  String path, {
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
  required WidgetBuilder placeholderBuilder,
}) {
  return Image.file(
    File(path),
    width: width,
    height: height,
    fit: fit,
    errorBuilder: (context, error, stackTrace) => placeholderBuilder(context),
  );
}
