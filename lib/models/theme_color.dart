import 'dart:ui' show Color;

/// MiliConfig signature themes — vibrant AMOLED dark palettes plus crisp daylight.
enum ThemeColor {
  neon(
    'Neon Green',
    Color(0xFF39FF88),
    accent: Color(0xFFB5FF4D),
    darkBg: Color(0xFF05080A),
    darkSurface: Color(0xFF0A140E),
    darkCard: Color(0xFF0D1B12),
  ),
  emerald(
    'Dark Emerald',
    Color(0xFF2BFF9E),
    accent: Color(0xFF5CFFD6),
    darkBg: Color(0xFF020B07),
    darkSurface: Color(0xFF061B13),
    darkCard: Color(0xFF09241A),
  ),
  cyan(
    'Cyber Blue',
    Color(0xFF39E6FF),
    accent: Color(0xFF38BDF8),
    darkBg: Color(0xFF050F15),
    darkSurface: Color(0xFF091B24),
    darkCard: Color(0xFF0D2532),
  ),
  violet(
    'Quantum Purple',
    Color(0xFFB388FF),
    accent: Color(0xFF58D8FF),
    darkBg: Color(0xFF080511),
    darkSurface: Color(0xFF130D24),
    darkCard: Color(0xFF1B1233),
  ),
  amber(
    'Amber Gold',
    Color(0xFFFFB020),
    accent: Color(0xFFFBBF24),
    darkBg: Color(0xFF0D0904),
    darkSurface: Color(0xFF1A1207),
    darkCard: Color(0xFF24190A),
  ),
  rose(
    'Blaze Fire',
    Color(0xFFFF5470),
    accent: Color(0xFFFF9F6E),
    darkBg: Color(0xFF10060A),
    darkSurface: Color(0xFF1F0C14),
    darkCard: Color(0xFF2B101B),
  ),
  daylight(
    'Daylight Emerald',
    Color(0xFF0B8A4B),
    accent: Color(0xFF1FA463),
    darkBg: Color(0xFF06110B),
    darkSurface: Color(0xFF0B1C13),
    darkCard: Color(0xFF10261B),
  );

  final String label;
  final Color seed;
  final Color accent;
  final Color darkBg;
  final Color darkSurface;
  final Color darkCard;

  const ThemeColor(
    this.label,
    this.seed, {
    required this.accent,
    required this.darkBg,
    required this.darkSurface,
    required this.darkCard,
  });

  /// Maps legacy theme names to the nearest MiliConfig theme.
  static ThemeColor fromName(String? name) {
    if (name == null) return ThemeColor.neon;
    for (final c in ThemeColor.values) {
      if (c.name == name) return c;
    }
    return switch (name) {
      'green' => ThemeColor.neon,
      'teal' => ThemeColor.emerald,
      'blue' => ThemeColor.cyan,
      'purple' => ThemeColor.violet,
      'orange' => ThemeColor.amber,
      'pink' => ThemeColor.rose,
      _ => ThemeColor.neon,
    };
  }
}
