part of 'package:activly/activly_app.dart';

class _GoogleGArcsPainter extends CustomPainter {
  const _GoogleGArcsPainter({required this.strokeWidth});

  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = math.min(size.width, size.height) / 2;

    final paints = <Color, Paint>{
      const Color(0xFFEA4335): Paint()
        ..color = const Color(0xFFEA4335)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.butt
        ..strokeWidth = strokeWidth,
      const Color(0xFFFBBC05): Paint()
        ..color = const Color(0xFFFBBC05)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.butt
        ..strokeWidth = strokeWidth,
      const Color(0xFF34A853): Paint()
        ..color = const Color(0xFF34A853)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.butt
        ..strokeWidth = strokeWidth,
      const Color(0xFF4285F4): Paint()
        ..color = const Color(0xFF4285F4)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.butt
        ..strokeWidth = strokeWidth,
    };

    void arc(Color color, double startDeg, double sweepDeg) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startDeg * math.pi / 180,
        sweepDeg * math.pi / 180,
        false,
        paints[color]!,
      );
    }

    arc(const Color(0xFFEA4335), 212, 95);
    arc(const Color(0xFFFBBC05), 307, 55);
    arc(const Color(0xFF34A853), 2, 92);
    arc(const Color(0xFF4285F4), 94, 118);
  }

  @override
  bool shouldRepaint(covariant _GoogleGArcsPainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth;
  }
}
