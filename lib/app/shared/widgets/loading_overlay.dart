part of 'package:activly/activly_app.dart';

class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({
    super.key,
    required this.isVisible,
    this.backgroundColor = kColorBlack,
    this.showBrandImage = true,
  });

  final bool isVisible;
  final Color backgroundColor;
  final bool showBrandImage;

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay>
    with SingleTickerProviderStateMixin {
  static const String _brandImageAsset =
      'assets/Activly-text-with-bottom-line.webp';

  late final AnimationController _controller;
  bool _isBrandImageLoaded = false;

  void _markBrandImageLoaded() {
    if (_isBrandImageLoaded) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _isBrandImageLoaded) {
        return;
      }
      setState(() => _isBrandImageLoaded = true);
    });
  }

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
          color: widget.backgroundColor,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (widget.showBrandImage)
                  Image.asset(
                    _brandImageAsset,
                    width: 300,
                    fit: BoxFit.contain,
                    frameBuilder:
                        (
                          BuildContext context,
                          Widget child,
                          int? frame,
                          bool wasSynchronouslyLoaded,
                        ) {
                          if (wasSynchronouslyLoaded || frame != null) {
                            _markBrandImageLoaded();
                          }
                          return child;
                        },
                    errorBuilder:
                        (
                          BuildContext context,
                          Object error,
                          StackTrace? stackTrace,
                        ) {
                          // Do not block the loader forever if the image fails.
                          _markBrandImageLoaded();
                          return const SizedBox(width: 300, height: 44);
                        },
                  ),
                if (widget.showBrandImage) const SizedBox(height: 18),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  child: (!widget.showBrandImage || _isBrandImageLoaded)
                      ? KeyedSubtree(
                          key: const ValueKey<String>('heart-loader'),
                          child: _UiverseHeartLoader(controller: _controller),
                        )
                      : const SizedBox(
                          key: ValueKey<String>('heart-loader-placeholder'),
                          width: 168,
                          height: 168,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UiverseHeartLoader extends StatelessWidget {
  const _UiverseHeartLoader({required this.controller});

  // Matches CSS cubic-bezier(0.75, 0, 0.5, 1)
  static const Cubic _motionCurve = Cubic(0.75, 0, 0.5, 1);
  static const double _unit = 56;

  final AnimationController controller;

  static const List<Color> _heartPalette = <Color>[
    kColorPrimary,
    kColorPrimaryAccent,
    kColorGoogleBlue,
    kColorGoogleGreen,
    kColorGoogleRed,
  ];

  double _lerp(double start, double end, double t) {
    return start + ((end - start) * t);
  }

  // Mirrors CSS keyframes: start -> mid at breakAt% -> end.
  double _keyframeValue(
    double start,
    double mid,
    double end,
    int breakAt,
    double progress,
  ) {
    final pivot = breakAt / 100;
    if (progress <= pivot) {
      final local = (progress / pivot).clamp(0.0, 1.0);
      return _lerp(start, mid, _motionCurve.transform(local));
    }
    final local = ((progress - pivot) / (1 - pivot)).clamp(0.0, 1.0);
    return _lerp(mid, end, _motionCurve.transform(local));
  }

  Widget _circle(double unit, Color color) {
    return Container(
      width: unit,
      height: unit,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  @override
  Widget build(BuildContext context) {
    const unit = _unit;
    final canvasSize = unit * 3;
    final shadowHeight = unit * 0.24;

    return SizedBox(
      width: canvasSize,
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          final progress = controller.value;
          final durationMs = controller.duration?.inMilliseconds ?? 1;
          final elapsedMs = controller.lastElapsedDuration?.inMilliseconds ?? 0;
          final cycleIndex = durationMs > 0 ? elapsedMs ~/ durationMs : 0;
          final colorA = _heartPalette[cycleIndex % _heartPalette.length];
          final colorB = _heartPalette[(cycleIndex + 1) % _heartPalette.length];
          final heartColor = Color.lerp(
            colorA,
            colorB,
            Curves.easeInOut.transform(progress),
          )!;

          final heartRotation = _keyframeValue(
            0,
            2 * math.pi,
            4 * math.pi,
            50,
            progress,
          );

          final leftTx = _keyframeValue(-28, 0, -28, 60, progress);
          final leftTy = _keyframeValue(-27, 0, -27, 60, progress);
          final leftScale = _keyframeValue(1, 0.4, 1, 60, progress);

          final rightTx = _keyframeValue(28, 0, 28, 40, progress);
          final rightTy = _keyframeValue(-27, 0, -27, 40, progress);
          final rightScale = _keyframeValue(1, 0.4, 1, 40, progress);

          final squareScale = _keyframeValue(1, 0.5, 1, 50, progress);
          final squareRadiusFactor = _keyframeValue(0, 1, 0, 50, progress);

          final shadowScale = _keyframeValue(1, 0.5, 1, 50, progress);
          final shadowPulse = _keyframeValue(0, 1, 0, 50, progress);
          final shadowColor = Color.lerp(
            kColorLoaderShadowBase,
            kColorLoaderShadowPulse,
            shadowPulse,
          )!;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: canvasSize,
                height: canvasSize * 0.9,
                child: Transform.rotate(
                  angle: heartRotation,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Transform.rotate(
                        angle: -math.pi / 4,
                        child: Transform.scale(
                          scale: squareScale,
                          child: Container(
                            width: unit,
                            height: unit,
                            decoration: BoxDecoration(
                              color: heartColor,
                              borderRadius: BorderRadius.circular(
                                (squareRadiusFactor * unit / 2).clamp(
                                  0.0,
                                  unit / 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(leftTx, leftTy),
                        child: Transform.scale(
                          scale: leftScale,
                          child: _circle(unit, heartColor),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(rightTx, rightTy),
                        child: Transform.scale(
                          scale: rightScale,
                          child: _circle(unit, heartColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Transform.scale(
                scale: shadowScale,
                child: Container(
                  width: unit,
                  height: shadowHeight,
                  decoration: BoxDecoration(
                    color: shadowColor,
                    borderRadius: BorderRadius.circular(shadowHeight / 2),
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
