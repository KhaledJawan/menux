import 'package:flutter/material.dart';

/// Menux color system — black & white first, accent colors reserved for
/// status only. See DesignGD.md → Color System / Status Colors.
abstract final class AppColors {
  // Primary
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // Neutral gray scale
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF2F2F2);
  static const Color gray200 = Color(0xFFE5E5E5);
  static const Color gray300 = Color(0xFFD4D4D4);
  static const Color gray400 = Color(0xFFA3A3A3);
  static const Color gray500 = Color(0xFF737373);
  static const Color gray600 = Color(0xFF525252);
  static const Color gray700 = Color(0xFF404040);
  static const Color gray800 = Color(0xFF262626);
  static const Color gray900 = Color(0xFF171717);

  // Semantic accents (status only — never decorative)
  static const Color success = Color(0xFF34C759); // Green
  static const Color warning = Color(0xFFFF9500); // Orange
  static const Color danger = Color(0xFFFF3B30); // Red
  static const Color info = Color(0xFF007AFF); // Blue

  // Table / order status colors (DesignGD → Status Colors)
  static const Color statusAvailable = success;
  static const Color statusOccupied = info;
  static const Color statusReserved = warning;
  static const Color statusCleaning = Color(0xFFAF52DE); // Purple
  static const Color statusDisabled = gray400;
  static const Color statusCancelled = danger;
}
