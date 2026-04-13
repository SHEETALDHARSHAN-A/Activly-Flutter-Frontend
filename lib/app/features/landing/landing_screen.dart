part of 'package:activly/activly_app.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({
    super.key,
    required this.language,
    required this.isLoaded,
    required this.t,
    required this.currentVideoIndex,
    required this.totalVideos,
    required this.onToggleLanguage,
    required this.onSelectVideo,
    required this.onContinueEmail,
    required this.onContinuePhone,
  });

  final AppLanguage language;
  final bool isLoaded;
  final TranslationCopy t;
  final int currentVideoIndex;
  final int totalVideos;
  final VoidCallback onToggleLanguage;
  final ValueChanged<int> onSelectVideo;
  final AsyncTapCallback onContinueEmail;
  final AsyncTapCallback onContinuePhone;

  @override
  Widget build(BuildContext context) {
    final isArabic = language == AppLanguage.ar;
    final arrowIcon = isArabic ? Icons.chevron_left : Icons.chevron_right;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 8,
              right: 16,
              child: _FadeSlide(
                visible: isLoaded,
                yOffset: 0,
                delay: const Duration(milliseconds: 1000),
                child: LanguageToggle(
                  language: language,
                  onToggle: onToggleLanguage,
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      final compact = constraints.maxHeight < 620;
                      final compactScale = compact ? 0.82 : 1.0;

                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24, 20, 24, 48),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  _FadeSlide(
                                    visible: isLoaded,
                                    yOffset: 0.15,
                                    delay: const Duration(milliseconds: 450),
                                    child: Image.asset(
                                      'assets/Activly-logo.png',
                                      width: compact ? 260 : 310,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(height: 18 * compactScale),
                                  _FadeSlide(
                                    visible: isLoaded,
                                    yOffset: 0.12,
                                    delay: const Duration(milliseconds: 500),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          t.taglineLine1,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: compact ? 14 : 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          t.taglineLine2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: compact ? 14 : 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 28 * compactScale),
                                  _FadeSlide(
                                    visible: isLoaded,
                                    yOffset: 0.25,
                                    delay: const Duration(milliseconds: 600),
                                    child: _SocialButton(
                                      title: t.continueWithGoogle,
                                      compact: compact,
                                      icon: const _GoogleBrandIcon(size: 20),
                                      onPressed: () async {},
                                      arrowIcon: arrowIcon,
                                    ),
                                  ),
                                  SizedBox(height: 12 * compactScale),
                                  _FadeSlide(
                                    visible: isLoaded,
                                    yOffset: 0.25,
                                    delay: const Duration(milliseconds: 700),
                                    child: _SocialButton(
                                      title: t.continueWithApple,
                                      compact: compact,
                                      icon: SvgPicture.asset(
                                        'assets/Apple_light.svg',
                                        width: 20,
                                        height: 20,
                                      ),
                                      onPressed: () async {},
                                      arrowIcon: arrowIcon,
                                    ),
                                  ),
                                  SizedBox(height: 14 * compactScale),
                                  _FadeSlide(
                                    visible: isLoaded,
                                    delay: const Duration(milliseconds: 800),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            color: Colors.white.withValues(
                                              alpha: 0.20,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Text(
                                            t.or,
                                            style: TextStyle(
                                              color: Colors.white.withValues(
                                                alpha: 0.55,
                                              ),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            color: Colors.white.withValues(
                                              alpha: 0.20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 14 * compactScale),
                                  _FadeSlide(
                                    visible: isLoaded,
                                    delay: const Duration(milliseconds: 900),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        _PillButton(
                                          label: t.email,
                                          icon: Icons.mail_outline,
                                          arrowIcon: arrowIcon,
                                          onTap: onContinueEmail,
                                        ),
                                        const SizedBox(width: 10),
                                        _PillButton(
                                          label: t.phone,
                                          icon: Icons.phone_outlined,
                                          arrowIcon: arrowIcon,
                                          onTap: onContinuePhone,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 8 * compactScale),
                                  _FadeSlide(
                                    visible: isLoaded,
                                    delay: const Duration(milliseconds: 1100),
                                    child: _LoadingTextButton(
                                      label: t.skipForNow,
                                      icon: Icon(arrowIcon, size: 18),
                                      onTap: () async {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: _FadeSlide(
                visible: isLoaded,
                yOffset: 0,
                delay: const Duration(milliseconds: 1200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(totalVideos, (index) {
                    final active = index == currentVideoIndex;
                    return GestureDetector(
                      onTap: () => onSelectVideo(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: active ? 24 : 8,
                        decoration: BoxDecoration(
                          color: active
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.40),
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FadeSlide extends StatelessWidget {
  const _FadeSlide({
    required this.visible,
    required this.child,
    this.yOffset = 0.08,
    this.delay = Duration.zero,
  });

  final bool visible;
  final Widget child;
  final double yOffset;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    final animationDuration = visible
        ? Duration(milliseconds: 650) + delay
        : const Duration(milliseconds: 380);

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: visible ? 1 : 0),
      duration: animationDuration,
      curve: Curves.easeOutCubic,
      child: child,
      builder: (BuildContext context, double value, Widget? child) {
        double effectiveValue;
        if (!visible || delay == Duration.zero) {
          effectiveValue = value;
        } else {
          final delayRatio =
              delay.inMicroseconds / animationDuration.inMicroseconds;
          if (value <= delayRatio) {
            effectiveValue = 0;
          } else {
            effectiveValue = ((value - delayRatio) / (1 - delayRatio)).clamp(
              0.0,
              1.0,
            );
          }
        }

        return Opacity(
          opacity: effectiveValue,
          child: Transform.translate(
            offset: Offset(0, (1 - effectiveValue) * (yOffset * 120)),
            child: child,
          ),
        );
      },
    );
  }
}
