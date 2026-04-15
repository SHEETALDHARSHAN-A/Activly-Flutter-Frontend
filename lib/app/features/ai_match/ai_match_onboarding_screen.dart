part of 'package:activly/activly_app.dart';

const Color _kAiPageBackground = kAiColorPageBackground;
const Color _kAiBackdropOrbPrimary = kAiColorBackdropOrbPrimary;
const Color _kAiBackdropOrbWarm = kAiColorBackdropOrbWarm;
const Color _kAiCardBackground = kAiColorSurface;
const Color _kAiCardBorder = kAiColorSurfaceBorder;
const Color _kAiMutedText = kAiColorTextMutedDark;
const Color _kAiPrimaryText = kAiColorTextDark;
const Color _kAiSurfaceContainer = kAiColorSurfaceContainerLight;
const Color _kAiInputBorder = kAiColorInputBorderLight;
const Color _kAiInputFill = kAiColorInputFillLight;
const Color _kAiWavePurple = kAiColorPrimaryAccent;
const Color _kAiProgressInactive = kAiColorProgressInactive;
const Color _kAiProgressTrack = kAiColorProgressTrack;
const Color _kAiBubbleBorder = kAiColorBubbleBorder;
const Color _kAiBottomNavBackground = kAiColorBottomNavBackgroundLight;
const Color _kAiBottomNavBorder = kAiColorBottomNavBorderLight;
const Color _kAiBottomNavInactive = kAiColorBottomNavInactiveLight;

const Color _kAiDarkPageBackground = Color(0xFF0A0F18);
const Color _kAiDarkBackdropOrbPrimary = Color(0xFF33245C);
const Color _kAiDarkBackdropOrbWarm = Color(0xFF264157);
const Color _kAiDarkCardBackground = Color(0xAA141E30);
const Color _kAiDarkCardBorder = Color(0x66BFCDEA);
const Color _kAiDarkMutedText = Color(0xFFAEBBD2);
const Color _kAiDarkPrimaryText = Color(0xFFF5F8FF);
const Color _kAiDarkSurfaceContainer = Color(0x66223149);
const Color _kAiDarkInputBorder = Color(0x66A0B1D1);
const Color _kAiDarkInputFill = Color(0xAA101A2C);
const Color _kAiDarkWave = Color(0xFFAA8DFF);
const Color _kAiDarkProgressInactive = Color(0x55495A79);
const Color _kAiDarkProgressTrack = Color(0x66495A79);
const Color _kAiDarkBubbleBorder = Color(0x6693A6C9);
const Color _kAiDarkBottomNavBackground = Color(0xE6141D2F);
const Color _kAiDarkBottomNavBorder = Color(0x6652668B);
const Color _kAiDarkBottomNavInactive = Color(0xFFA1B2D1);
const Color _kAiGlassLight = Color(0x66FFFFFF);
const Color _kAiGlassDark = Color(0x55203355);
const Color _kAiGlassBorderLight = Color(0xA3FFFFFF);
const Color _kAiGlassBorderDark = Color(0x80D8E1FF);

bool _aiIsDark(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

Color _aiPageBackground(BuildContext context) =>
    _aiIsDark(context) ? _kAiDarkPageBackground : _kAiPageBackground;

Color _aiBackdropOrbPrimary(BuildContext context) =>
    _aiIsDark(context) ? _kAiDarkBackdropOrbPrimary : _kAiBackdropOrbPrimary;

Color _aiBackdropOrbWarm(BuildContext context) =>
    _aiIsDark(context) ? _kAiDarkBackdropOrbWarm : _kAiBackdropOrbWarm;

Color _aiCardBackground(BuildContext context) =>
    _aiIsDark(context) ? _kAiDarkCardBackground : _kAiCardBackground;

Color _aiCardBorder(BuildContext context) =>
    _aiIsDark(context) ? _kAiDarkCardBorder : _kAiCardBorder;

Color _aiMutedText(BuildContext context) =>
    _aiIsDark(context) ? _kAiDarkMutedText : _kAiMutedText;

Color _aiPrimaryText(BuildContext context) =>
    _aiIsDark(context) ? _kAiDarkPrimaryText : _kAiPrimaryText;

Color _aiSurfaceContainer(BuildContext context) =>
    _aiIsDark(context) ? _kAiDarkSurfaceContainer : _kAiSurfaceContainer;

Color _aiInputBorder(BuildContext context) =>
    _aiIsDark(context) ? _kAiDarkInputBorder : _kAiInputBorder;

Color _aiInputFill(BuildContext context) =>
    _aiIsDark(context) ? _kAiDarkInputFill : _kAiInputFill;

Color _aiWaveColor(BuildContext context) =>
    _aiIsDark(context) ? _kAiDarkWave : _kAiWavePurple;

Color _aiProgressInactive(BuildContext context) =>
    _aiIsDark(context) ? _kAiDarkProgressInactive : _kAiProgressInactive;

Color _aiProgressTrack(BuildContext context) =>
    _aiIsDark(context) ? _kAiDarkProgressTrack : _kAiProgressTrack;

Color _aiProgressActive(BuildContext context) => kColorLoaderHeart;

Color _aiBubbleBorder(BuildContext context) =>
    _aiIsDark(context) ? _kAiDarkBubbleBorder : _kAiBubbleBorder;

Color _aiBottomNavBackground(BuildContext context) =>
    _aiIsDark(context) ? _kAiDarkBottomNavBackground : _kAiBottomNavBackground;

Color _aiBottomNavBorder(BuildContext context) =>
    _aiIsDark(context) ? _kAiDarkBottomNavBorder : _kAiBottomNavBorder;

Color _aiBottomNavInactive(BuildContext context) =>
    _aiIsDark(context) ? _kAiDarkBottomNavInactive : _kAiBottomNavInactive;

Color _aiGlassColor(BuildContext context) =>
    _aiIsDark(context) ? _kAiGlassDark : _kAiGlassLight;

Color _aiGlassBorderColor(BuildContext context) =>
    _aiIsDark(context) ? _kAiGlassBorderDark : _kAiGlassBorderLight;

class AiMatchOnboardingScreen extends StatefulWidget {
  const AiMatchOnboardingScreen({
    super.key,
    required this.language,
    required this.t,
    required this.onToggleLanguage,
    this.onSkip,
    this.onBack,
    this.isInAppMode = false,
    this.showBottomNavInAppMode = true,
  });

  final AppLanguage language;
  final TranslationCopy t;
  final VoidCallback onToggleLanguage;
  final VoidCallback? onSkip;
  final VoidCallback? onBack;
  final bool isInAppMode;
  final bool showBottomNavInAppMode;

  @override
  State<AiMatchOnboardingScreen> createState() =>
      _AiMatchOnboardingScreenState();
}

class _AiMatchOnboardingScreenState extends State<AiMatchOnboardingScreen> {
  bool _isDarkMode = false;
  bool _chatMode = true;
  int _selectedEnergy = -1;
  bool _isPageReady = false;
  bool _showInitialOverlay = false;
  bool _initialOverlayVisible = false;

  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _childAgeController = TextEditingController(
    text: '6',
  );
  final TextEditingController _goalsController = TextEditingController();

  Timer? _initialOverlayDelayTimer;

  @override
  void initState() {
    super.initState();
    _isDarkMode =
        WidgetsBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark;

    _childAgeController.addListener(_onFormChanged);
    _goalsController.addListener(_onFormChanged);

    _initialOverlayDelayTimer = Timer(const Duration(milliseconds: 120), () {
      if (!mounted || _isPageReady) {
        return;
      }
      setState(() {
        _showInitialOverlay = true;
        _initialOverlayVisible = true;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _isPageReady = true;
      _initialOverlayDelayTimer?.cancel();
      if (_showInitialOverlay && _initialOverlayVisible) {
        setState(() => _initialOverlayVisible = false);
      }
    });
  }

  void _onFormChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  int get _currentStep {
    final hasAge = _childAgeController.text.trim().isNotEmpty;
    final hasGoals = _goalsController.text.trim().isNotEmpty;

    if (!_chatMode && hasAge && hasGoals) {
      return 3;
    }
    if (_selectedEnergy >= 0 || (!_chatMode && hasAge)) {
      return 2;
    }
    return 1;
  }

  void _handleBack() {
    if (widget.onBack != null) {
      widget.onBack!();
      return;
    }
    Navigator.of(context).maybePop();
  }

  void _handleSkip() {
    if (widget.onSkip != null) {
      widget.onSkip!();
      return;
    }
    Navigator.of(context).maybePop();
  }

  @override
  void dispose() {
    _initialOverlayDelayTimer?.cancel();
    _childAgeController.removeListener(_onFormChanged);
    _goalsController.removeListener(_onFormChanged);
    _messageController.dispose();
    _childAgeController.dispose();
    _goalsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = widget.language == AppLanguage.ar;
    final title = isArabic ? 'مطابقة ذكية' : 'AI Match';
    final subtitle = isArabic
        ? 'اختر وضع الدردشة او املأ التفاصيل للوصول الى تطابق ادق.'
        : 'Pick chat or fill details to generate a better activity match.';

    final showBottomNav = widget.isInAppMode && widget.showBottomNavInAppMode;
    final showBackButton = !widget.isInAppMode && widget.onBack != null;
    final showSkipButton = !widget.isInAppMode && widget.onSkip != null;

    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final contentBottomPadding = showBottomNav ? 210.0 : 144.0 + bottomInset;
    final inputBottomOffset = showBottomNav ? 76.0 : 12.0 + bottomInset;
    final waveBottomOffset = showBottomNav ? 76.0 : 0.0;

    final localTheme = Theme.of(
      context,
    ).copyWith(brightness: _isDarkMode ? Brightness.dark : Brightness.light);

    return Theme(
      data: localTheme,
      child: Builder(
        builder: (BuildContext themedContext) {
          return Directionality(
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            child: SafeArea(
              top: false,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: _aiPageBackground(themedContext),
                ),
                child: Stack(
                  children: <Widget>[
                    const Positioned.fill(child: _AiAmbientBackground()),
                    Positioned.fill(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 430),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                20,
                                kFixedTopSpace + kTopControlHeight + 34,
                                20,
                                contentBottomPadding,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  _AiModeToggle(
                                    isArabic: isArabic,
                                    chatSelected: _chatMode,
                                    onSelectChat: () =>
                                        setState(() => _chatMode = true),
                                    onSelectDetails: () =>
                                        setState(() => _chatMode = false),
                                  ),
                                  const SizedBox(height: 12),
                                  _AiThreeStepProgressBar(
                                    isArabic: isArabic,
                                    currentStep: _currentStep,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    subtitle,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      height: 1.4,
                                      color: _aiMutedText(themedContext),
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 250),
                                    switchInCurve: Curves.easeOut,
                                    switchOutCurve: Curves.easeIn,
                                    child: _chatMode
                                        ? _AiChatPanel(
                                            key: const ValueKey<String>(
                                              'chat-mode',
                                            ),
                                            isArabic: isArabic,
                                            selectedEnergy: _selectedEnergy,
                                            onSelectEnergy: (int index) {
                                              setState(
                                                () => _selectedEnergy = index,
                                              );
                                            },
                                          )
                                        : _AiDetailsPanel(
                                            key: const ValueKey<String>(
                                              'details-mode',
                                            ),
                                            isArabic: isArabic,
                                            ageController: _childAgeController,
                                            goalsController: _goalsController,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: kFixedTopSpace + kTopControlsVerticalOffset,
                      left: kTopControlsSidePadding,
                      right: kTopControlsSidePadding,
                      child: _AiTopBar(
                        title: title,
                        skipLabel: widget.t.skipForNow,
                        isArabic: isArabic,
                        language: widget.language,
                        isDarkMode: _isDarkMode,
                        showBackButton: showBackButton,
                        showSkipButton: showSkipButton,
                        onBack: _handleBack,
                        onSkip: _handleSkip,
                        onToggleLanguage: widget.onToggleLanguage,
                        onToggleTheme: () {
                          setState(() => _isDarkMode = !_isDarkMode);
                        },
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: waveBottomOffset,
                      child: IgnorePointer(
                        child: SizedBox(height: 146, child: _AiBottomWave()),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: inputBottomOffset,
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 420),
                          child: _AiChatInput(
                            isArabic: isArabic,
                            controller: _messageController,
                          ),
                        ),
                      ),
                    ),
                    if (showBottomNav)
                      const Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: _AiBottomNav(),
                      ),
                    if (_showInitialOverlay)
                      Positioned.fill(
                        child: IgnorePointer(
                          ignoring: !_initialOverlayVisible,
                          child: AnimatedOpacity(
                            opacity: _initialOverlayVisible ? 1 : 0,
                            duration: const Duration(milliseconds: 260),
                            curve: Curves.easeOutCubic,
                            onEnd: () {
                              if (!mounted) {
                                return;
                              }
                              if (!_initialOverlayVisible &&
                                  _showInitialOverlay) {
                                setState(() => _showInitialOverlay = false);
                              }
                            },
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: _AiOnboardingSkeleton(
                                    isInAppMode: widget.isInAppMode,
                                    contentBottomPadding: contentBottomPadding,
                                    inputBottomOffset: inputBottomOffset,
                                    waveBottomOffset: waveBottomOffset,
                                    showBottomNav: showBottomNav,
                                  ),
                                ),
                                Positioned.fill(
                                  child: LoadingOverlay(
                                    isVisible: true,
                                    showBrandImage: false,
                                    backgroundColor: _aiIsDark(themedContext)
                                        ? kColorBlack.withValues(alpha: 0.24)
                                        : kColorBlack.withValues(alpha: 0.10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AiGlassPanel extends StatelessWidget {
  const _AiGlassPanel({
    required this.child,
    this.padding,
    this.radius = 18,
    this.backgroundColor,
    this.borderColor,
    this.boxShadow,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final Color? backgroundColor;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    final panelRadius = BorderRadius.circular(radius);
    final rawBackground = backgroundColor ?? _aiGlassColor(context);
    // Backdrop blur on Flutter web can trigger unstable WebGL offscreen surfaces.
    final resolvedBackground = kIsWeb
        ? rawBackground.withValues(alpha: _aiIsDark(context) ? 0.92 : 0.96)
        : rawBackground;

    final panel = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: resolvedBackground,
        borderRadius: panelRadius,
        border: Border.all(color: borderColor ?? _aiGlassBorderColor(context)),
        boxShadow: boxShadow,
      ),
      child: child,
    );

    if (kIsWeb) {
      return ClipRRect(borderRadius: panelRadius, child: panel);
    }

    return ClipRRect(
      borderRadius: panelRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: panel,
      ),
    );
  }
}

class _AiTopBar extends StatelessWidget {
  const _AiTopBar({
    required this.title,
    required this.skipLabel,
    required this.isArabic,
    required this.language,
    required this.isDarkMode,
    required this.showBackButton,
    required this.showSkipButton,
    required this.onBack,
    required this.onSkip,
    required this.onToggleLanguage,
    required this.onToggleTheme,
  });

  final String title;
  final String skipLabel;
  final bool isArabic;
  final AppLanguage language;
  final bool isDarkMode;
  final bool showBackButton;
  final bool showSkipButton;
  final VoidCallback onBack;
  final VoidCallback onSkip;
  final VoidCallback onToggleLanguage;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: _aiPrimaryText(context),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: showBackButton
                ? _AiTopIconButton(isArabic: isArabic, onTap: onBack)
                : const SizedBox(width: 40, height: 40),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: showSkipButton
                ? _AiTopSkipButton(label: skipLabel, onTap: onSkip)
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _AiThemeToggleButton(
                        isDarkMode: isDarkMode,
                        onTap: onToggleTheme,
                      ),
                      const SizedBox(width: 8),
                      LanguageToggle(
                        language: language,
                        onToggle: onToggleLanguage,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _AiThemeToggleButton extends StatelessWidget {
  const _AiThemeToggleButton({required this.isDarkMode, required this.onTap});

  final bool isDarkMode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _aiGlassColor(context),
            shape: BoxShape.circle,
            border: Border.all(color: _aiGlassBorderColor(context)),
          ),
          child: Icon(
            isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            size: 18,
            color: _aiPrimaryText(context),
          ),
        ),
      ),
    );
  }
}

class _AiTopIconButton extends StatelessWidget {
  const _AiTopIconButton({required this.isArabic, required this.onTap});

  final bool isArabic;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _aiGlassColor(context),
            shape: BoxShape.circle,
            border: Border.all(color: _aiGlassBorderColor(context)),
          ),
          child: Icon(
            isArabic ? Icons.chevron_right_rounded : Icons.chevron_left_rounded,
            size: 28,
            color: _aiPrimaryText(context),
          ),
        ),
      ),
    );
  }
}

class _AiTopSkipButton extends StatelessWidget {
  const _AiTopSkipButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: _aiPrimaryText(context),
          backgroundColor: _aiGlassColor(context),
          side: BorderSide(color: _aiGlassBorderColor(context)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _AiThreeStepProgressBar extends StatelessWidget {
  const _AiThreeStepProgressBar({
    required this.isArabic,
    required this.currentStep,
  });

  final bool isArabic;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    int activeSegments = 5;
    if (currentStep <= 1) {
      activeSegments = 1;
    } else if (currentStep == 2) {
      activeSegments = 3;
    }

    return _AiGlassPanel(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      radius: 18,
      boxShadow: const <BoxShadow>[
        BoxShadow(
          blurRadius: 24,
          spreadRadius: -18,
          offset: Offset(0, 10),
          color: kAiShadowMedium,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: List<Widget>.generate(5, (int index) {
              final active = index < activeSegments;

              return Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(end: index == 4 ? 0 : 8),
                  child: Container(
                    height: 14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: _aiProgressTrack(context),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: AnimatedAlign(
                        duration: const Duration(milliseconds: 260),
                        curve: Curves.easeOut,
                        alignment: AlignmentDirectional.centerStart,
                        child: FractionallySizedBox(
                          widthFactor: active ? 1 : 0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                              color: active
                                  ? _aiProgressActive(context)
                                  : _aiProgressInactive(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          Text(
            isArabic ? 'قائمة بدء الاستخدام' : 'Getting Started Checklist',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
              color: _aiMutedText(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _AiModeToggle extends StatelessWidget {
  const _AiModeToggle({
    required this.isArabic,
    required this.chatSelected,
    required this.onSelectChat,
    required this.onSelectDetails,
  });

  final bool isArabic;
  final bool chatSelected;
  final VoidCallback onSelectChat;
  final VoidCallback onSelectDetails;

  @override
  Widget build(BuildContext context) {
    final chatLabel = isArabic ? 'الدردشة' : 'Chat';
    final detailsLabel = isArabic ? 'ادخل التفاصيل' : 'Fill Details';

    return _AiGlassPanel(
      padding: const EdgeInsets.all(5),
      radius: 18,
      backgroundColor: _aiSurfaceContainer(context).withValues(alpha: 0.76),
      borderColor: _aiCardBorder(context),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _AiModeToggleButton(
              label: chatLabel,
              selected: chatSelected,
              onTap: onSelectChat,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _AiModeToggleButton(
              label: detailsLabel,
              selected: !chatSelected,
              onTap: onSelectDetails,
            ),
          ),
        ],
      ),
    );
  }
}

class _AiModeToggleButton extends StatelessWidget {
  const _AiModeToggleButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          alignment: Alignment.center,
          height: 43,
          decoration: BoxDecoration(
            color: selected ? _aiCardBackground(context) : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: selected
                ? Border.all(color: _aiGlassBorderColor(context))
                : Border.all(color: Colors.transparent),
            boxShadow: selected
                ? const <BoxShadow>[
                    BoxShadow(
                      blurRadius: 20,
                      spreadRadius: -18,
                      offset: Offset(0, 12),
                      color: kAiShadowMedium,
                    ),
                  ]
                : const <BoxShadow>[],
          ),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: selected ? FontWeight.w800 : FontWeight.w700,
              color: selected ? kAiColorPrimary : _aiMutedText(context),
            ),
          ),
        ),
      ),
    );
  }
}

class _AiChatPanel extends StatelessWidget {
  const _AiChatPanel({
    super.key,
    required this.isArabic,
    required this.selectedEnergy,
    required this.onSelectEnergy,
  });

  final bool isArabic;
  final int selectedEnergy;
  final ValueChanged<int> onSelectEnergy;

  @override
  Widget build(BuildContext context) {
    final optionTexts = isArabic
        ? const <String>['طاقة عالية', 'تركيز وهدوء', 'مزيج متوازن']
        : const <String>['High Energy', 'Focused and Quiet', 'A Bit of Both'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _AiCoachBubble(
          text: isArabic
              ? 'اهلا! انا مساعد Activly. كم عمر طفلك الآن؟'
              : 'Hi! I am your Activly Coach. How old is your child now?',
        ),
        const SizedBox(height: 12),
        _AiUserBubble(
          text: isArabic ? 'عمره 6 سنوات.' : 'He just turned 6 last month.',
        ),
        const SizedBox(height: 12),
        _AiCoachBubble(
          text: isArabic
              ? 'رائع. ما مستوى طاقته غالبا؟'
              : 'Great. What is the usual energy level?',
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 48),
          child: Column(
            children: List<Widget>.generate(optionTexts.length, (int index) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == optionTexts.length - 1 ? 0 : 10,
                ),
                child: _AiChoiceButton(
                  label: optionTexts[index],
                  selected: selectedEnergy == index,
                  onTap: () => onSelectEnergy(index),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _AiCoachBubble extends StatelessWidget {
  const _AiCoachBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: <Color>[kAiColorAvatarStart, kAiColorAvatarEnd],
            ),
            border: Border.all(color: kAiColorPrimary.withValues(alpha: 0.14)),
          ),
          child: const Icon(
            Icons.auto_awesome,
            color: kAiColorPrimary,
            size: 18,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _AiGlassPanel(
            padding: const EdgeInsets.all(14),
            radius: 20,
            backgroundColor: _aiCardBackground(context),
            borderColor: _aiBubbleBorder(context),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                blurRadius: 20,
                spreadRadius: -18,
                offset: Offset(0, 12),
                color: kAiShadowMedium,
              ),
            ],
            child: Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                color: _aiPrimaryText(context),
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.35,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AiUserBubble extends StatelessWidget {
  const _AiUserBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.all(14),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: <Color>[kAiColorPrimaryAccent, kAiColorPrimary],
          ),
          borderRadius: BorderRadius.circular(
            20,
          ).copyWith(topRight: const Radius.circular(6)),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              blurRadius: 28,
              spreadRadius: -20,
              offset: Offset(0, 14),
              color: kAiShadowPurple,
            ),
          ],
        ),
        child: Text(
          text,
          style: GoogleFonts.plusJakartaSans(
            color: kColorWhite,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}

class _AiChoiceButton extends StatelessWidget {
  const _AiChoiceButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: _AiGlassPanel(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          radius: 16,
          backgroundColor: _aiCardBackground(context),
          borderColor: selected ? kAiColorPrimary : _aiCardBorder(context),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              blurRadius: 20,
              spreadRadius: -18,
              offset: Offset(0, 12),
              color: kAiShadowMedium,
            ),
          ],
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _aiPrimaryText(context),
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: selected
                    ? kAiColorPrimary
                    : kAiColorPrimary.withValues(alpha: 0.38),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AiDetailsPanel extends StatelessWidget {
  const _AiDetailsPanel({
    super.key,
    required this.isArabic,
    required this.ageController,
    required this.goalsController,
  });

  final bool isArabic;
  final TextEditingController ageController;
  final TextEditingController goalsController;

  @override
  Widget build(BuildContext context) {
    final ageLabel = isArabic ? 'عمر الطفل' : 'Child Age';
    final goalsLabel = isArabic ? 'الهدف الرئيسي' : 'Main Goal';
    final goalsHint = isArabic
        ? 'مثال: نشاط اجتماعي او تركيز'
        : 'Example: social confidence or focus';
    final cta = isArabic ? 'توليد التطابقات' : 'Generate Matches';

    return _AiGlassPanel(
      padding: const EdgeInsets.all(16),
      radius: 22,
      backgroundColor: _aiCardBackground(context),
      borderColor: _aiCardBorder(context),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          blurRadius: 26,
          spreadRadius: -20,
          offset: Offset(0, 12),
          color: kAiShadowMedium,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _AiField(
            label: ageLabel,
            controller: ageController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          _AiField(
            label: goalsLabel,
            controller: goalsController,
            hintText: goalsHint,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 46,
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: kAiColorPrimary,
                foregroundColor: kColorWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.auto_awesome, size: 18),
              label: Text(
                cta,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AiField extends StatelessWidget {
  const _AiField({
    required this.label,
    required this.controller,
    this.hintText,
    this.keyboardType,
  });

  final String label;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.plusJakartaSans(
        color: _aiPrimaryText(context),
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: GoogleFonts.plusJakartaSans(
          color: _aiMutedText(context),
          fontWeight: FontWeight.w600,
        ),
        hintStyle: GoogleFonts.plusJakartaSans(
          color: _aiMutedText(context).withValues(alpha: 0.75),
        ),
        filled: true,
        fillColor: _aiInputFill(context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: _aiInputBorder(context)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: _aiInputBorder(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: kAiColorPrimary),
        ),
      ),
    );
  }
}

class _AiChatInput extends StatelessWidget {
  const _AiChatInput({required this.isArabic, required this.controller});

  final bool isArabic;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return _AiGlassPanel(
      radius: 999,
      backgroundColor: _aiCardBackground(context),
      borderColor: _aiCardBorder(context),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          blurRadius: 30,
          spreadRadius: -18,
          offset: Offset(0, 14),
          color: kAiShadowInput,
        ),
      ],
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              style: GoogleFonts.plusJakartaSans(
                color: _aiPrimaryText(context),
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: isArabic ? 'اكتب رسالتك...' : 'Type your message...',
                hintStyle: GoogleFonts.plusJakartaSans(
                  color: _aiMutedText(context),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Material(
              color: kAiColorPrimary,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: () {},
                customBorder: const CircleBorder(),
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(Icons.send_rounded, size: 20, color: kColorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AiOnboardingSkeleton extends StatefulWidget {
  const _AiOnboardingSkeleton({
    required this.isInAppMode,
    required this.contentBottomPadding,
    required this.inputBottomOffset,
    required this.waveBottomOffset,
    required this.showBottomNav,
  });

  final bool isInAppMode;
  final double contentBottomPadding;
  final double inputBottomOffset;
  final double waveBottomOffset;
  final bool showBottomNav;

  @override
  State<_AiOnboardingSkeleton> createState() => _AiOnboardingSkeletonState();
}

class _AiOnboardingSkeletonState extends State<_AiOnboardingSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 920),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;

    return AnimatedBuilder(
      animation: _pulseController,
      builder: (BuildContext context, Widget? child) {
        final pulse = Curves.easeInOut.transform(_pulseController.value);
        final baseColor = Color.lerp(
          _aiCardBorder(context),
          _aiSurfaceContainer(context),
          pulse,
        )!;
        final strongColor = Color.lerp(
          _aiCardBorder(context),
          _aiMutedText(context).withValues(alpha: 0.22),
          pulse,
        )!;

        return DecoratedBox(
          decoration: BoxDecoration(color: _aiPageBackground(context)),
          child: Stack(
            children: <Widget>[
              const Positioned.fill(child: _AiAmbientBackground()),
              Positioned.fill(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 430),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          20,
                          kFixedTopSpace + kTopControlHeight + 34,
                          20,
                          widget.contentBottomPadding,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            _AiSkeletonBlock(
                              height: 54,
                              radius: 18,
                              color: baseColor,
                            ),
                            const SizedBox(height: 12),
                            _AiSkeletonBlock(
                              height: 72,
                              radius: 18,
                              color: baseColor,
                            ),
                            const SizedBox(height: 12),
                            Align(
                              child: _AiSkeletonBlock(
                                width: 262,
                                height: 12,
                                radius: 8,
                                color: strongColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              child: _AiSkeletonBlock(
                                width: 216,
                                height: 12,
                                radius: 8,
                                color: strongColor,
                              ),
                            ),
                            const SizedBox(height: 18),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _AiSkeletonBlock(
                                  width: 40,
                                  height: 40,
                                  radius: 20,
                                  color: strongColor,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _AiSkeletonBlock(
                                    height: 72,
                                    radius: 20,
                                    color: baseColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: _AiSkeletonBlock(
                                width: 250,
                                height: 56,
                                radius: 20,
                                color: strongColor,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _AiSkeletonBlock(
                                  width: 40,
                                  height: 40,
                                  radius: 20,
                                  color: strongColor,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _AiSkeletonBlock(
                                    height: 68,
                                    radius: 20,
                                    color: baseColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                start: 48,
                              ),
                              child: Column(
                                children: <Widget>[
                                  _AiSkeletonBlock(
                                    height: 48,
                                    radius: 16,
                                    color: baseColor,
                                  ),
                                  const SizedBox(height: 10),
                                  _AiSkeletonBlock(
                                    height: 48,
                                    radius: 16,
                                    color: baseColor,
                                  ),
                                  const SizedBox(height: 10),
                                  _AiSkeletonBlock(
                                    height: 48,
                                    radius: 16,
                                    color: baseColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: kFixedTopSpace + kTopControlsVerticalOffset,
                left: kTopControlsSidePadding,
                right: kTopControlsSidePadding,
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 40, height: 40),
                    Expanded(
                      child: Align(
                        child: _AiSkeletonBlock(
                          width: 130,
                          height: 22,
                          radius: 8,
                          color: strongColor,
                        ),
                      ),
                    ),
                    _AiSkeletonBlock(
                      width: widget.isInAppMode ? 126 : 80,
                      height: 32,
                      radius: 16,
                      color: strongColor,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: widget.waveBottomOffset,
                child: IgnorePointer(
                  child: SizedBox(height: 146, child: _AiBottomWave()),
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: widget.inputBottomOffset,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: _AiSkeletonBlock(
                      height: 54,
                      radius: 999,
                      color: strongColor,
                    ),
                  ),
                ),
              ),
              if (widget.showBottomNav)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _AiBottomNavSkeleton(
                    color: strongColor,
                    bottomInset: bottomInset,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _AiSkeletonBlock extends StatelessWidget {
  const _AiSkeletonBlock({
    required this.height,
    required this.radius,
    required this.color,
    this.width,
  });

  final double? width;
  final double height;
  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

class _AiBottomNavSkeleton extends StatelessWidget {
  const _AiBottomNavSkeleton({required this.color, required this.bottomInset});

  final Color color;
  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 10, 12, math.max(12, bottomInset)),
      decoration: BoxDecoration(
        color: _aiBottomNavBackground(context),
        border: Border(top: BorderSide(color: _aiBottomNavBorder(context))),
      ),
      child: Row(
        children: List<Widget>.generate(4, (int index) {
          return Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _AiSkeletonBlock(
                  width: 22,
                  height: 22,
                  radius: 11,
                  color: color,
                ),
                const SizedBox(height: 4),
                _AiSkeletonBlock(width: 34, height: 8, radius: 4, color: color),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _AiAmbientBackground extends StatelessWidget {
  const _AiAmbientBackground();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -130,
            right: -90,
            child: _AiBackgroundOrb(
              size: 300,
              color: _aiBackdropOrbPrimary(context),
              alpha: 0.78,
            ),
          ),
          Positioned(
            top: 190,
            left: -120,
            child: _AiBackgroundOrb(
              size: 280,
              color: _aiBackdropOrbWarm(context),
              alpha: 0.72,
            ),
          ),
          Positioned(
            bottom: 130,
            right: -120,
            child: _AiBackgroundOrb(
              size: 260,
              color: _aiBackdropOrbPrimary(context),
              alpha: 0.55,
            ),
          ),
        ],
      ),
    );
  }
}

class _AiBackgroundOrb extends StatelessWidget {
  const _AiBackgroundOrb({
    required this.size,
    required this.color,
    required this.alpha,
  });

  final double size;
  final Color color;
  final double alpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: <Color>[
            color.withValues(alpha: alpha),
            color.withValues(alpha: 0.0),
          ],
        ),
      ),
    );
  }
}

class _AiBottomWave extends StatelessWidget {
  const _AiBottomWave();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _AiBottomWavePainter(color: _aiWaveColor(context)),
      child: const SizedBox.expand(),
    );
  }
}

class _AiBottomWavePainter extends CustomPainter {
  _AiBottomWavePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final basePath = Path()
      ..moveTo(0, size.height * 0.48)
      ..cubicTo(
        size.width * 0.16,
        size.height * 0.58,
        size.width * 0.32,
        size.height * 0.18,
        size.width * 0.48,
        size.height * 0.28,
      )
      ..cubicTo(
        size.width * 0.66,
        size.height * 0.38,
        size.width * 0.80,
        size.height * 0.16,
        size.width,
        size.height * 0.28,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final topLayerPaint = Paint()
      ..color = color.withValues(alpha: 0.24)
      ..style = PaintingStyle.fill;

    final secondLayer = Path()
      ..moveTo(0, size.height * 0.62)
      ..cubicTo(
        size.width * 0.22,
        size.height * 0.42,
        size.width * 0.40,
        size.height * 0.78,
        size.width * 0.58,
        size.height * 0.62,
      )
      ..cubicTo(
        size.width * 0.76,
        size.height * 0.46,
        size.width * 0.88,
        size.height * 0.72,
        size.width,
        size.height * 0.60,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final bottomLayerPaint = Paint()
      ..color = color.withValues(alpha: 0.14)
      ..style = PaintingStyle.fill;

    canvas.drawPath(basePath, topLayerPaint);
    canvas.drawPath(secondLayer, bottomLayerPaint);
  }

  @override
  bool shouldRepaint(covariant _AiBottomWavePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _AiBottomNav extends StatelessWidget {
  const _AiBottomNav();

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(12, 10, 12, math.max(12, bottomInset)),
      decoration: BoxDecoration(
        color: _aiBottomNavBackground(context),
        border: Border(top: BorderSide(color: _aiBottomNavBorder(context))),
      ),
      child: const Row(
        children: <Widget>[
          Expanded(
            child: _AiBottomNavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              active: false,
            ),
          ),
          Expanded(
            child: _AiBottomNavItem(
              icon: Icons.search,
              label: 'Search',
              active: false,
            ),
          ),
          Expanded(
            child: _AiBottomNavItem(
              icon: Icons.explore,
              label: 'Explore',
              active: true,
            ),
          ),
          Expanded(
            child: _AiBottomNavItem(
              icon: Icons.person_outline,
              label: 'Profile',
              active: false,
            ),
          ),
        ],
      ),
    );
  }
}

class _AiBottomNavItem extends StatelessWidget {
  const _AiBottomNavItem({
    required this.icon,
    required this.label,
    required this.active,
  });

  final IconData icon;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active ? kAiColorPrimary : _aiBottomNavInactive(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}
