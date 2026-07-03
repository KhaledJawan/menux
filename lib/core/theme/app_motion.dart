import 'package:flutter/animation.dart';

/// Animation timing per DesignGD.md → Animations (200-300ms, natural feel).
abstract final class AppMotion {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 300);

  static const Curve curve = Curves.easeOutCubic;
}
