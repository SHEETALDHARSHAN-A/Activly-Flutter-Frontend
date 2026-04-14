part of 'package:activly/activly_app.dart';

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.title,
    required this.icon,
    required this.onPressed,
    required this.arrowIcon,
    this.selected = false,
    this.compact = false,
  });

  final String title;
  final Widget icon;
  final AsyncTapCallback onPressed;
  final IconData arrowIcon;
  final bool selected;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return _SweepButton(
      height: compact ? 40 : 44,
      radius: 12,
      onTap: onPressed,
      selected: selected,
      baseColor: Colors.white,
      overlayColor: const Color(0xFF7C4CFF),
      shadowColor: Colors.black.withValues(alpha: 0.20),
      builder: (bool hovered) {
        return Row(
          children: <Widget>[
            icon,
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: hovered ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 8),
            AnimatedSlide(
              duration: const Duration(milliseconds: 300),
              offset: hovered ? Offset.zero : const Offset(0.5, 0),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: hovered ? 1 : 0,
                child: Icon(arrowIcon, size: 18, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.label,
    required this.icon,
    required this.arrowIcon,
    required this.onTap,
    this.selected = false,
  });

  final String label;
  final IconData icon;
  final IconData arrowIcon;
  final AsyncTapCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return _GlassPillButton(
      onTap: onTap,
      radius: 999,
      selected: selected,
      childBuilder: (bool hovered) {
        return Row(
          children: <Widget>[
            Icon(icon, size: 16, color: Colors.white),
            const SizedBox(width: 6),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 4),
            AnimatedSlide(
              duration: const Duration(milliseconds: 300),
              offset: hovered ? const Offset(0.25, 0) : Offset.zero,
              child: Icon(
                arrowIcon,
                size: 16,
                color: Colors.white.withValues(alpha: 0.90),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SweepButton extends StatefulWidget {
  const _SweepButton({
    required this.height,
    required this.radius,
    required this.onTap,
    required this.selected,
    required this.baseColor,
    required this.overlayColor,
    required this.shadowColor,
    required this.builder,
  });

  final double height;
  final double radius;
  final AsyncTapCallback onTap;
  final bool selected;
  final Color baseColor;
  final Color overlayColor;
  final Color shadowColor;
  final Widget Function(bool hovered) builder;

  @override
  State<_SweepButton> createState() => _SweepButtonState();
}

class _SweepButtonState extends State<_SweepButton> {
  bool _hovered = false;
  bool _loading = false;
  bool _pressed = false;
  bool _showLoader = false;

  Future<void> _handleTap() async {
    if (_loading) {
      return;
    }

    setState(() {
      _loading = true;
      _pressed = true;
      _hovered = true;
      _showLoader = false;
    });

    await Future<void>.delayed(kButtonFillDuration);

    if (!mounted) {
      return;
    }

    final operation = widget.onTap();

    if (!mounted) {
      return;
    }

    await Future<void>.delayed(kButtonLoaderRevealDelay);
    if (mounted && _loading) {
      setState(() => _showLoader = true);
    }

    await operation;
    if (mounted) {
      setState(() {
        _loading = false;
        _pressed = false;
        _showLoader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final active = _hovered || _pressed || widget.selected;

    return SizedBox(
      width: double.infinity,
      height: widget.height,
      child: MouseRegion(
        onEnter: (_) {
          if (!_loading) {
            setState(() => _hovered = true);
          }
        },
        onExit: (_) => setState(() => _hovered = false),
        child: Material(
          color: widget.baseColor,
          shadowColor: widget.shadowColor,
          borderRadius: BorderRadius.circular(widget.radius),
          elevation: 8,
          child: InkWell(
            onTap: _loading ? null : _handleTap,
            borderRadius: BorderRadius.circular(widget.radius),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.radius),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Positioned.fill(
                    child: AnimatedFractionallySizedBox(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      alignment: Alignment.centerLeft,
                      widthFactor: active ? 1 : 0,
                      child: ColoredBox(color: widget.overlayColor),
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Center(
                        child: _loading && _showLoader
                            ? const _BladeSpinner(size: 24, color: Colors.white)
                            : widget.builder(active),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassPillButton extends StatefulWidget {
  const _GlassPillButton({
    required this.onTap,
    required this.radius,
    required this.selected,
    required this.childBuilder,
  });

  final AsyncTapCallback onTap;
  final double radius;
  final bool selected;
  final Widget Function(bool hovered) childBuilder;

  @override
  State<_GlassPillButton> createState() => _GlassPillButtonState();
}

class _GlassPillButtonState extends State<_GlassPillButton> {
  bool _hovered = false;
  bool _loading = false;
  bool _pressed = false;
  bool _showLoader = false;

  Future<void> _handleTap() async {
    if (_loading) {
      return;
    }

    setState(() {
      _loading = true;
      _pressed = true;
      _hovered = true;
      _showLoader = false;
    });

    await Future<void>.delayed(kButtonFillDuration);

    if (!mounted) {
      return;
    }

    final operation = widget.onTap();

    if (!mounted) {
      return;
    }

    await Future<void>.delayed(kButtonLoaderRevealDelay);
    if (mounted && _loading) {
      setState(() => _showLoader = true);
    }

    await operation;
    if (mounted) {
      setState(() {
        _loading = false;
        _pressed = false;
        _showLoader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final active = _hovered || _pressed || widget.selected;

    return MouseRegion(
      onEnter: (_) {
        if (!_loading) {
          setState(() => _hovered = true);
        }
      },
      onExit: (_) => setState(() => _hovered = false),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _loading ? null : _handleTap,
          borderRadius: BorderRadius.circular(widget.radius),
          child: Container(
            height: 40,
            constraints: const BoxConstraints(minWidth: 120),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
              borderRadius: BorderRadius.circular(widget.radius),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.radius),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                        begin: 0,
                        end: active ? 1 : 0,
                      ),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      builder:
                          (BuildContext context, double factor, Widget? child) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: factor,
                            heightFactor: 1,
                            alignment: Alignment.centerLeft,
                            child: child,
                          ),
                        );
                      },
                      child: const ColoredBox(color: Color(0xFF7C4CFF)),
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Center(
                        child: _loading && _showLoader
                            ? const _BladeSpinner(size: 22, color: Colors.white)
                            : FittedBox(
                                fit: BoxFit.scaleDown,
                                child: widget.childBuilder(active),
                              ),
                     ),
                   ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GoogleBrandIcon extends StatelessWidget {
  const _GoogleBrandIcon({this.size = 20});

  final double size;

  @override
  Widget build(BuildContext context) {
    final fallbackStroke = size * 0.22;

    return SvgPicture.asset(
      'assets/google.svg',
      width: size,
      height: size,
      fit: BoxFit.contain,
      placeholderBuilder: (BuildContext context) {
        return SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _GoogleGArcsPainter(strokeWidth: fallbackStroke),
          ),
        );
      },
    );
  }
}
