import 'package:flutter/material.dart';

class GradientBackground extends StatefulWidget {
  const GradientBackground({super.key});

  @override
  State<GradientBackground> createState() => _GradientBackgroundState();
}

class _GradientBackgroundState extends State<GradientBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 12))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) {
        final t = _c.value;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1 + t * 0.2, -1),
              end: Alignment(1, 1 - t * 0.2),
              colors: [
                cs.primary.withOpacity(0.10),
                cs.tertiary.withOpacity(0.08),
                cs.secondary.withOpacity(0.10),
              ],
            ),
          ),
          child: CustomPaint(
            painter: _BlobPainter(t, cs.primary, cs.secondary),
          ),
        );
      },
    );
  }
}

class _BlobPainter extends CustomPainter {
  _BlobPainter(this.t, this.a, this.b);
  final double t;
  final Color a, b;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60);
    final c1 = Offset(size.width * (0.2 + 0.1 * t), size.height * 0.25);
    final c2 = Offset(size.width * (0.85 - 0.1 * t), size.height * 0.75);

    p.color = a.withOpacity(0.18);
    canvas.drawCircle(c1, size.shortestSide * 0.25, p);
    p.color = b.withOpacity(0.16);
    canvas.drawCircle(c2, size.shortestSide * 0.22, p);
  }

  @override
  bool shouldRepaint(_BlobPainter old) =>
      old.t != t || old.a != a || old.b != b;
}
