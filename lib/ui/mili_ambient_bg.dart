import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Lively, battery-friendly animated neon ambient backdrop inspired by MiliConfig's FX canvas.
/// Renders soft glowing aurora orbs, subtle cyber-grid lines, and drifting particles synced
/// to the active theme palette so the app feels alive rather than flat.
class MiliAmbientBackground extends StatefulWidget {
  final Widget child;
  final bool connected;

  const MiliAmbientBackground({
    super.key,
    required this.child,
    this.connected = false,
  });

  @override
  State<MiliAmbientBackground> createState() => _MiliAmbientBackgroundState();
}

class _MiliAmbientBackgroundState extends State<MiliAmbientBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Stack(
      fit: StackFit.expand,
      children: [
        RepaintBoundary(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => CustomPaint(
              painter: _MiliAmbientPainter(
                t: _controller.value,
                primary: scheme.primary,
                secondary: scheme.secondary,
                isDark: isDark,
                connected: widget.connected,
              ),
            ),
          ),
        ),
        widget.child,
      ],
    );
  }
}

class _MiliAmbientPainter extends CustomPainter {
  final double t;
  final Color primary;
  final Color secondary;
  final bool isDark;
  final bool connected;

  const _MiliAmbientPainter({
    required this.t,
    required this.primary,
    required this.secondary,
    required this.isDark,
    required this.connected,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final angle = t * 2 * math.pi;

    // 1. Subtle cyber grid
    final gridPaint = Paint()
      ..color = primary.withValues(alpha: isDark ? 0.045 : 0.05)
      ..strokeWidth = 0.8;
    const step = 40.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // 2. Drifting radial neon aurora orbs
    final orb1 = Offset(
      size.width * (0.2 + 0.14 * math.sin(angle)),
      size.height * (0.16 + 0.08 * math.cos(angle)),
    );
    final orb2 = Offset(
      size.width * (0.82 + 0.12 * math.cos(angle * 0.8)),
      size.height * (0.72 + 0.1 * math.sin(angle * 0.8)),
    );
    final boost = connected ? 1.45 : 1.0;

    void drawOrb(Offset center, double radius, Color color, double alpha) {
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            color.withValues(alpha: (alpha * boost).clamp(0.0, 0.35)),
            color.withValues(alpha: 0),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: radius));
      canvas.drawCircle(center, radius, paint);
    }

    drawOrb(orb1, size.width * 0.55, primary, isDark ? 0.16 : 0.08);
    drawOrb(orb2, size.width * 0.50, secondary, isDark ? 0.12 : 0.06);

    // 3. Soft drifting neon particles
    final dotPaint = Paint()..style = PaintingStyle.fill;
    for (int i = 0; i < 14; i++) {
      final phase = (i * 0.6180339887) % 1.0;
      final px = ((phase + t * (0.12 + (i % 3) * 0.04)) % 1.0) * size.width;
      final py =
          (((i * 0.37) % 1.0) + 0.06 * math.sin(angle + i * 1.1)) * size.height;
      final r = 1.3 + (i % 3) * 0.7;
      dotPaint.color = (i.isEven ? primary : secondary).withValues(
        alpha: isDark ? 0.24 : 0.14,
      );
      canvas.drawCircle(Offset(px, py.clamp(0, size.height)), r, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_MiliAmbientPainter oldDelegate) =>
      oldDelegate.t != t ||
      oldDelegate.primary != primary ||
      oldDelegate.connected != connected ||
      oldDelegate.isDark != isDark;
}
