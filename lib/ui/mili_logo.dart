import 'package:flutter/material.dart';

/// MiliConfig's signature glowing neon shield with the "M" monogram.
class MiliShieldLogo extends StatelessWidget {
  final double size;
  final Color? primaryColor;
  final Color? accentColor;
  final bool glow;

  const MiliShieldLogo({
    super.key,
    this.size = 32,
    this.primaryColor,
    this.accentColor,
    this.glow = true,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final primary = primaryColor ?? scheme.primary;
    final accent = accentColor ?? scheme.secondary;
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _MiliShieldPainter(
          primary: primary,
          accent: accent,
          glow: glow,
        ),
      ),
    );
  }
}

class _MiliShieldPainter extends CustomPainter {
  final Color primary;
  final Color accent;
  final bool glow;

  const _MiliShieldPainter({
    required this.primary,
    required this.accent,
    required this.glow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.shortestSide / 128.0;
    Offset pt(double x, double y) => Offset(x * s, y * s);

    final shield = Path()
      ..moveTo(64 * s, 14 * s)
      ..lineTo(106 * s, 30 * s)
      ..lineTo(106 * s, 61 * s)
      ..cubicTo(106 * s, 86 * s, 89 * s, 104 * s, 64 * s, 114 * s)
      ..cubicTo(39 * s, 104 * s, 22 * s, 86 * s, 22 * s, 61 * s)
      ..lineTo(22 * s, 30 * s)
      ..close();

    if (glow) {
      canvas.drawPath(
        shield,
        Paint()
          ..color = primary.withValues(alpha: 0.28)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 11 * s
          ..strokeJoin = StrokeJoin.round
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 7 * s),
      );
    }

    canvas.drawPath(
      shield,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primary.withValues(alpha: 0.24),
            accent.withValues(alpha: 0.08),
          ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
        ..style = PaintingStyle.fill,
    );

    canvas.drawPath(
      shield,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [accent, primary],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5.5 * s
        ..strokeJoin = StrokeJoin.round,
    );

    final mPath = Path()
      ..moveTo(43 * s, 80 * s)
      ..lineTo(43 * s, 50 * s)
      ..lineTo(64 * s, 67 * s)
      ..lineTo(85 * s, 50 * s)
      ..lineTo(85 * s, 80 * s);

    if (glow) {
      canvas.drawPath(
        mPath,
        Paint()
          ..color = accent.withValues(alpha: 0.35)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 14 * s
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5 * s),
      );
    }

    canvas.drawPath(
      mPath,
      Paint()
        ..color = accent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 9.2 * s
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(_MiliShieldPainter oldDelegate) =>
      oldDelegate.primary != primary ||
      oldDelegate.accent != accent ||
      oldDelegate.glow != glow;
}
