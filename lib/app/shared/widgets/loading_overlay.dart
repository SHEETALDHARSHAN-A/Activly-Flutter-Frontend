part of 'package:activly/activly_app.dart';

class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({super.key, required this.isVisible});

  final bool isVisible;

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static double _segment(double value, double start, double end) {
    if (value <= start) {
      return 0;
    }
    if (value >= end) {
      return 1;
    }
    return (value - start) / (end - start);
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.isVisible,
      child: AnimatedOpacity(
        opacity: widget.isVisible ? 1 : 0,
        duration: const Duration(milliseconds: 500),
        child: ColoredBox(
          color: Colors.black,
          child: Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                final progress = _controller.value;
                final writeProgress = _segment(progress, 0.07, 0.80);
                final bgOpacity = progress < 0.82
                    ? 0.0
                    : ((progress - 0.82) / 0.18).clamp(0.0, 1.0) * 0.08;
                final jitter = math.sin(progress * 2 * math.pi * 17) * 0.45;

                double heartOpacity(double delay) {
                  final shifted = (progress - delay) % 1;
                  if (shifted < 0.79 || shifted > 0.98) {
                    return 0;
                  }
                  if (shifted < 0.84) {
                    return (shifted - 0.79) / 0.05;
                  }
                  if (shifted < 0.92) {
                    return 1 - ((shifted - 0.84) / 0.08) * 0.45;
                  }
                  return (1 - (shifted - 0.92) / 0.06).clamp(0, 1) * 0.55;
                }

                double heartLift(double delay) {
                  final shifted = (progress - delay) % 1;
                  if (shifted < 0.79 || shifted > 0.98) {
                    return 0.6;
                  }
                  if (shifted < 0.84) {
                    return 0.6 - ((shifted - 0.79) / 0.05) * 3.2;
                  }
                  if (shifted < 0.92) {
                    return -2.6 + ((shifted - 0.84) / 0.08) * 2.6;
                  }
                  return 0;
                }

                return SizedBox(
                  width: math.min(MediaQuery.sizeOf(context).width * 0.78, 700),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Opacity(
                              opacity: bgOpacity,
                              child: Image.asset('assets/Activly-text.png'),
                            ),
                            Transform.translate(
                              offset: Offset(jitter, -jitter * 0.7),
                              child: Stack(
                                children: <Widget>[
                                  Opacity(
                                    opacity: 0,
                                    child: Image.asset('assets/Activly-text.png'),
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: writeProgress,
                                      child: Image.asset('assets/Activly-text.png'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: <Widget>[
                            _HeartGlyph(
                              opacity: heartOpacity(0),
                              yOffset: heartLift(0),
                            ),
                            _HeartGlyph(
                              opacity: heartOpacity(0.04),
                              yOffset: heartLift(0.04),
                            ),
                            _HeartGlyph(
                              opacity: heartOpacity(0.08),
                              yOffset: heartLift(0.08),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _HeartGlyph extends StatelessWidget {
  const _HeartGlyph({required this.opacity, required this.yOffset});

  final double opacity;
  final double yOffset;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, yOffset),
      child: Opacity(
        opacity: opacity,
        child: const Text(
          '❤',
          style: TextStyle(
            color: Color(0xFFECE8FE),
            fontSize: 14,
            shadows: <Shadow>[
              Shadow(blurRadius: 8, color: Color.fromRGBO(124, 76, 255, 0.44)),
            ],
          ),
        ),
      ),
    );
  }
}

class _BladeSpinner extends StatefulWidget {
  const _BladeSpinner({this.size = 18, this.color});

  final double size;
  final Color? color;

  @override
  State<_BladeSpinner> createState() => _BladeSpinnerState();
}

class _BladeSpinnerState extends State<_BladeSpinner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bladeWidth = widget.size * 0.074;
    final bladeHeight = widget.size * 0.278;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            alignment: Alignment.center,
            children: List<Widget>.generate(12, (int index) {
              final phase = (_controller.value + (index / 12)) % 1.0;
              final opacity = (1 - phase).clamp(0.0, 1.0);

              return Transform.rotate(
                angle: (index * 30) * (math.pi / 180),
                child: Transform.translate(
                  offset: Offset(0, -widget.size * 0.22),
                  child: Container(
                    width: bladeWidth,
                    height: bladeHeight,
                    decoration: BoxDecoration(
                      color: (widget.color ?? const Color(0xFF69717D)).withValues(
                        alpha: opacity,
                      ),
                      borderRadius: BorderRadius.circular(widget.size * 0.0555),
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
