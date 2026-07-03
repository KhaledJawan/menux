import 'package:flutter/widgets.dart';

/// Menux is mobile/desktop-first (see PRD.md); the web build has no local
/// file persistence, so a device-uploaded image's path never resolves
/// there — fall back to the placeholder instead of trying to read a file
/// that can't exist on this platform.
Widget buildLocalImage(
  String path, {
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
  required WidgetBuilder placeholderBuilder,
}) {
  return Builder(builder: placeholderBuilder);
}
