import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

export 'icons.dart';
export 'colors.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(
    textTheme: appTextTheme,
    brightness: Brightness.light,
    primaryColor: AppColors.gray[900],
    dialogTheme: DialogTheme(
      elevation: 0,
      backgroundColor: AppColors.gray[25],
      surfaceTintColor: Colors.transparent,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.gray[900],
      selectionHandleColor: AppColors.gray[900],
      selectionColor: AppColors.gray[900]!.withOpacity(0.2),
    ),

    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      labelStyle: appTextTheme.bodyLarge?.copyWith(color: AppColors.gray[500]),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.warning, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.gray[300]!, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.warning, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.gray[500]!, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        alignment: Alignment.center,
        backgroundColor: MaterialStateProperty.all(AppColors.accent),
        textStyle: MaterialStateProperty.all(appTextTheme.labelLarge),
        foregroundColor: MaterialStateProperty.all(AppColors.gray[25]),
        minimumSize: MaterialStateProperty.all(const Size.fromHeight(48)),
      ),
    ),
  );

  static SystemUiOverlayStyle systemUiOverlayDark = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarContrastEnforced: true,
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  static SystemUiOverlayStyle systemUiOverlayLight = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
  );

  static void setSystemUIDark() {
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayDark);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  static void setSystemUILight() {
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayLight);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  static TextTheme appTextTheme = TextTheme(
    displayLarge: GoogleFonts.lexend(fontSize: 64, height: 1.12, fontWeight: FontWeight.w600),
    displayMedium: GoogleFonts.lexend(fontSize: 45, height: 1.16, fontWeight: FontWeight.w600),
    displaySmall: GoogleFonts.lexend(fontSize: 36, height: 1.22, fontWeight: FontWeight.w600),
    headlineLarge: GoogleFonts.lexend(fontSize: 32, height: 1.25, fontWeight: FontWeight.w500),
    headlineMedium: GoogleFonts.lexend(fontSize: 28, height: 1.27, fontWeight: FontWeight.w500),
    headlineSmall: GoogleFonts.lexend(fontSize: 24, height: 1.33, fontWeight: FontWeight.w500),
    titleLarge: GoogleFonts.lexend(fontSize: 20, height: 1.27, fontWeight: FontWeight.w500),
    titleMedium: GoogleFonts.lexend(fontSize: 16, height: 1.50, fontWeight: FontWeight.w500),
    titleSmall: GoogleFonts.lexend(fontSize: 14, height: 1.43, fontWeight: FontWeight.w500),
    bodyLarge: GoogleFonts.lexend(fontSize: 16, height: 1.50, fontWeight: FontWeight.w400),
    bodyMedium: GoogleFonts.lexend(fontSize: 14, height: 1.43, fontWeight: FontWeight.w400),
    bodySmall: GoogleFonts.lexend(fontSize: 12, height: 1.33, fontWeight: FontWeight.w400),
    labelLarge: GoogleFonts.lexend(fontSize: 14, height: 1.43, fontWeight: FontWeight.w500),
    labelMedium: GoogleFonts.lexend(fontSize: 12, height: 1.33, fontWeight: FontWeight.w500),
    labelSmall: GoogleFonts.lexend(fontSize: 11, height: 1.45, fontWeight: FontWeight.w500),
  );
}
