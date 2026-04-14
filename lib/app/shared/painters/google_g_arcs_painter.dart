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
      kColorGoogleRed: Paint()
        ..color = kColorGoogleRed
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.butt
        ..strokeWidth = strokeWidth,
      kColorGoogleYellow: Paint()
        ..color = kColorGoogleYellow
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.butt
        ..strokeWidth = strokeWidth,
      kColorGoogleGreen: Paint()
        ..color = kColorGoogleGreen
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.butt
        ..strokeWidth = strokeWidth,
      kColorGoogleBlue: Paint()
        ..color = kColorGoogleBlue
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

    arc(kColorGoogleRed, 212, 95);
    arc(kColorGoogleYellow, 307, 55);
    arc(kColorGoogleGreen, 2, 92);
    arc(kColorGoogleBlue, 94, 118);
  }

  @override
  bool shouldRepaint(covariant _GoogleGArcsPainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth;
  }
}

