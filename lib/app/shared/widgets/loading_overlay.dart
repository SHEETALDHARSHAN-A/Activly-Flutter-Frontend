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
      duration: const Duration(milliseconds: 2880),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.isVisible,
      child: AnimatedOpacity(
        opacity: widget.isVisible ? 1 : 0,
        duration: const Duration(milliseconds: 360),
        child: ColoredBox(
          color: kColorBlack,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'assets/Activly-logo.png',
                    width: 210,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 26),
                  _UiverseHeartLoader(controller: _controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UiverseHeartLoader extends StatelessWidget {
  const _UiverseHeartLoader({required this.controller});

  final Animation<double> controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 154,
      height: 130,
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          final t = controller.value;
          final jump = (math.sin((2 * math.pi * t) - (math.pi / 2)) + 1) / 2;
          final lift = -24 * jump;
          final heartScale = 1 - (0.20 * jump);
          final shadowWidth = 76 - (30 * jump);

          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                bottom: 8,
                child: Container(
                  width: shadowWidth,
                  height: 12,
                  decoration: BoxDecoration(
                    color: kColorWhite.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
              _LoaderOrb(progress: t, delay: 0.08),
              _LoaderOrb(progress: t, delay: 0.41),
              _LoaderOrb(progress: t, delay: 0.72),
              Transform.translate(
                offset: Offset(0, lift),
                child: Transform.scale(
                  scale: heartScale,
                  child: const _HeartShape(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LoaderOrb extends StatelessWidget {
  const _LoaderOrb({required this.progress, required this.delay});

  final double progress;
  final double delay;

  @override
  Widget build(BuildContext context) {
    final phase = (progress + delay) % 1.0;
    final angle = (2 * math.pi * phase) - (math.pi / 2);
    final dx = math.cos(angle) * 33;
    final dy = math.sin(angle) * 12;
    final opacity = (0.28 + (0.72 * (1 - phase))).clamp(0.0, 1.0);

    return Transform.translate(
      offset: Offset(dx, dy - 8),
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: kColorLavender,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _HeartShape extends StatelessWidget {
  const _HeartShape();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 82,
      height: 72,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: <Widget>[
          Transform.rotate(
            angle: -math.pi / 4,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: kColorPrimary,
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 16,
                    spreadRadius: -8,
                    color: kColorPrimary.withValues(alpha: 0.70),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            left: 11,
            top: 8,
            child: _HeartCircle(),
          ),
          const Positioned(
            right: 11,
            top: 8,
            child: _HeartCircle(),
          ),
        ],
      ),
    );
  }
}

class _HeartCircle extends StatelessWidget {
  const _HeartCircle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: kColorPrimary,
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 14,
            spreadRadius: -8,
            color: kColorPrimary.withValues(alpha: 0.66),
          ),
        ],
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
                      color: (widget.color ?? kColorSpinnerNeutral).withValues(
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

