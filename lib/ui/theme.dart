import 'package:flutter/material.dart';

import '../models/theme_color.dart';

// MiliConfig visual design system: AMOLED neon dark surfaces, luminous accents,
// crisp borders, and high-contrast light mode.

// region shapes

/// Hero status & connection cards.
const kHeroRadius = 26.0;

/// Traffic, usage, Mili Hub, and banner cards.
const kCardRadius = 20.0;

/// Compact cards and chips.
const kSmallCardRadius = 14.0;

/// Dialogs.
const kDialogRadius = 26.0;

/// Menus and dropdown lists.
const kMenuRadius = 16.0;

/// Text fields and dropdown fields.
const kInputRadius = 14.0;

/// Smooth rounded corners across cards and dialogs.
RoundedSuperellipseBorder roundedShape(
  double radius, {
  BorderSide side = BorderSide.none,
}) => RoundedSuperellipseBorder(
  borderRadius: BorderRadius.circular(radius),
  side: side,
);

// endregion

// region form spacing

/// Space between stacked fields in a form card (fragments, noises).
const kFieldGap = 16.0;

/// Space on each side of the "–" between a min and a max field.
const kRangeDashGap = 12.0;

// endregion

/// Builds the MiliConfig ThemeData for [brightness] and the selected [color] palette.
ThemeData buildTheme(Brightness brightness, ThemeColor color) {
  final isDark = brightness == Brightness.dark;
  final baseScheme = ColorScheme.fromSeed(
    seedColor: color.seed,
    brightness: brightness,
  );

  final scheme = isDark
      ? baseScheme.copyWith(
          primary: color.seed,
          onPrimary: const Color(0xFF041108),
          primaryContainer: color.seed.withValues(alpha: 0.16),
          onPrimaryContainer: color.accent,
          secondary: color.accent,
          onSecondary: const Color(0xFF041108),
          secondaryContainer: color.accent.withValues(alpha: 0.14),
          onSecondaryContainer: color.accent,
          surface: color.darkBg,
          surfaceContainerLowest: color.darkBg,
          surfaceContainerLow: color.darkSurface,
          surfaceContainer: color.darkCard,
          surfaceContainerHigh: Color.alphaBlend(
            color.seed.withValues(alpha: 0.08),
            color.darkCard,
          ),
          surfaceContainerHighest: Color.alphaBlend(
            color.seed.withValues(alpha: 0.14),
            color.darkCard,
          ),
          onSurface: const Color(0xFFEAF7EE),
          onSurfaceVariant: const Color(0xFF9BB4A3),
          outline: color.seed.withValues(alpha: 0.34),
          outlineVariant: color.seed.withValues(alpha: 0.18),
        )
      : baseScheme.copyWith(
          primary: color == ThemeColor.neon
              ? const Color(0xFF0B8A4B)
              : color.seed,
          surface: const Color(0xFFF6FAF7),
          surfaceContainerLowest: Colors.white,
          surfaceContainerLow: const Color(0xFFEDF5F0),
          surfaceContainer: Colors.white,
          surfaceContainerHigh: const Color(0xFFE6F2EB),
          outlineVariant: const Color(0xFFD2E2D8),
        );

  return _buildTheme(scheme, color, isDark);
}

ThemeData _buildTheme(ColorScheme scheme, ThemeColor color, bool isDark) {
  final inputDecoration = InputDecorationTheme(
    filled: true,
    fillColor: isDark
        ? color.darkSurface.withValues(alpha: 0.85)
        : scheme.surfaceContainerLow,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kInputRadius),
      borderSide: BorderSide(color: scheme.outlineVariant),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kInputRadius),
      borderSide: BorderSide(color: scheme.outlineVariant),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kInputRadius),
      borderSide: BorderSide(color: scheme.primary, width: 1.5),
    ),
  );

  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    fontFamily: 'OpenSans',
    scaffoldBackgroundColor: isDark ? color.darkBg : scheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      foregroundColor: scheme.onSurface,
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
    ),
    cardTheme: CardThemeData(
      shape: roundedShape(
        kSmallCardRadius,
        side: BorderSide(
          color: scheme.outlineVariant.withValues(alpha: isDark ? 0.9 : 0.7),
          width: 1,
        ),
      ),
      color: scheme.surfaceContainer,
      elevation: 0,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: isDark ? color.darkCard : Colors.white,
      shape: roundedShape(
        kDialogRadius,
        side: BorderSide(
          color: scheme.primary.withValues(alpha: isDark ? 0.35 : 0.15),
          width: 1,
        ),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: isDark ? color.darkCard : Colors.white,
      shape: roundedShape(
        kMenuRadius,
        side: BorderSide(
          color: scheme.outlineVariant,
          width: 1,
        ),
      ),
    ),
    menuTheme: MenuThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(
          isDark ? color.darkCard : Colors.white,
        ),
        shape: WidgetStatePropertyAll(
          roundedShape(
            kMenuRadius,
            side: BorderSide(color: scheme.outlineVariant, width: 1),
          ),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: roundedShape(14),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: roundedShape(14),
        side: BorderSide(color: scheme.outline),
      ),
    ),
    chipTheme: ChipThemeData(
      shape: roundedShape(12),
      side: BorderSide(color: scheme.outlineVariant),
    ),
    inputDecorationTheme: inputDecoration,
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: inputDecoration,
    ),
    dividerTheme: DividerThemeData(
      color: scheme.outlineVariant.withValues(alpha: 0.6),
      thickness: 0.75,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: isDark ? color.darkCard : const Color(0xFF102418),
      contentTextStyle: const TextStyle(color: Color(0xFFEAF7EE)),
      shape: roundedShape(
        14,
        side: BorderSide(color: scheme.primary.withValues(alpha: 0.45)),
      ),
    ),
  );
}
