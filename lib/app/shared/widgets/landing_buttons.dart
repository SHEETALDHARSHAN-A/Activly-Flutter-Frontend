part of 'package:activly/activly_app.dart';

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.title,
    required this.icon,
    required this.onPressed,
    required this.arrowIcon,
    this.compact = false,
  });

  final String title;
  final Widget icon;
  final AsyncTapCallback onPressed;
  final IconData arrowIcon;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return _SweepButton(
      height: compact ? 40 : 44,
      radius: 12,
      onTap: onPressed,
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
  });

  final String label;
  final IconData icon;
  final IconData arrowIcon;
  final AsyncTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _GlassPillButton(
      onTap: onTap,
      radius: 999,
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
    required this.baseColor,
    required this.overlayColor,
    required this.shadowColor,
    required this.builder,
  });

  final double height;
  final double radius;
  final AsyncTapCallback onTap;
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

  Future<void> _handleTap() async {
    if (_loading) {
      return;
    }

    setState(() => _loading = true);
    await Future<void>.delayed(kButtonLoadingDuration);
    await widget.onTap();
    if (mounted) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      widthFactor: _hovered ? 1 : 0,
                      child: ColoredBox(color: widget.overlayColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Center(
                      child: _loading
                          ? const _BladeSpinner(size: 18)
                          : widget.builder(_hovered),
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
    required this.childBuilder,
  });

  final AsyncTapCallback onTap;
  final double radius;
  final Widget Function(bool hovered) childBuilder;

  @override
  State<_GlassPillButton> createState() => _GlassPillButtonState();
}

class _GlassPillButtonState extends State<_GlassPillButton> {
  bool _hovered = false;
  bool _loading = false;

  Future<void> _handleTap() async {
    if (_loading) {
      return;
    }

    setState(() => _loading = true);
    await Future<void>.delayed(kButtonLoadingDuration);
    await widget.onTap();
    if (mounted) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      tween: Tween<double>(begin: 0, end: _hovered ? 1 : 0),
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
                      child: _loading
                          ? const _BladeSpinner(size: 16)
                          : FittedBox(
                              fit: BoxFit.scaleDown,
                              child: widget.childBuilder(_hovered),
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
    final stroke = size * 0.22;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: 0.75,
              strokeWidth: stroke,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4285F4)),
              backgroundColor: Colors.transparent,
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: size * 0.52,
              height: stroke,
              color: Colors.white,
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: size * 0.35,
              height: stroke,
              color: const Color(0xFF4285F4),
            ),
          ),
          Positioned(
            left: size * 0.08,
            top: size * 0.12,
            child: SizedBox(
              width: size * 0.84,
              height: size * 0.84,
              child: CustomPaint(
                painter: _GoogleGArcsPainter(strokeWidth: stroke),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
