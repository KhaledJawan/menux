import 'package:flutter/material.dart';

/// iOS-style bouncing scroll physics on every platform, per DesignGD.md →
/// Scrolling ("iOS-style scrolling physics, smooth momentum, bounce effect,
/// no abrupt stopping"). Applied app-wide via MaterialApp.scrollBehavior.
class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    );
  }
}
