import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sumpyo_colors.dart';

class SumpyoTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: SumpyoColors.warmWhite,
      colorScheme: const ColorScheme.light(
        primary: SumpyoColors.sageGreen,
        secondary: SumpyoColors.muteBlue,
        surface: SumpyoColors.warmWhite,
        error: SumpyoColors.errorRed,
        onPrimary: SumpyoColors.warmWhite,
        onSecondary: SumpyoColors.warmWhite,
        onSurface: SumpyoColors.softCharcoal,
        onError: SumpyoColors.warmWhite,
      ),
      fontFamily: 'Pretendard',
      textTheme: _buildTextTheme(SumpyoColors.softCharcoal),
      appBarTheme: const AppBarTheme(
        backgroundColor: SumpyoColors.warmWhite,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: SumpyoColors.softCharcoal),
        titleTextStyle: TextStyle(
          fontFamily: 'Pretendard',
          color: SumpyoColors.softCharcoal,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardTheme(
        color: SumpyoColors.warmWhite,
        elevation: 2,
        shadowColor: const Color(0x33B7C9B0), // sageGreen 20%
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: SumpyoColors.sageGreen,
          foregroundColor: SumpyoColors.warmWhite,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    // 웜톤을 유지하는 다크 테마 설정
    const darkBackground = Color(0xFF2C2C2C);
    const darkSurface = Color(0xFF383838);
    const darkText = Color(0xFFE8E5E1);

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: SumpyoColors.sageGreen,
        secondary: SumpyoColors.muteBlue,
        surface: darkSurface,
        error: SumpyoColors.errorRed,
        onPrimary: darkBackground,
        onSecondary: darkBackground,
        onSurface: darkText,
        onError: darkText,
      ),
      fontFamily: 'Pretendard',
      textTheme: _buildTextTheme(darkText),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: darkText),
        titleTextStyle: TextStyle(
          fontFamily: 'Pretendard',
          color: darkText,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardTheme(
        color: darkSurface,
        elevation: 2,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: SumpyoColors.sageGreen,
          foregroundColor: darkBackground,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  static TextTheme _buildTextTheme(Color textColor) {
    return TextTheme(
      displayLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: textColor),
      displayMedium: TextStyle(
          fontSize: 28, fontWeight: FontWeight.bold, color: textColor),
      displaySmall: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w600, color: textColor),
      headlineMedium: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600, color: textColor),
      titleLarge: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: textColor),
      bodyLarge: TextStyle(
          fontSize: 16, fontWeight: FontWeight.normal, color: textColor),
      bodyMedium: TextStyle(
          fontSize: 14, fontWeight: FontWeight.normal, color: textColor),
      labelLarge: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: textColor),
      bodySmall: TextStyle(
          fontSize: 12, fontWeight: FontWeight.normal, color: textColor),
    );
  }

  // 감성 텍스트 (처방전 내용용)
  static TextStyle prescriptionText(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.gowunBatang(
      color: isDark ? const Color(0xFFE8E5E1) : SumpyoColors.softCharcoal,
      fontSize: 16,
      height: 1.6,
    );
  }

  // 강조 숫자 (고유 번호, 포인트용)
  static TextStyle emphasizeNumber(BuildContext context) {
    return GoogleFonts.montserrat(
      color: SumpyoColors.muteBlue,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 2.0,
    );
  }
}
