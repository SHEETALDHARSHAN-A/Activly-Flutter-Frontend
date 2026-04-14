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
            child: _UiverseHeartLoader(controller: _controller),
          ),
        ),
      ),
    );
  }
}

class _UiverseHeartLoader extends StatelessWidget {
  const _UiverseHeartLoader({required this.controller});

  static const double _unit = 62;
  static const Cubic _motionCurve = Cubic(0.75, 0, 0.5, 1);

  final Animation<double> controller;

  double _triangleWave(double t, double center, double halfWidth) {
    final normalized = ((t - center).abs() / halfWidth).clamp(0.0, 1.0);
    return 1 - normalized;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      height: 178,
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          final t = _motionCurve.transform(controller.value);
          final heartRotation = t * 4 * math.pi;

          final squarePulse = _triangleWave(t, 0.5, 0.5);
          final squareScale = 1 - (0.5 * squarePulse);
          final squareRadius = (_unit / 2) * squarePulse;

          final leftPulse = _triangleWave(t, 0.6, 0.12);
          final leftScale = 1 - (0.6 * leftPulse);

          final rightPulse = _triangleWave(t, 0.4, 0.12);
          final rightScale = 1 - (0.6 * rightPulse);

          final shadowPulse = _triangleWave(t, 0.5, 0.5);
          final shadowScale = 1 - (0.5 * shadowPulse);
          final shadowColor = Color.lerp(
            kColorLoaderShadowBase,
            kColorLoaderShadowPulse,
            shadowPulse,
          )!;

          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                bottom: 12,
                child: Transform.scale(
                  scale: shadowScale,
                  child: Container(
                    width: _unit,
                    height: _unit * 0.24,
                    decoration: BoxDecoration(
                      color: shadowColor,
                      border: Border.all(color: shadowColor),
                      borderRadius: BorderRadius.circular(_unit),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                child: Transform.rotate(
                  angle: heartRotation,
                  child: SizedBox(
                    width: _unit * 2,
                    height: _unit * 2,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Transform.translate(
                          offset: const Offset(-28, -27),
                          child: Transform.scale(
                            scale: leftScale,
                            child: const _LoaderHeartCircle(),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(28, -27),
                          child: Transform.scale(
                            scale: rightScale,
                            child: const _LoaderHeartCircle(),
                          ),
                        ),
                        Transform.rotate(
                          angle: -math.pi / 4,
                          child: Transform.scale(
                            scale: squareScale,
                            child: Container(
                              width: _unit,
                              height: _unit,
                              decoration: BoxDecoration(
                                color: kColorLoaderHeart,
                                border: Border.all(color: kColorLoaderHeart),
                                borderRadius: BorderRadius.circular(
                                  squareRadius,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LoaderHeartCircle extends StatelessWidget {
  const _LoaderHeartCircle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _UiverseHeartLoader._unit,
      height: _UiverseHeartLoader._unit,
      decoration: BoxDecoration(
        color: kColorLoaderHeart,
        border: Border.all(color: kColorLoaderHeart),
        shape: BoxShape.circle,
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

