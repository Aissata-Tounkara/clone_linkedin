import 'package:flutter/material.dart';
import 'app_tokens.dart';

export 'app_tokens.dart';

/// Ancienne palette conservée en alias pour ne rien casser dans le code
/// existant. Les nouveaux écrans utilisent [LiColors].
class AppColors {
  AppColors._();
  static const blue = LiColors.brand;
  static const canvas = LiColors.canvas;
  static const surface = LiColors.surface;
  static const text = LiColors.textPrimary;
  static const mutedText = LiColors.textSecondary;
  static const searchSurface = LiColors.searchField;
  static const unread = LiColors.unread;
  static const border = LiColors.border;
}

class AppTheme {
  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: LiColors.brand,
      brightness: Brightness.light,
    ).copyWith(
      surface: LiColors.surface,
      surfaceContainerLowest: LiColors.surface,
      onSurface: LiColors.textPrimary,
    );

    TextStyle t(double size, FontWeight weight, {double? spacing, double? h}) =>
        TextStyle(
          fontSize: size,
          fontWeight: weight,
          letterSpacing: spacing ?? -0.1,
          height: h,
          color: LiColors.textPrimary,
        );

    final textTheme = TextTheme(
      headlineMedium: t(24, FontWeight.w700, spacing: -0.4, h: 1.2),
      headlineSmall: t(20, FontWeight.w700, spacing: -0.3, h: 1.25),
      titleLarge: t(18, FontWeight.w600, spacing: -0.2),
      titleMedium: t(16, FontWeight.w600),
      titleSmall: t(14, FontWeight.w600),
      bodyLarge: t(16, FontWeight.w400, h: 1.4),
      bodyMedium: t(14, FontWeight.w400, h: 1.43),
      bodySmall: t(12, FontWeight.w400, h: 1.33).copyWith(
        color: LiColors.textSecondary,
      ),
      labelLarge: t(15, FontWeight.w600, spacing: 0),
      labelMedium: t(12, FontWeight.w600, spacing: 0).copyWith(
        color: LiColors.textSecondary,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: LiColors.canvas,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
        },
      ),
      splashFactory: InkSparkle.splashFactory,
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: LiColors.surface,
        surfaceTintColor: LiColors.surface,
        foregroundColor: LiColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        titleSpacing: 12,
      ),
      dividerTheme: const DividerThemeData(
        color: LiColors.hairline,
        thickness: 1,
        space: 1,
      ),
      cardTheme: const CardThemeData(
        color: LiColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(LiRadius.card)),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: LiColors.surface,
        selectedColor: LiColors.brandTint,
        side: const BorderSide(color: LiColors.border),
        shape: const StadiumBorder(),
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: LiColors.textSecondary,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: LiColors.surface,
        hintStyle: const TextStyle(color: LiColors.textTertiary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: LiColors.textTertiary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: LiColors.textTertiary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: LiColors.brand, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: LiColors.brand,
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFFE0E0E0),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: const StadiumBorder(),
          minimumSize: const Size(0, 48),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: LiColors.brand,
          side: const BorderSide(color: LiColors.brand, width: 1.3),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: const StadiumBorder(),
          minimumSize: const Size(0, 44),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: LiColors.textSecondary,
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: LiColors.surface,
        indicatorColor: Colors.transparent,
        elevation: 0,
        height: 56,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            size: 24,
            color: states.contains(WidgetState.selected)
                ? LiColors.textPrimary
                : LiColors.textTertiary,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 11,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w600
                : FontWeight.w400,
            color: states.contains(WidgetState.selected)
                ? LiColors.textPrimary
                : LiColors.textTertiary,
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color(0xFF1D2226),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: LiColors.surface,
        surfaceTintColor: LiColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
    );
  }
}
