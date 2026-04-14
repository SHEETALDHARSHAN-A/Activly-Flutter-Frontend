part of 'package:activly/activly_app.dart';

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final AsyncTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _AsyncSegmentButton(label: label, selected: selected, onTap: onTap);
  }
}

class _AsyncSegmentButton extends StatefulWidget {
  const _AsyncSegmentButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final AsyncTapCallback onTap;

  @override
  State<_AsyncSegmentButton> createState() => _AsyncSegmentButtonState();
}

class _AsyncSegmentButtonState extends State<_AsyncSegmentButton> {
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
    return GestureDetector(
      onTap: _loading ? null : _handleTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: _loading
            ? const _BladeSpinner(size: 16)
            : Text(
                widget.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: widget.selected
                      ? Colors.black
                      : Colors.white.withValues(alpha: 0.70),
                ),
              ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.enabled = true,
  });

  final String label;
  final IconData icon;
  final AsyncTapCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return SizedBox(
        height: 44,
        child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white.withValues(alpha: 0.40),
            foregroundColor: Colors.black.withValues(alpha: 0.60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 8,
            shadowColor: Colors.black.withValues(alpha: 0.20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              Icon(icon, size: 18),
            ],
          ),
        ),
      );
    }

    return _SweepButton(
      height: 44,
      radius: 12,
      onTap: onTap,
      selected: false,
      baseColor: Colors.white,
      overlayColor: const Color(0xFF7C4CFF),
      shadowColor: Colors.black.withValues(alpha: 0.20),
      builder: (bool hovered) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: hovered ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            AnimatedSlide(
              duration: const Duration(milliseconds: 300),
              offset: hovered ? const Offset(0.1, 0) : Offset.zero,
              child: Icon(
                icon,
                size: 18,
                color: hovered ? Colors.white : Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LoadingTextButton extends StatefulWidget {
  const _LoadingTextButton({
    required this.label,
    required this.onTap,
    this.icon,
    this.enabled = true,
    this.style,
    this.textStyle,
  });

  final String label;
  final Widget? icon;
  final AsyncTapCallback onTap;
  final bool enabled;
  final ButtonStyle? style;
  final TextStyle? textStyle;

  @override
  State<_LoadingTextButton> createState() => _LoadingTextButtonState();
}

class _LoadingTextButtonState extends State<_LoadingTextButton> {
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
    final enabledTap = widget.enabled && !_loading;
    final style =
        widget.style ??
        TextButton.styleFrom(
          foregroundColor: Colors.white.withValues(alpha: 0.80),
        );

    if (_loading) {
      return TextButton(
        onPressed: null,
        style: style,
        child: const _BladeSpinner(size: 16),
      );
    }

    final labelWidget = Text(
      widget.label,
      style:
          widget.textStyle ??
          const TextStyle(
            decoration: TextDecoration.underline,
            decorationColor: Color(0xFF7C4CFF),
          ),
    );

    if (widget.icon != null) {
      return TextButton.icon(
        onPressed: enabledTap ? _handleTap : null,
        style: style,
        icon: widget.icon!,
        label: labelWidget,
      );
    }

    return TextButton(
      onPressed: enabledTap ? _handleTap : null,
      style: style,
      child: labelWidget,
    );
  }
}

class _LoadingOutlinedButtonIcon extends StatefulWidget {
  const _LoadingOutlinedButtonIcon({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final Widget icon;
  final AsyncTapCallback onTap;

  @override
  State<_LoadingOutlinedButtonIcon> createState() =>
      _LoadingOutlinedButtonIconState();
}

class _LoadingOutlinedButtonIconState extends State<_LoadingOutlinedButtonIcon> {
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
    return OutlinedButton(
      onPressed: _loading ? null : _handleTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(
          color: Colors.white.withValues(alpha: 0.30),
        ),
        backgroundColor: Colors.black.withValues(alpha: 0.45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        fixedSize: const Size(kTopControlWidth, kTopControlHeight),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: _loading
          ? const _BladeSpinner(size: 18)
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                widget.icon,
                const SizedBox(width: 8),
                Text(
                  widget.label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
    );
  }
}

class _LoadingLinkText extends StatefulWidget {
  const _LoadingLinkText({required this.text, required this.onTap});

  final String text;
  final AsyncTapCallback onTap;

  @override
  State<_LoadingLinkText> createState() => _LoadingLinkTextState();
}

class _LoadingLinkTextState extends State<_LoadingLinkText> {
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
    if (_loading) {
      return const _BladeSpinner(size: 16);
    }

    return GestureDetector(
      onTap: _handleTap,
      child: Text(
        widget.text,
        style: const TextStyle(
          color: Color(0xFF7C4CFF),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
