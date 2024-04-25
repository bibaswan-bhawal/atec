import 'package:flutter/widgets.dart';

abstract class AppColors {
  AppColors();

  static Map<int, Color> gray = {
    25: const Color(0xFFFEFEFE),
    50: const Color(0xFFF9FAFB),
    100: const Color(0xFFF3F4F6),
    200: const Color(0xFFE5E7EB),
    300: const Color(0xFFD1D5DB),
    400: const Color(0xFF9CA3AF),
    500: const Color(0xFF6B7280),
    600: const Color(0xFF4B5563),
    700: const Color(0xFF374151),
    800: const Color(0xFF1F2937),
    900: const Color(0xFF111827)
  };

  static Color warning = const Color(0xFFC72317);

  static Color accent = const Color(0xFFFA7A1A);
}
