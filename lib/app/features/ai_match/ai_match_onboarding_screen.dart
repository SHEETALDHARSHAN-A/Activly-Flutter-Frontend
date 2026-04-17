part of 'package:activly/activly_app.dart';

const Color _kAiPageBackground = kAiColorPageBackground;
const Color _kAiBackdropOrbPrimary = kAiColorBackdropOrbPrimary;
const Color _kAiBackdropOrbWarm = kAiColorBackdropOrbWarm;
const Color _kAiCardBackground = kAiColorSurface;
const Color _kAiCardBorder = kAiColorSurfaceBorder;
const Color _kAiMutedText = kAiColorTextMutedDark;
const Color _kAiPrimaryText = kAiColorTextDark;
const Color _kAiSurfaceContainer = kAiColorSurfaceContainerLight;
const Color _kAiProgressTrack = kAiColorProgressTrack;
const Color _kAiBubbleBorder = kAiColorBubbleBorder;
const Color _kAiBottomNavBackground = kAiColorBottomNavBackgroundLight;
const Color _kAiBottomNavBorder = kAiColorBottomNavBorderLight;

const Color _kAiGlassColor = Color(0x66FFFFFF);
const Color _kAiGlassBorderColor = Color(0xA3FFFFFF);

Color _aiPageBackground(BuildContext context) => _kAiPageBackground;

Color _aiBackdropOrbPrimary(BuildContext context) => _kAiBackdropOrbPrimary;

Color _aiBackdropOrbWarm(BuildContext context) => _kAiBackdropOrbWarm;

Color _aiCardBackground(BuildContext context) => _kAiCardBackground;

Color _aiCardBorder(BuildContext context) => _kAiCardBorder;

Color _aiMutedText(BuildContext context) => _kAiMutedText;

Color _aiPrimaryText(BuildContext context) => _kAiPrimaryText;

Color _aiSurfaceContainer(BuildContext context) => _kAiSurfaceContainer;

Color _aiProgressTrack(BuildContext context) => _kAiProgressTrack;

Color _aiProgressActive(BuildContext context) => kAiColorPrimary;

Color _aiBubbleBorder(BuildContext context) => _kAiBubbleBorder;

Color _aiBottomNavBackground(BuildContext context) => _kAiBottomNavBackground;

Color _aiBottomNavBorder(BuildContext context) => _kAiBottomNavBorder;

Color _aiGlassColor(BuildContext context) => _kAiGlassColor;

Color _aiGlassBorderColor(BuildContext context) => _kAiGlassBorderColor;

double _milesToMeters(double miles) => miles * 1609.344;

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
    this.showInAppBackButton = false,
    this.useMinimalBackArrow = false,
  });

  final AppLanguage language;
  final TranslationCopy t;
  final VoidCallback onToggleLanguage;
  final VoidCallback? onSkip;
  final VoidCallback? onBack;
  final bool isInAppMode;
  final bool showBottomNavInAppMode;
  final bool showInAppBackButton;
  final bool useMinimalBackArrow;

  @override
  State<AiMatchOnboardingScreen> createState() =>
      _AiMatchOnboardingScreenState();
}

class _AiMatchOnboardingScreenState extends State<AiMatchOnboardingScreen> {
  static const String _kPrefsKidName = 'ai_match.kid_name';
  static const String _kPrefsKidAge = 'ai_match.kid_age';
  static const String _kPrefsKidGender = 'ai_match.kid_gender';
  static const String _kPrefsKidInterest = 'ai_match.kid_interest';

  bool _chatMode = false;
  int _detailsStep = 1;
  int _selectedEnergy = -1;
  bool _isPageReady = false;
  bool _showInitialOverlay = false;
  bool _initialOverlayVisible = false;
  bool _kidDetailsSaved = false;
  String _selectedSkillLevel = 'Intermediate';
  String _selectedGender = 'Girl';
  String _selectedTimePreference = 'Morning';
  DateTime? _kidDetailsSavedAt;
  RangeValues _budgetRange = const RangeValues(45, 120);
  double _radiusMiles = 5;
  LatLng _mapCenter = const LatLng(25.2048, 55.2708);
  final Set<String> _selectedFocusAreas = <String>{
    'Confidence Building',
    'Competitive Prep',
  };
  final Set<int> _selectedPreferredDays = <int>{0, 2, 4};
  final Set<String> _selectedInterests = <String>{};

  final ScrollController _contentScrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _kidNameController = TextEditingController();
  final TextEditingController _childAgeController = TextEditingController(
    text: '6',
  );
  final TextEditingController _specificInterestController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController(
    text: 'Downtown, Dubai',
  );

  Timer? _initialOverlayDelayTimer;

  @override
  void initState() {
    super.initState();

    _kidNameController.addListener(_onFormChanged);
    _childAgeController.addListener(_onFormChanged);
    _specificInterestController.addListener(_onFormChanged);
    _locationController.addListener(_onFormChanged);
    unawaited(_restoreSavedKidDetails());

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
      setState(() => _kidDetailsSaved = false);
    }
  }

  Future<void> _restoreSavedKidDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_kPrefsKidName);
    final age = prefs.getString(_kPrefsKidAge);
    final gender = prefs.getString(_kPrefsKidGender);
    final interest = prefs.getString(_kPrefsKidInterest);

    if (!mounted) {
      return;
    }

    setState(() {
      if (name != null && name.isNotEmpty) {
        _kidNameController.text = name;
      }
      if (age != null && age.isNotEmpty) {
        _childAgeController.text = age;
      }
      if (gender != null && gender.isNotEmpty) {
        _selectedGender = gender;
      }
      if (interest != null && interest.isNotEmpty) {
        _selectedInterests.addAll(
          interest.split(',').map((String e) => e.trim()).where((String e) => e.isNotEmpty),
        );
      }

      final hasSavedData =
          (name != null && name.isNotEmpty) ||
          (age != null && age.isNotEmpty) ||
          (gender != null && gender.isNotEmpty) ||
          (interest != null && interest.isNotEmpty);
      _kidDetailsSaved = hasSavedData;
      _kidDetailsSavedAt = hasSavedData ? DateTime.now() : null;
    });
  }

  Future<void> _saveKidDetails({required bool isArabic}) async {
    final name = _kidNameController.text.trim();
    final age = _childAgeController.text.trim();
    final interest = _selectedInterests.join(',');

    if (name.isEmpty || age.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'ÙŠØ±Ø¬Ù‰ Ø¥Ø¯Ø®Ø§Ù„ Ø§Ø³Ù… Ø§Ù„Ø·ÙÙ„ ÙˆØ§Ù„Ø¹Ù…Ø± Ù‚Ø¨Ù„ Ø§Ù„Ø­ÙØ¸.'
                : 'Please enter kid name and age before saving.',
          ),
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kPrefsKidName, name);
    await prefs.setString(_kPrefsKidAge, age);
    await prefs.setString(_kPrefsKidGender, _selectedGender);
    await prefs.setString(_kPrefsKidInterest, interest);

    if (!mounted) {
      return;
    }

    setState(() {
      _kidDetailsSaved = true;
      _kidDetailsSavedAt = DateTime.now();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isArabic
              ? 'ØªÙ… Ø­ÙØ¸ ØªÙØ§ØµÙŠÙ„ Ø§Ù„Ø·ÙÙ„ Ø¨Ù†Ø¬Ø§Ø­.'
              : 'Kid details saved successfully.',
        ),
      ),
    );
  }

  int get _currentStep {
    if (_chatMode) {
      return 3;
    }

    return _detailsStep.clamp(1, 3);
  }

  void _scrollToTopNextFrame() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_contentScrollController.hasClients) {
        return;
      }
      _contentScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    });
  }

  void _setDetailsStep(int nextStep) {
    final targetStep = nextStep.clamp(1, 3);
    setState(() {
      _chatMode = false;
      _detailsStep = targetStep;
    });
    _scrollToTopNextFrame();
  }

  void _setChatMode() {
    if (_chatMode) {
      return;
    }
    setState(() => _chatMode = true);
    _scrollToTopNextFrame();
  }

  void _setDetailsMode() {
    if (!_chatMode) {
      return;
    }
    setState(() => _chatMode = false);
    _scrollToTopNextFrame();
  }

  void _handleBack() {
    if (_chatMode) {
      _setDetailsStep(3);
      return;
    }

    if (!_chatMode && _detailsStep > 1) {
      _setDetailsStep(_detailsStep - 1);
      return;
    }

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
    _kidNameController.removeListener(_onFormChanged);
    _childAgeController.removeListener(_onFormChanged);
    _specificInterestController.removeListener(_onFormChanged);
    _locationController.removeListener(_onFormChanged);
    _contentScrollController.dispose();
    _messageController.dispose();
    _kidNameController.dispose();
    _childAgeController.dispose();
    _specificInterestController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = widget.language == AppLanguage.ar;
    final title = isArabic ? 'Ù…Ø·Ø§Ø¨Ù‚Ø© Ø°ÙƒÙŠØ©' : 'AI Match';

    final showBackButton =
        widget.onBack != null &&
        (!widget.isInAppMode || widget.showInAppBackButton);
    final showSkipButton = !widget.isInAppMode && widget.onSkip != null;

    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final contentBottomPadding = _chatMode
        ? 144.0 + bottomInset
        : 36.0 + bottomInset;
    final inputBottomOffset = _chatMode ? 12.0 + bottomInset : 0.0;
    final bottomFadeHeight = inputBottomOffset + 108;
    final topBarTop = kFixedTopSpace + kTopControlsVerticalOffset;
    final fixedChatToggleTop = topBarTop + 52;
    final contentTopPadding = fixedChatToggleTop;
    final topShadowHeight = fixedChatToggleTop;

    final localTheme = Theme.of(context).copyWith(brightness: Brightness.light);

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
                        controller: _contentScrollController,
                        physics: const BouncingScrollPhysics(),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 430),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                20,
                                contentTopPadding,
                                20,
                                contentBottomPadding,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Center(
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxWidth: 430,
                                      ),
                                      child: _AiModeToggle(
                                        isArabic: isArabic,
                                        chatSelected: _chatMode,
                                        onSelectChat: _setChatMode,
                                        onSelectDetails: _setDetailsMode,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  if (!_chatMode) ...<Widget>[
                                    _AiThreeStepProgressBar(
                                      isArabic: isArabic,
                                      currentStep: _currentStep,
                                    ),
                                    const SizedBox(height: 18),
                                  ] else
                                    const SizedBox(height: 8),
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
                                            key: ValueKey<String>(
                                              'details-mode-step-$_detailsStep',
                                            ),
                                            isArabic: isArabic,
                                            detailsStep: _detailsStep,
                                            kidNameController:
                                                _kidNameController,
                                            ageController: _childAgeController,
                                            selectedInterests: _selectedInterests,
                                            onToggleInterest: (String interest) {
                                              setState(() {
                                                if (_selectedInterests.contains(interest)) {
                                                  _selectedInterests.remove(interest);
                                                } else {
                                                  _selectedInterests.add(interest);
                                                }
                                                _kidDetailsSaved = false;
                                              });
                                            },
                                            selectedGender: _selectedGender,
                                            kidDetailsSaved: _kidDetailsSaved,
                                            kidDetailsSavedAt:
                                                _kidDetailsSavedAt,
                                            skillLevel: _selectedSkillLevel,
                                            specificInterestController:
                                                _specificInterestController,
                                            selectedFocusAreas:
                                                _selectedFocusAreas,
                                            onSelectGender: (String gender) {
                                              setState(() {
                                                _selectedGender = gender;
                                                _kidDetailsSaved = false;
                                              });
                                            },
                                            onSelectSkillLevel: (String level) {
                                              setState(
                                                () =>
                                                    _selectedSkillLevel = level,
                                              );
                                            },
                                            onToggleFocusArea:
                                                (String focusArea) {
                                                  setState(() {
                                                    if (_selectedFocusAreas
                                                        .contains(focusArea)) {
                                                      _selectedFocusAreas
                                                          .remove(focusArea);
                                                    } else {
                                                      _selectedFocusAreas.add(
                                                        focusArea,
                                                      );
                                                    }
                                                  });
                                                },
                                            onSaveKidDetails: () => unawaited(
                                              _saveKidDetails(
                                                isArabic: isArabic,
                                              ),
                                            ),
                                            onNext: () {
                                              if (_detailsStep < 3) {
                                                _setDetailsStep(
                                                  _detailsStep + 1,
                                                );
                                                return;
                                              }
                                              _setChatMode();
                                            },
                                            onBackToStepOne: () {
                                              _setDetailsStep(1);
                                            },
                                            onBackToStepTwo: () {
                                              _setDetailsStep(2);
                                            },
                                            selectedPreferredDays:
                                                _selectedPreferredDays,
                                            onTogglePreferredDay:
                                                (int dayIndex) {
                                                  setState(() {
                                                    if (_selectedPreferredDays
                                                        .contains(dayIndex)) {
                                                      _selectedPreferredDays
                                                          .remove(dayIndex);
                                                    } else {
                                                      _selectedPreferredDays
                                                          .add(dayIndex);
                                                    }
                                                  });
                                                },
                                            selectedTimePreference:
                                                _selectedTimePreference,
                                            onSelectTimePreference:
                                                (String value) {
                                                  setState(
                                                    () =>
                                                        _selectedTimePreference =
                                                            value,
                                                  );
                                                },
                                            budgetRange: _budgetRange,
                                            onBudgetChanged:
                                                (RangeValues values) {
                                                  setState(
                                                    () => _budgetRange = values,
                                                  );
                                                },
                                            locationController:
                                                _locationController,
                                            radiusMiles: _radiusMiles,
                                            onRadiusChanged: (double value) {
                                              setState(
                                                () => _radiusMiles = value,
                                              );
                                            },
                                            mapCenter: _mapCenter,
                                            onMapCenterChanged: (LatLng value) {
                                              setState(
                                                () => _mapCenter = value,
                                              );
                                            },
                                            onFindMatches: _setChatMode,
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
                      top: 0,
                      left: 0,
                      right: 0,
                      child: IgnorePointer(
                        child: _AiTopShadowOverlay(height: topShadowHeight),
                      ),
                    ),
                    if (_chatMode)
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: IgnorePointer(
                          child: _AiBottomShadowOverlay(
                            height: bottomFadeHeight,
                          ),
                        ),
                      ),
                    Positioned(
                      top: topBarTop,
                      left: kTopControlsSidePadding,
                      right: kTopControlsSidePadding,
                      child: _AiTopBar(
                        title: title,
                        skipLabel: widget.t.skipForNow,
                        isArabic: isArabic,
                        language: widget.language,
                        showBackButton: showBackButton,
                        showSkipButton: showSkipButton,
                        useMinimalBackArrow: widget.useMinimalBackArrow,
                        onBack: _handleBack,
                        onSkip: _handleSkip,
                        onToggleLanguage: widget.onToggleLanguage,
                        showTitle: false,
                      ),
                    ),
                    if (_chatMode)
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
                                    isChatMode: _chatMode,
                                    contentBottomPadding: contentBottomPadding,
                                    inputBottomOffset: inputBottomOffset,
                                    showBottomNav: false,
                                  ),
                                ),
                                Positioned.fill(
                                  child: LoadingOverlay(
                                    isVisible: true,
                                    showBrandImage: false,
                                    backgroundColor: kColorBlack.withValues(
                                      alpha: 0.10,
                                    ),
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
        ? rawBackground.withValues(alpha: 0.96)
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
    required this.showBackButton,
    required this.showSkipButton,
    required this.useMinimalBackArrow,
    required this.showTitle,
    required this.onBack,
    required this.onSkip,
    required this.onToggleLanguage,
  });

  final String title;
  final String skipLabel;
  final bool isArabic;
  final AppLanguage language;
  final bool showBackButton;
  final bool showSkipButton;
  final bool useMinimalBackArrow;
  final bool showTitle;
  final VoidCallback onBack;
  final VoidCallback onSkip;
  final VoidCallback onToggleLanguage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          if (showTitle)
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
            alignment: useMinimalBackArrow
                ? Alignment.centerLeft
                : AlignmentDirectional.centerStart,
            child: showBackButton
                ? _AiTopIconButton(
                    isArabic: isArabic,
                    onTap: onBack,
                    minimalStyle: useMinimalBackArrow,
                  )
                : const SizedBox(width: 40, height: 40),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: showSkipButton
                ? _AiTopSkipButton(label: skipLabel, onTap: onSkip)
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
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

class _AiTopShadowOverlay extends StatelessWidget {
  const _AiTopShadowOverlay({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    final background = _aiPageBackground(context);

    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            background.withValues(alpha: 0.98),
            background.withValues(alpha: 0.90),
            background.withValues(alpha: 0.0),
          ],
          stops: const <double>[0.0, 0.60, 1.0],
        ),
      ),
    );
  }
}

class _AiBottomShadowOverlay extends StatelessWidget {
  const _AiBottomShadowOverlay({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    final background = _aiPageBackground(context);

    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            background.withValues(alpha: 0.0),
            background.withValues(alpha: 0.86),
            background.withValues(alpha: 0.98),
          ],
          stops: const <double>[0.0, 0.58, 1.0],
        ),
      ),
    );
  }
}

class _AiTopIconButton extends StatelessWidget {
  const _AiTopIconButton({
    required this.isArabic,
    required this.onTap,
    this.minimalStyle = false,
  });

  final bool isArabic;
  final VoidCallback onTap;
  final bool minimalStyle;

  @override
  Widget build(BuildContext context) {
    if (minimalStyle) {
      return Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: 40,
            height: 40,
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 24,
                color: _aiPrimaryText(context),
              ),
            ),
          ),
        ),
      );
    }

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
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            kAiColorPrimaryAccent.withValues(alpha: 0.18),
            kAiColorPrimary.withValues(alpha: 0.10),
          ],
        ),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: kAiColorPrimary.withValues(alpha: 0.26)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 20,
            spreadRadius: -16,
            offset: const Offset(0, 10),
            color: kAiShadowPurple.withValues(alpha: 0.42),
          ),
        ],
      ),
      child: SizedBox(
        height: 36,
        child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            foregroundColor: _aiPrimaryText(context),
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
              fontWeight: FontWeight.w800,
            ),
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
    final step = currentStep.clamp(1, 3);
    final progress = step / 3;
    final percent = (progress * 100).floor();
    final stepLabel = isArabic ? 'Ø§Ù„Ø®Ø·ÙˆØ© $step Ù…Ù† 3' : 'Step $step of 3';
    final percentLabel = isArabic ? '$percentÙª Ù…ÙƒØªÙ…Ù„' : '$percent% Complete';

    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                stepLabel,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                  color: _aiProgressActive(context),
                ),
              ),
              const Spacer(),
              Text(
                percentLabel,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: _aiMutedText(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: SizedBox(
              height: 5,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(color: _aiProgressTrack(context)),
                  ),
                  FractionallySizedBox(
                    widthFactor: progress,
                    alignment: AlignmentDirectional.centerStart,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: _aiProgressActive(context),
                      ),
                    ),
                  ),
                ],
              ),
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
    final chatLabel = isArabic ? 'Ø§Ù„Ø¯Ø±Ø¯Ø´Ø©' : 'Chat';
    final detailsLabel = isArabic ? 'Ø§Ø¯Ø®Ù„ Ø§Ù„ØªÙØ§ØµÙŠÙ„' : 'Fill Details';

    return _AiGlassPanel(
      padding: const EdgeInsets.all(5),
      radius: 18,
      backgroundColor: _aiSurfaceContainer(context).withValues(alpha: 0.76),
      borderColor: _aiCardBorder(context),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _AiModeToggleButton(
              label: detailsLabel,
              selected: !chatSelected,
              onTap: onSelectDetails,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _AiModeToggleButton(
              label: chatLabel,
              selected: chatSelected,
              onTap: onSelectChat,
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
        ? const <String>['Ø·Ø§Ù‚Ø© Ø¹Ø§Ù„ÙŠØ©', 'ØªØ±ÙƒÙŠØ² ÙˆÙ‡Ø¯ÙˆØ¡', 'Ù…Ø²ÙŠØ¬ Ù…ØªÙˆØ§Ø²Ù†']
        : const <String>['High Energy', 'Focused and Quiet', 'A Bit of Both'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _AiChatHeroCard(isArabic: isArabic, selectedEnergy: selectedEnergy),
        const SizedBox(height: 14),
        _AiCoachBubble(
          text: isArabic
              ? 'Ø§Ù‡Ù„Ø§! Ø§Ù†Ø§ Ù…Ø³Ø§Ø¹Ø¯ Activly. ÙƒÙ… Ø¹Ù…Ø± Ø·ÙÙ„Ùƒ Ø§Ù„Ø¢Ù†ØŸ'
              : 'Hi! I am your Activly Coach. How old is your child now?',
        ),
        const SizedBox(height: 12),
        _AiUserBubble(
          text: isArabic ? 'Ø¹Ù…Ø±Ù‡ 6 Ø³Ù†ÙˆØ§Øª.' : 'He just turned 6 last month.',
        ),
        const SizedBox(height: 12),
        _AiCoachBubble(
          text: isArabic
              ? 'Ø±Ø§Ø¦Ø¹. Ù…Ø§ Ù…Ø³ØªÙˆÙ‰ Ø·Ø§Ù‚ØªÙ‡ ØºØ§Ù„Ø¨Ø§ØŸ'
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

class _AiChatHeroCard extends StatelessWidget {
  const _AiChatHeroCard({required this.isArabic, required this.selectedEnergy});

  final bool isArabic;
  final int selectedEnergy;

  @override
  Widget build(BuildContext context) {
    final selectedEnergyLabel = isArabic
        ? <String>['Ø·Ø§Ù‚Ø© Ø¹Ø§Ù„ÙŠØ©', 'ØªØ±ÙƒÙŠØ² ÙˆÙ‡Ø¯ÙˆØ¡', 'Ù…Ø²ÙŠØ¬ Ù…ØªÙˆØ§Ø²Ù†']
        : <String>['High Energy', 'Focused and Quiet', 'Balanced Mix'];

    final currentEnergy = selectedEnergy >= 0 && selectedEnergy < 3
        ? selectedEnergyLabel[selectedEnergy]
        : (isArabic ? 'Ù…ØªÙƒÙŠÙ' : 'Adaptive');

    final title = isArabic ? 'Ù…Ø³Ø§Ø¹Ø¯ Activly Ø¬Ø§Ù‡Ø²' : 'Activly Coach Is Ready';
    final subtitle = isArabic
        ? 'Ø³Ù†Ø®ØµØµ Ø§Ù„Ø§Ù‚ØªØ±Ø§Ø­Ø§Øª Ø¨Ø³Ø±Ø¹Ø© Ø­Ø³Ø¨ Ø§Ù„Ø¹Ù…Ø± ÙˆØ§Ù„Ø·Ø§Ù‚Ø© ÙˆØ§Ù„Ù‡Ø¯Ù.'
        : 'We will personalize activity picks by age, energy, and goal in seconds.';

    return _AiGlassPanel(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 13),
      radius: 20,
      backgroundColor: _aiCardBackground(context),
      borderColor: _aiCardBorder(context),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          blurRadius: 24,
          spreadRadius: -18,
          offset: Offset(0, 12),
          color: kAiShadowMedium,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: <Color>[kAiColorAvatarStart, kAiColorAvatarEnd],
                  ),
                ),
                child: const Icon(
                  Icons.smart_toy_rounded,
                  color: kAiColorPrimary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _aiPrimaryText(context),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              height: 1.35,
              fontWeight: FontWeight.w600,
              color: _aiMutedText(context),
            ),
          ),
          const SizedBox(height: 11),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _AiSignalChip(
                label: isArabic ? 'Ù…Ù†Ø§Ø³Ø¨ Ù„Ù„Ø¹Ù…Ø±' : 'Age tuned',
                highlighted: false,
              ),
              _AiSignalChip(
                label: isArabic ? 'ÙŠØ±Ø§Ø¹ÙŠ Ø§Ù„Ù‡Ø¯Ù' : 'Goal aware',
                highlighted: false,
              ),
              _AiSignalChip(
                label: currentEnergy,
                highlighted: selectedEnergy >= 0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AiSignalChip extends StatelessWidget {
  const _AiSignalChip({required this.label, required this.highlighted});

  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final borderColor = highlighted
        ? kAiColorPrimary.withValues(alpha: 0.46)
        : _aiCardBorder(context);
    final fillColor = highlighted
        ? kAiColorPrimary.withValues(alpha: 0.12)
        : _aiSurfaceContainer(context).withValues(alpha: 0.62);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: highlighted ? kAiColorPrimary : _aiMutedText(context),
        ),
      ),
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
            Icons.smart_toy_rounded,
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
          backgroundColor: selected
              ? kAiColorPrimary.withValues(alpha: 0.10)
              : _aiCardBackground(context),
          borderColor: selected ? kAiColorPrimary : _aiCardBorder(context),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: selected ? 24 : 20,
              spreadRadius: -18,
              offset: const Offset(0, 12),
              color: selected ? kAiShadowPurple : kAiShadowMedium,
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
                    color: selected ? kAiColorPrimary : _aiPrimaryText(context),
                  ),
                ),
              ),
              Icon(
                selected
                    ? Icons.check_circle_rounded
                    : Icons.chevron_right_rounded,
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
    required this.detailsStep,
    required this.kidNameController,
    required this.ageController,
    required this.selectedInterests,
    required this.onToggleInterest,
    required this.selectedGender,
    required this.kidDetailsSaved,
    required this.kidDetailsSavedAt,
    required this.skillLevel,
    required this.specificInterestController,
    required this.selectedFocusAreas,
    required this.onSelectGender,
    required this.onSelectSkillLevel,
    required this.onToggleFocusArea,
    required this.onSaveKidDetails,
    required this.onNext,
    required this.onBackToStepOne,
    required this.onBackToStepTwo,
    required this.selectedPreferredDays,
    required this.onTogglePreferredDay,
    required this.selectedTimePreference,
    required this.onSelectTimePreference,
    required this.budgetRange,
    required this.onBudgetChanged,
    required this.locationController,
    required this.radiusMiles,
    required this.onRadiusChanged,
    required this.mapCenter,
    required this.onMapCenterChanged,
    required this.onFindMatches,
  });

  final bool isArabic;
  final int detailsStep;
  final TextEditingController kidNameController;
  final TextEditingController ageController;
  final Set<String> selectedInterests;
  final ValueChanged<String> onToggleInterest;
  final String selectedGender;
  final bool kidDetailsSaved;
  final DateTime? kidDetailsSavedAt;
  final String skillLevel;
  final TextEditingController specificInterestController;
  final Set<String> selectedFocusAreas;
  final ValueChanged<String> onSelectGender;
  final ValueChanged<String> onSelectSkillLevel;
  final ValueChanged<String> onToggleFocusArea;
  final VoidCallback onSaveKidDetails;
  final VoidCallback onNext;
  final VoidCallback onBackToStepOne;
  final VoidCallback onBackToStepTwo;
  final Set<int> selectedPreferredDays;
  final ValueChanged<int> onTogglePreferredDay;
  final String selectedTimePreference;
  final ValueChanged<String> onSelectTimePreference;
  final RangeValues budgetRange;
  final ValueChanged<RangeValues> onBudgetChanged;
  final TextEditingController locationController;
  final double radiusMiles;
  final ValueChanged<double> onRadiusChanged;
  final LatLng mapCenter;
  final ValueChanged<LatLng> onMapCenterChanged;
  final VoidCallback onFindMatches;

  @override
  Widget build(BuildContext context) {
    if (detailsStep == 1) {
      return _AiDetailsStepOnePanel(
        isArabic: isArabic,
        kidNameController: kidNameController,
        ageController: ageController,
        selectedInterests: selectedInterests,
        onToggleInterest: onToggleInterest,
        selectedGender: selectedGender,
        kidDetailsSaved: kidDetailsSaved,
        kidDetailsSavedAt: kidDetailsSavedAt,
        onSelectGender: onSelectGender,
        onSaveKidDetails: onSaveKidDetails,
        onNext: onNext,
      );
    }

    if (detailsStep == 2) {
      return _AiDetailsStepTwoPanel(
        isArabic: isArabic,
        skillLevel: skillLevel,
        specificInterestController: specificInterestController,
        selectedFocusAreas: selectedFocusAreas,
        onSelectSkillLevel: onSelectSkillLevel,
        onToggleFocusArea: onToggleFocusArea,
        onNext: onNext,
        onBackToStepOne: onBackToStepOne,
      );
    }

    return _AiDetailsStepThreePanel(
      isArabic: isArabic,
      selectedPreferredDays: selectedPreferredDays,
      onTogglePreferredDay: onTogglePreferredDay,
      selectedTimePreference: selectedTimePreference,
      onSelectTimePreference: onSelectTimePreference,
      budgetRange: budgetRange,
      onBudgetChanged: onBudgetChanged,
      locationController: locationController,
      radiusMiles: radiusMiles,
      onRadiusChanged: onRadiusChanged,
      mapCenter: mapCenter,
      onMapCenterChanged: onMapCenterChanged,
      onBackToStepTwo: onBackToStepTwo,
      onFindMatches: onFindMatches,
    );
  }
}

class _AiDetailsStepOnePanel extends StatelessWidget {
  const _AiDetailsStepOnePanel({
    required this.isArabic,
    required this.kidNameController,
    required this.ageController,
    required this.selectedInterests,
    required this.onToggleInterest,
    required this.selectedGender,
    required this.kidDetailsSaved,
    required this.kidDetailsSavedAt,
    required this.onSelectGender,
    required this.onSaveKidDetails,
    required this.onNext,
  });

  final bool isArabic;
  final TextEditingController kidNameController;
  final TextEditingController ageController;
  final Set<String> selectedInterests;
  final ValueChanged<String> onToggleInterest;
  final String selectedGender;
  final bool kidDetailsSaved;
  final DateTime? kidDetailsSavedAt;
  final ValueChanged<String> onSelectGender;
  final VoidCallback onSaveKidDetails;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final title = isArabic ? 'Ù„Ù†Ø¨Ø¯Ø£ Ø¨Ø¨ÙŠØ§Ù†Ø§Øª Ø§Ù„Ø·ÙÙ„.' : 'Start with kid details.';
    final subtitle = isArabic
        ? 'Ù…Ù„Ù ØµØºÙŠØ± ÙˆØ¯Ù‚ÙŠÙ‚ ÙŠØ¹Ø·ÙŠ ØªØ·Ø§Ø¨Ù‚Ø§Øª Ø£Ø°ÙƒÙ‰ Ø®Ù„Ø§Ù„ Ø«ÙˆØ§Ù†Ù.'
        : 'A small precise profile gives smarter matches in seconds.';
    final profileLabel = isArabic ? 'Ø¨ÙŠØ§Ù†Ø§Øª Ø§Ù„Ø·ÙÙ„' : 'KID DETAILS';
    final nameHint = isArabic ? 'Ø§Ø³Ù… Ø§Ù„Ø·ÙÙ„' : 'Kid name';
    final ageHint = isArabic ? 'Ø§Ù„Ø¹Ù…Ø±' : 'Age';
    final genderLabel = isArabic ? 'Ø§Ù„Ø¬Ù†Ø³' : 'GENDER';
    final interestsLabel = isArabic
        ? 'Ù…Ø§ Ø§Ù„Ø°ÙŠ ÙŠØ«ÙŠØ± ÙØ¶ÙˆÙ„Ù‡ØŸ'
        : 'WHAT SPARKS THEIR CURIOSITY?';
    final saveCta = isArabic ? 'Ø­ÙØ¸ Ø§Ù„ØªÙØ§ØµÙŠÙ„' : 'Save Details';
    final cta = isArabic ? 'Ø§Ù„ØªØ§Ù„ÙŠ' : 'Next';

    final genderOptions = isArabic
        ? const <_AiSelectableLabel>[
            _AiSelectableLabel(value: 'Girl', label: 'Ø¨Ù†Øª'),
            _AiSelectableLabel(value: 'Boy', label: 'ÙˆÙ„Ø¯'),
            _AiSelectableLabel(value: 'Other', label: 'Ø¢Ø®Ø±'),
          ]
        : const <_AiSelectableLabel>[
            _AiSelectableLabel(value: 'Girl', label: 'Girl'),
            _AiSelectableLabel(value: 'Boy', label: 'Boy'),
            _AiSelectableLabel(value: 'Other', label: 'Other'),
          ];

    final interests = isArabic
        ? const <_AiInterestOption>[
            _AiInterestOption(
              value: 'Art & Craft',
              label: 'ÙÙ† ÙˆØ£Ø¹Ù…Ø§Ù„',
              icon: Icons.palette_outlined,
              imagePath: 'assets/images/ai_match/art_craft.png',
            ),
            _AiInterestOption(
              value: 'Soccer',
              label: 'ÙƒØ±Ø© Ø§Ù„Ù‚Ø¯Ù…',
              icon: Icons.sports_soccer_outlined,
              imagePath: 'assets/images/ai_match/soccer.png',
            ),
            _AiInterestOption(
              value: 'Science',
              label: 'Ø¹Ù„ÙˆÙ…',
              icon: Icons.science_outlined,
              imagePath: 'assets/images/ai_match/science.png',
            ),
            _AiInterestOption(
              value: 'Music',
              label: 'Ù…ÙˆØ³ÙŠÙ‚Ù‰',
              icon: Icons.music_note_outlined,
              imagePath: 'assets/images/ai_match/music.png',
            ),
          ]
        : const <_AiInterestOption>[
            _AiInterestOption(
              value: 'Art & Craft',
              label: 'Art & Craft',
              icon: Icons.palette_outlined,
              imagePath: 'assets/images/ai_match/art_craft.png',
            ),
            _AiInterestOption(
              value: 'Soccer',
              label: 'Soccer',
              icon: Icons.sports_soccer_outlined,
              imagePath: 'assets/images/ai_match/soccer.png',
            ),
            _AiInterestOption(
              value: 'Science',
              label: 'Science',
              icon: Icons.science_outlined,
              imagePath: 'assets/images/ai_match/science.png',
            ),
            _AiInterestOption(
              value: 'Music',
              label: 'Music',
              icon: Icons.music_note_outlined,
              imagePath: 'assets/images/ai_match/music.png',
            ),
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 27,
            fontWeight: FontWeight.w800,
            height: 1.05,
            color: _aiPrimaryText(context),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _aiMutedText(context),
          ),
        ),
        const SizedBox(height: 16),
        _AiSectionLabel(label: profileLabel),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: _AiCompactInputField(
                controller: kidNameController,
                hintText: nameHint,
                icon: Icons.badge_rounded,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _AiCompactInputField(
                controller: ageController,
                hintText: ageHint,
                icon: Icons.cake_rounded,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _AiSectionLabel(label: genderLabel),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: genderOptions.map((_AiSelectableLabel option) {
            return _AiGenderChip(
              label: option.label,
              selected: selectedGender == option.value,
              onTap: () => onSelectGender(option.value),
            );
          }).toList(),
        ),
        const SizedBox(height: 14),
        _AiSectionLabel(label: interestsLabel),
        const SizedBox(height: 10),
        _AiInterestHorizontalList(
          interests: interests,
          selectedInterests: selectedInterests,
          onToggleInterest: onToggleInterest,
        ),
        const SizedBox(height: 12),
        _AiKidLiveProfileCard(
          isArabic: isArabic,
          kidName: kidNameController.text.trim(),
          kidAge: ageController.text.trim(),
          kidGender: selectedGender,
          selectedInterests: selectedInterests,
          detailsSaved: kidDetailsSaved,
          savedAt: kidDetailsSavedAt,
        ),
        const SizedBox(height: 12),
        _AiStepActionButtons(
          previousLabel: saveCta,
          nextLabel: cta,
          stepLabel: '1/3',
          onPrevious: onSaveKidDetails,
          onNext: onNext,
        ),
      ],
    );
  }
}

class _AiDetailsStepTwoPanel extends StatelessWidget {
  const _AiDetailsStepTwoPanel({
    required this.isArabic,
    required this.skillLevel,
    required this.specificInterestController,
    required this.selectedFocusAreas,
    required this.onSelectSkillLevel,
    required this.onToggleFocusArea,
    required this.onNext,
    required this.onBackToStepOne,
  });

  final bool isArabic;
  final String skillLevel;
  final TextEditingController specificInterestController;
  final Set<String> selectedFocusAreas;
  final ValueChanged<String> onSelectSkillLevel;
  final ValueChanged<String> onToggleFocusArea;
  final VoidCallback onNext;
  final VoidCallback onBackToStepOne;

  @override
  Widget build(BuildContext context) {
    final title = isArabic ? 'Ø·ÙˆØ± Ø§Ù„Ù…ØªØ¹Ø© Ø£ÙƒØ«Ø±.' : 'Level up the fun.';
    final subtitle = isArabic
        ? 'Ø£Ø®Ø¨Ø±Ù†Ø§ Ø¹Ù† Ø§Ù„Ù…Ø³ØªÙˆÙ‰ Ø§Ù„Ø­Ø§Ù„ÙŠ ÙˆØ§Ù„Ø£Ù‡Ø¯Ø§Ù Ø§Ù„Ù…Ø­Ø¯Ø¯Ø©.'
        : 'Tell us about their skill level and specific goals.';
    final skillLabel = isArabic ? 'Ø§Ù„Ù…Ø³ØªÙˆÙ‰ Ø§Ù„Ø­Ø§Ù„ÙŠ' : 'CURRENT SKILL LEVEL';
    final interestLabel = isArabic ? 'Ø§Ù‡ØªÙ…Ø§Ù… Ù…Ø­Ø¯Ø¯' : 'SPECIFIC INTEREST';
    final focusLabel = isArabic
        ? 'Ù…Ø­Ø§ÙˆØ± Ø§Ù„ØªØ±ÙƒÙŠØ² ÙˆØ§Ù„Ø£Ù‡Ø¯Ø§Ù'
        : 'FOCUS AREAS & GOALS';
    final interestHint = isArabic
        ? 'Ù…Ø«Ø§Ù„: ØªØ¹Ù„Ù… ØªØ±ÙƒÙŠØ¨ Ø£Ø¬Ù‡Ø²Ø© Ø§Ù„ÙƒÙ…Ø¨ÙŠÙˆØªØ±...'
        : 'e.g. Learning to build custom PC builds...';
    final previousLabel = isArabic ? 'Ø§Ù„Ø³Ø§Ø¨Ù‚' : 'Previous';
    final cta = isArabic ? 'Ø§Ù„ØªØ§Ù„ÙŠ' : 'Next';

    final skillOptions = isArabic
        ? const <_AiSelectableLabel>[
            _AiSelectableLabel(value: 'Beginner', label: 'Ù…Ø¨ØªØ¯Ø¦'),
            _AiSelectableLabel(value: 'Intermediate', label: 'Ù…ØªÙˆØ³Ø·'),
            _AiSelectableLabel(value: 'Advanced', label: 'Ù…ØªÙ‚Ø¯Ù…'),
          ]
        : const <_AiSelectableLabel>[
            _AiSelectableLabel(value: 'Beginner', label: 'Beginner', icon: Icons.settings_outlined),
            _AiSelectableLabel(value: 'Intermediate', label: 'Intermediate', icon: Icons.tune_outlined),
            _AiSelectableLabel(value: 'Advanced', label: 'Advanced', icon: Icons.rocket_launch_outlined),
          ];

    final focusOptions = isArabic
        ? const <_AiSelectableLabel>[
            _AiSelectableLabel(
              value: 'Confidence Building',
              label: 'Ø¨Ù†Ø§Ø¡ Ø§Ù„Ø«Ù‚Ø©',
            ),
            _AiSelectableLabel(
              value: 'Technical Skills',
              label: 'Ù…Ù‡Ø§Ø±Ø§Øª ØªÙ‚Ù†ÙŠØ©',
            ),
            _AiSelectableLabel(
              value: 'Social Interaction',
              label: 'ØªÙØ§Ø¹Ù„ Ø§Ø¬ØªÙ…Ø§Ø¹ÙŠ',
            ),
            _AiSelectableLabel(
              value: 'Competitive Prep',
              label: 'Ø§Ø³ØªØ¹Ø¯Ø§Ø¯ ØªÙ†Ø§ÙØ³ÙŠ',
            ),
            _AiSelectableLabel(
              value: 'Creative Expression',
              label: 'ØªØ¹Ø¨ÙŠØ± Ø¥Ø¨Ø¯Ø§Ø¹ÙŠ',
            ),
          ]
        : const <_AiSelectableLabel>[
            _AiSelectableLabel(
              value: 'Confidence Building',
              label: 'Confidence Building',
              icon: Icons.trending_up_rounded,
            ),
            _AiSelectableLabel(
              value: 'Technical Skills',
              label: 'Technical Skills',
              icon: Icons.build_outlined,
            ),
            _AiSelectableLabel(
              value: 'Social Interaction',
              label: 'Social Interaction',
              icon: Icons.groups_outlined,
            ),
            _AiSelectableLabel(
              value: 'Competitive Prep',
              label: 'Competitive Prep',
              icon: Icons.emoji_events_outlined,
            ),
            _AiSelectableLabel(
              value: 'Creative Expression',
              label: 'Creative Expression',
              icon: Icons.brush_outlined,
            ),
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 29,
            fontWeight: FontWeight.w800,
            height: 1.05,
            color: _aiPrimaryText(context),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: _aiMutedText(context),
          ),
        ),
        const SizedBox(height: 24),
        const _AiSecondStepHeroCard(),
        const SizedBox(height: 28),
        _AiSectionLabel(label: skillLabel),
        const SizedBox(height: 12),
        _AiGlassPanel(
          padding: const EdgeInsets.all(6),
          radius: 18,
          backgroundColor: _aiSurfaceContainer(context),
          borderColor: _aiCardBorder(context),
          child: Row(
            children: List<Widget>.generate(skillOptions.length, (int index) {
              final option = skillOptions[index];
              return Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: index == skillOptions.length - 1 ? 0 : 6,
                  ),
                  child: _AiSkillLevelButton(
                    label: option.label,
                    icon: option.icon,
                    selected: skillLevel == option.value,
                    onTap: () => onSelectSkillLevel(option.value),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 24),
        _AiSectionLabel(label: interestLabel),
        const SizedBox(height: 12),
        _AiGlassPanel(
          radius: 18,
          backgroundColor: _aiCardBackground(context),
          borderColor: _aiCardBorder(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.description_outlined,
                  size: 20,
                  color: _aiMutedText(context).withValues(alpha: 0.55),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: specificInterestController,
                    style: GoogleFonts.plusJakartaSans(
                      color: _aiPrimaryText(context),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      hintText: interestHint,
                      hintStyle: GoogleFonts.plusJakartaSans(
                        color: _aiMutedText(context).withValues(alpha: 0.55),
                        fontWeight: FontWeight.w500,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        _AiSectionLabel(label: focusLabel),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: focusOptions.map((_AiSelectableLabel option) {
            return _AiFocusAreaChip(
              label: option.label,
              icon: option.icon,
              selected: selectedFocusAreas.contains(option.value),
              onTap: () => onToggleFocusArea(option.value),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        _AiStepActionButtons(
          previousLabel: previousLabel,
          nextLabel: cta,
          stepLabel: '2/3',
          onPrevious: onBackToStepOne,
          onNext: onNext,
        ),
      ],
    );
  }
}

class _AiDetailsStepThreePanel extends StatelessWidget {
  const _AiDetailsStepThreePanel({
    required this.isArabic,
    required this.selectedPreferredDays,
    required this.onTogglePreferredDay,
    required this.selectedTimePreference,
    required this.onSelectTimePreference,
    required this.budgetRange,
    required this.onBudgetChanged,
    required this.locationController,
    required this.radiusMiles,
    required this.onRadiusChanged,
    required this.mapCenter,
    required this.onMapCenterChanged,
    required this.onBackToStepTwo,
    required this.onFindMatches,
  });

  final bool isArabic;
  final Set<int> selectedPreferredDays;
  final ValueChanged<int> onTogglePreferredDay;
  final String selectedTimePreference;
  final ValueChanged<String> onSelectTimePreference;
  final RangeValues budgetRange;
  final ValueChanged<RangeValues> onBudgetChanged;
  final TextEditingController locationController;
  final double radiusMiles;
  final ValueChanged<double> onRadiusChanged;
  final LatLng mapCenter;
  final ValueChanged<LatLng> onMapCenterChanged;
  final VoidCallback onBackToStepTwo;
  final VoidCallback onFindMatches;

  @override
  Widget build(BuildContext context) {
    final title = isArabic ? 'Ù…ØªÙ‰ ÙˆØ£ÙŠÙ†ØŸ' : 'When and where?';
    final subtitle = isArabic
        ? 'Ø³Ø§Ø¹Ø¯Ù†Ø§ ÙÙŠ ØªØ­Ø¯ÙŠØ¯ Ø§Ù„ÙˆÙ‚Øª ÙˆØ§Ù„Ù…ÙƒØ§Ù† Ø§Ù„Ù…Ø«Ø§Ù„ÙŠÙŠÙ† Ù„Ù„ØªØ·Ø§Ø¨Ù‚Ø§Øª.'
        : 'Help us narrow down the perfect schedule and location for your matches.';
    final daysLabel = isArabic ? 'Ø§Ù„Ø£ÙŠØ§Ù… Ø§Ù„Ù…ÙØ¶Ù„Ø©' : 'PREFERRED DAYS';
    final timeLabel = isArabic ? 'Ø§Ù„ÙˆÙ‚Øª Ø§Ù„Ù…ÙØ¶Ù„' : 'TIME PREFERENCE';
    final budgetLabel = isArabic ? 'Ù†Ø·Ø§Ù‚ Ø§Ù„Ù…ÙŠØ²Ø§Ù†ÙŠØ©' : 'BUDGET RANGE';
    final locationLabel = isArabic ? 'Ø§Ù„Ù…ÙˆÙ‚Ø¹ ÙˆÙ†Ø·Ø§Ù‚ Ø§Ù„Ø¨Ø­Ø«' : 'LOCATION & RADIUS';
    final budgetValue =
        '\$${budgetRange.start.round()} â€” \$${budgetRange.end.round()}';
    final radiusValue = isArabic
        ? '${radiusMiles.round()} Ø£Ù…ÙŠØ§Ù„'
        : '${radiusMiles.round()} Miles';
    final radiusHint = isArabic ? 'Ø§Ù„Ù†Ø·Ø§Ù‚' : 'RADIUS';
    final locationHint = isArabic
        ? 'Ø£Ø¯Ø®Ù„ Ø§Ù„Ø±Ù…Ø² Ø§Ù„Ø¨Ø±ÙŠØ¯ÙŠ Ø£Ùˆ Ø§Ù„Ø­ÙŠ'
        : 'Enter zip code or neighborhood';
    final previousLabel = isArabic ? 'Ø§Ù„Ø³Ø§Ø¨Ù‚' : 'Previous';
    final cta = isArabic ? 'Ø§Ø¨Ø­Ø« Ø¹Ù† Ø§Ù„ØªØ·Ø§Ø¨Ù‚Ø§Øª' : 'Find Matches';
    final engineCaption = isArabic
        ? 'Ù…Ø¯Ø¹ÙˆÙ… Ø¨Ù…Ø­Ø±Ùƒ Ø§Ù„Ù…Ø·Ø§Ø¨Ù‚Ø© Ø§Ù„Ø°ÙƒÙŠ'
        : 'Powered by AI Matchmaking Engine v4.2';
    final socialProofTitle = isArabic
        ? 'Ø¹Ø§Ø¦Ù„Ø§Øª ÙÙŠ Ù…Ù†Ø·Ù‚ØªÙƒ ØªØ¨Ø­Ø« Ø§Ù„Ø¢Ù†'
        : 'Families nearby are matching now';
    final socialProofSubtitle = isArabic
        ? 'ØªØ§Ø¨Ø¹ Ù„Ø¹Ø±Ø¶ Ø£ÙØ¶Ù„ Ø§Ù„Ø®ÙŠØ§Ø±Ø§Øª Ø§Ù„Ù…Ù‚ØªØ±Ø­Ø© Ù„Ø·ÙÙ„Ùƒ.'
        : 'Continue to unlock your best personalized matches.';

    final dayLabels = isArabic
        ? const <String>['Ù†', 'Ø«', 'Ø±', 'Ø®', 'Ø¬', 'Ø³', 'Ø­']
        : const <String>['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    final timeOptions = isArabic
        ? const <_AiTimeOption>[
            _AiTimeOption(
              value: 'Morning',
              label: 'Ø§Ù„ØµØ¨Ø§Ø­',
              icon: Icons.light_mode_rounded,
            ),
            _AiTimeOption(
              value: 'Afternoon',
              label: 'Ø¨Ø¹Ø¯ Ø§Ù„Ø¸Ù‡Ø±',
              icon: Icons.wb_sunny_rounded,
            ),
            _AiTimeOption(
              value: 'Evening',
              label: 'Ø§Ù„Ù…Ø³Ø§Ø¡',
              icon: Icons.dark_mode_rounded,
            ),
          ]
        : const <_AiTimeOption>[
            _AiTimeOption(
              value: 'Morning',
              label: 'Morning',
              icon: Icons.light_mode_rounded,
            ),
            _AiTimeOption(
              value: 'Afternoon',
              label: 'Afternoon',
              icon: Icons.wb_sunny_rounded,
            ),
            _AiTimeOption(
              value: 'Evening',
              label: 'Evening',
              icon: Icons.dark_mode_rounded,
            ),
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 29,
            fontWeight: FontWeight.w800,
            height: 1.05,
            color: _aiPrimaryText(context),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: _aiMutedText(context),
          ),
        ),
        const SizedBox(height: 24),
        _AiSectionLabel(label: daysLabel),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List<Widget>.generate(dayLabels.length, (int index) {
            return _AiDaySelectorButton(
              label: dayLabels[index],
              selected: selectedPreferredDays.contains(index),
              onTap: () => onTogglePreferredDay(index),
            );
          }),
        ),
        const SizedBox(height: 24),
        _AiSectionLabel(label: timeLabel),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: timeOptions.map((_AiTimeOption option) {
            return _AiTimePreferenceButton(
              icon: option.icon,
              label: option.label,
              selected: selectedTimePreference == option.value,
              onTap: () => onSelectTimePreference(option.value),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        _AiGlassPanel(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
          radius: 24,
          backgroundColor: _aiCardBackground(context),
          borderColor: _aiCardBorder(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  _AiSectionLabel(label: budgetLabel),
                  const Spacer(),
                  Text(
                    budgetValue,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: kAiColorPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: kAiColorPrimary,
                  inactiveTrackColor: _aiSurfaceContainer(context),
                  thumbColor: kAiColorPrimary,
                  overlayColor: kAiColorPrimary.withValues(alpha: 0.12),
                  rangeThumbShape: const RoundRangeSliderThumbShape(
                    enabledThumbRadius: 10,
                  ),
                  rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
                ),
                child: RangeSlider(
                  values: budgetRange,
                  min: 20,
                  max: 150,
                  divisions: 26,
                  onChanged: onBudgetChanged,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Row(
                  children: <Widget>[
                    Text(
                      '\$20',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: _aiMutedText(context),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '\$150+',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: _aiMutedText(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _AiGlassPanel(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
          radius: 24,
          backgroundColor: _aiCardBackground(context),
          borderColor: _aiCardBorder(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _AiSectionLabel(label: locationLabel),
              const SizedBox(height: 10),
              _AiGlassPanel(
                radius: 16,
                backgroundColor: _aiSurfaceContainer(context),
                borderColor: _aiCardBorder(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on_rounded,
                        size: 20,
                        color: _aiMutedText(context).withValues(alpha: 0.72),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: locationController,
                          style: GoogleFonts.plusJakartaSans(
                            color: _aiPrimaryText(context),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            hintText: locationHint,
                            hintStyle: GoogleFonts.plusJakartaSans(
                              color: _aiMutedText(context),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: <Widget>[
                  Text(
                    radiusHint,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                      color: _aiMutedText(context),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    radiusValue,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                      color: kAiColorPrimary,
                    ),
                  ),
                ],
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: kAiColorPrimary,
                  inactiveTrackColor: _aiSurfaceContainer(context),
                  thumbColor: kAiColorPrimary,
                  overlayColor: kAiColorPrimary.withValues(alpha: 0.12),
                ),
                child: Slider(
                  value: radiusMiles,
                  min: 1,
                  max: 50,
                  divisions: 49,
                  onChanged: onRadiusChanged,
                ),
              ),
              const SizedBox(height: 6),
              _AiRealtimeMapPreview(
                mapCenter: mapCenter,
                radiusMiles: radiusMiles,
                onMapCenterChanged: onMapCenterChanged,
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _AiFindMatchesSocialProof(
          title: socialProofTitle,
          subtitle: socialProofSubtitle,
          isArabic: isArabic,
        ),
        const SizedBox(height: 14),
        _AiStepActionButtons(
          previousLabel: previousLabel,
          nextLabel: cta,
          stepLabel: '3/3',
          useAvatarBadge: true,
          onPrevious: onBackToStepTwo,
          onNext: onFindMatches,
        ),
        const SizedBox(height: 12),
        Text(
          engineCaption,
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
            color: _aiMutedText(context).withValues(alpha: 0.45),
          ),
        ),
      ],
    );
  }
}

class _AiStepActionButtons extends StatelessWidget {
  const _AiStepActionButtons({
    required this.previousLabel,
    required this.nextLabel,
    required this.stepLabel,
    required this.onPrevious,
    required this.onNext,
    this.useAvatarBadge = false,
  });

  final String previousLabel;
  final String nextLabel;
  final String stepLabel;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final bool useAvatarBadge;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 56,
            child: TextButton(
              onPressed: onPrevious,
              style: TextButton.styleFrom(
                foregroundColor: _aiPrimaryText(context),
                backgroundColor: _aiSurfaceContainer(
                  context,
                ).withValues(alpha: 0.74),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                previousLabel,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 56,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[kAiColorPrimaryAccent, kAiColorPrimary],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    blurRadius: 20,
                    spreadRadius: -16,
                    offset: Offset(0, 10),
                    color: kAiShadowPurple,
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onNext,
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 6, 6, 6),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                nextLabel,
                                style: GoogleFonts.plusJakartaSans(
                                  color: kColorWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: useAvatarBadge ? 64 : 54,
                          height: 44,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: useAvatarBadge
                                ? Colors.transparent
                                : kColorWhite.withValues(alpha: 0.94),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: useAvatarBadge
                              ? const _AiAvatarBadgeCircles()
                              : Text(
                                  stepLabel,
                                  style: GoogleFonts.plusJakartaSans(
                                    color: _aiPrimaryText(context),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AiAvatarBadgeCircles extends StatelessWidget {
  const _AiAvatarBadgeCircles();

  @override
  Widget build(BuildContext context) {
    const avatarSize = 24.0;
    const overlap = 16.0;

    final avatarColors = <Color>[
      const Color(0xFFE9D7FF),
      const Color(0xFFFFD8E8),
      const Color(0xFFDDF0FF),
    ];
    final icons = <IconData>[
      Icons.person_rounded,
      Icons.face_rounded,
      Icons.child_care_rounded,
    ];

    return SizedBox(
      width: 58,
      height: avatarSize,
      child: Stack(
        children: <Widget>[
          for (int i = 0; i < icons.length; i++)
            Positioned(
              left: i * overlap,
              child: Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: avatarColors[i],
                  border: Border.all(
                    color: kAiColorPrimary.withValues(alpha: 0.40),
                    width: 1.2,
                  ),
                ),
                child: Icon(icons[i], size: 13, color: _aiPrimaryText(context)),
              ),
            ),
        ],
      ),
    );
  }
}

class _AiFindMatchesSocialProof extends StatelessWidget {
  const _AiFindMatchesSocialProof({
    required this.title,
    required this.subtitle,
    required this.isArabic,
  });

  final String title;
  final String subtitle;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return _AiGlassPanel(
      radius: 16,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      backgroundColor: _aiCardBackground(context),
      borderColor: _aiCardBorder(context),
      child: Row(
        children: <Widget>[
          _AiAvatarCirclesStrip(isArabic: isArabic),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: _aiPrimaryText(context),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: _aiMutedText(context),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AiAvatarCirclesStrip extends StatelessWidget {
  const _AiAvatarCirclesStrip({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    const avatarSize = 30.0;
    const avatarOverlap = 20.0;
    const extraCount = 58;

    final iconSet = <IconData>[
      Icons.person_rounded,
      Icons.sports_soccer_rounded,
      Icons.palette_rounded,
      Icons.music_note_rounded,
    ];
    final avatarColors = <Color>[
      const Color(0xFFF7D5FF),
      const Color(0xFFFFE6AF),
      const Color(0xFFD7F3FF),
      const Color(0xFFE2F6D8),
    ];
    final stackWidth = (iconSet.length - 1) * avatarOverlap + avatarSize + 40;

    return SizedBox(
      width: stackWidth,
      height: avatarSize,
      child: Stack(
        children: <Widget>[
          for (int i = 0; i < iconSet.length; i++)
            Positioned(
              left: i * avatarOverlap,
              child: Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: avatarColors[i],
                  border: Border.all(
                    color: _aiCardBackground(context),
                    width: 2,
                  ),
                ),
                child: Icon(
                  iconSet[i],
                  size: 15,
                  color: _aiPrimaryText(context),
                ),
              ),
            ),
          Positioned(
            left: iconSet.length * avatarOverlap + 2,
            child: Container(
              width: 38,
              height: avatarSize,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kAiColorPrimary,
                border: Border.all(color: _aiCardBackground(context), width: 2),
              ),
              child: Text(
                '+$extraCount',
                style: GoogleFonts.plusJakartaSans(
                  color: kColorWhite,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AiDaySelectorButton extends StatelessWidget {
  const _AiDaySelectorButton({
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
        customBorder: const CircleBorder(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected
                ? kAiColorPrimary.withValues(alpha: 0.12)
                : _aiCardBackground(context),
            border: Border.all(
              color: selected ? kAiColorPrimary : _aiCardBorder(context),
              width: selected ? 2 : 1,
            ),
          ),
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: selected ? kAiColorPrimary : _aiPrimaryText(context),
            ),
          ),
        ),
      ),
    );
  }
}

class _AiTimeOption {
  const _AiTimeOption({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;
}

class _AiTimePreferenceButton extends StatelessWidget {
  const _AiTimePreferenceButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: selected
                ? kAiColorPrimary.withValues(alpha: 0.12)
                : _aiCardBackground(context),
            border: Border.all(
              color: selected ? kAiColorPrimary : _aiCardBorder(context),
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon,
                size: 18,
                color: selected ? kAiColorPrimary : _aiPrimaryText(context),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: selected ? kAiColorPrimary : _aiPrimaryText(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AiRealtimeMapPreview extends StatelessWidget {
  const _AiRealtimeMapPreview({
    required this.mapCenter,
    required this.radiusMiles,
    required this.onMapCenterChanged,
  });

  final LatLng mapCenter;
  final double radiusMiles;
  final ValueChanged<LatLng> onMapCenterChanged;

  @override
  Widget build(BuildContext context) {
    final radiusMeters = _milesToMeters(radiusMiles);

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: SizedBox(
        height: 210,
        child: FlutterMap(
          options: MapOptions(
            initialCenter: mapCenter,
            initialZoom: 12.5,
            minZoom: 4,
            maxZoom: 18,
            onTap: (_, LatLng point) => onMapCenterChanged(point),
            onPositionChanged: (position, bool hasGesture) {
              final center = position.center;
              if (!hasGesture) {
                return;
              }
              onMapCenterChanged(center);
            },
          ),
          children: <Widget>[
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.activly.app',
            ),
            CircleLayer(
              circles: <CircleMarker>[
                CircleMarker(
                  point: mapCenter,
                  radius: radiusMeters,
                  useRadiusInMeter: true,
                  color: kAiColorPrimary.withValues(alpha: 0.12),
                  borderColor: kAiColorPrimary.withValues(alpha: 0.48),
                  borderStrokeWidth: 2,
                ),
              ],
            ),
            MarkerLayer(
              markers: <Marker>[
                Marker(
                  point: mapCenter,
                  width: 22,
                  height: 22,
                  alignment: Alignment.center,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: kAiColorPrimary,
                    ),
                    child: const Center(
                      child: Icon(Icons.circle, size: 8, color: kColorWhite),
                    ),
                  ),
                ),
              ],
            ),
            RichAttributionWidget(
              alignment: AttributionAlignment.bottomRight,
              attributions: const <SourceAttribution>[
                TextSourceAttribution('OpenStreetMap contributors'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AiSelectableLabel {
  const _AiSelectableLabel({
    required this.value,
    required this.label,
    this.icon,
  });

  final String value;
  final String label;
  final IconData? icon;
}

class _AiSkillLevelButton extends StatelessWidget {
  const _AiSkillLevelButton({
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;

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
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? kAiColorPrimary : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? kAiColorPrimary
                  : _aiGlassBorderColor(context).withValues(alpha: 0.4),
              width: selected ? 1.5 : 1,
            ),
            boxShadow: selected
                ? <BoxShadow>[
                    BoxShadow(
                      blurRadius: 20,
                      spreadRadius: -10,
                      offset: const Offset(0, 8),
                      color: kAiColorPrimary.withValues(alpha: 0.35),
                    ),
                  ]
                : const <BoxShadow>[],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (icon != null) ...<Widget>[
                Icon(
                  icon,
                  size: 22,
                  color: selected ? Colors.white : _aiMutedText(context),
                ),
                const SizedBox(height: 4),
              ],
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: selected ? Colors.white : _aiMutedText(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AiFocusAreaChip extends StatelessWidget {
  const _AiFocusAreaChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: selected
                ? kAiColorPrimary.withValues(alpha: 0.12)
                : _aiCardBackground(context),
            border: Border.all(
              color: selected ? kAiColorPrimary : _aiCardBorder(context),
              width: selected ? 2 : 1,
            ),
            boxShadow: selected
                ? <BoxShadow>[
                    BoxShadow(
                      blurRadius: 16,
                      spreadRadius: -8,
                      offset: const Offset(0, 6),
                      color: kAiColorPrimary.withValues(alpha: 0.18),
                    ),
                  ]
                : const <BoxShadow>[],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (icon != null) ...<Widget>[
                Icon(
                  icon,
                  size: 18,
                  color: selected ? kAiColorPrimary : _aiMutedText(context),
                ),
                const SizedBox(width: 7),
              ],
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: selected ? kAiColorPrimary : _aiPrimaryText(context),
                ),
              ),
              if (selected) ...<Widget>[
                const SizedBox(width: 7),
                Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kAiColorPrimary,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _AiSecondStepHeroCard extends StatelessWidget {
  const _AiSecondStepHeroCard();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: kAiColorPrimary.withValues(alpha: 0.08),
          border: Border.all(color: kColorWhite, width: 4),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              blurRadius: 26,
              spreadRadius: -18,
              offset: Offset(0, 14),
              color: kAiShadowMedium,
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDIcanxNqodQs69sKXENv4oxZMAHzII7zmGA8uroZP9s7XXkSfU3KG484vr1j9tLSMT3Q3_MYvnzPTg1BxtdVBiOyFa2Lj_QRAuqomyQplEmBP3brz0R9bTcrULBm8co1-Q5CSU2J23TgVxZDFEh5SpCp02_oxMqukhh6O4NhDOaV19cfLCACBRycnYdueFOi_gbM5fvPeGllZEohIF2bUskDLyTGkqLMtvwHvueG3_fun-L8IlmDNgtZcx3hH922qNKq4SiaCKiAM',
              fit: BoxFit.cover,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            kAiColorPrimary.withValues(alpha: 0.18),
                            kAiColorPrimaryAccent.withValues(alpha: 0.36),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.smart_toy_rounded,
                          color: kColorWhite,
                          size: 52,
                        ),
                      ),
                    );
                  },
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.transparent,
                    kAiColorPrimary.withValues(alpha: 0.20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AiSectionLabel extends StatelessWidget {
  const _AiSectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.8,
        color: _aiMutedText(context).withValues(alpha: 0.7),
      ),
    );
  }
}

class _AiCompactInputField extends StatelessWidget {
  const _AiCompactInputField({
    required this.controller,
    required this.hintText,
    required this.icon,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: _aiPrimaryText(context),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.plusJakartaSans(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: _aiMutedText(context),
        ),
        prefixIcon: Icon(icon, size: 18, color: _aiMutedText(context)),
        filled: true,
        fillColor: _aiCardBackground(context),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: _aiCardBorder(context)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: _aiCardBorder(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: kAiColorPrimary, width: 1.5),
        ),
      ),
    );
  }
}

class _AiGenderChip extends StatelessWidget {
  const _AiGenderChip({
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
        borderRadius: BorderRadius.circular(999),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: selected
                ? kAiColorPrimary.withValues(alpha: 0.12)
                : _aiCardBackground(context),
            border: Border.all(
              color: selected ? kAiColorPrimary : _aiCardBorder(context),
            ),
          ),
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: selected ? kAiColorPrimary : _aiPrimaryText(context),
            ),
          ),
        ),
      ),
    );
  }
}

class _AiKidLiveProfileCard extends StatefulWidget {
  const _AiKidLiveProfileCard({
    required this.isArabic,
    required this.kidName,
    required this.kidAge,
    required this.kidGender,
    required this.selectedInterests,
    required this.detailsSaved,
    required this.savedAt,
  });

  final bool isArabic;
  final String kidName;
  final String kidAge;
  final String kidGender;
  final Set<String> selectedInterests;
  final bool detailsSaved;
  final DateTime? savedAt;

  @override
  State<_AiKidLiveProfileCard> createState() => _AiKidLiveProfileCardState();
}

class _AiKidLiveProfileCardState extends State<_AiKidLiveProfileCard> {
  bool _showHint = false;

  // Maps each interest value to its badge image asset path.
  static const Map<String, String> _badgePaths = <String, String>{
    'Art & Craft': 'assets/images/ai_match/badge_arts.png',
    'Soccer': 'assets/images/ai_match/badge_soccer.png',
    'Science': 'assets/images/ai_match/badge_science.png',
    'Music': 'assets/images/ai_match/badge_music.png',
  };

  // Short display labels used under each badge.
  static const Map<String, String> _badgeLabels = <String, String>{
    'Art & Craft': 'Arts',
    'Soccer': 'Soccer',
    'Science': 'Science',
    'Music': 'Music',
  };

  String _interestHint(bool isArabic) {
    final interests = widget.selectedInterests;
    if (interests.contains('Soccer')) {
      return isArabic
          ? 'Ø§Ø®ØªÙŠØ§Ø± ÙƒØ±Ø© Ø§Ù„Ù‚Ø¯Ù… Ù…Ù…ØªØ§Ø². Ø§Ù‚ØªØ±Ø­ Ø¬Ù„Ø³Ø© ØªØ¬Ø±ÙŠØ¨ÙŠØ© Ù…Ø³Ø§Ø¡Ù‹ Ù„Ù‚ÙŠØ§Ø³ Ø§Ù„Ø­Ù…Ø§Ø³.'
          : 'Soccer is a strong pick. Try an evening trial first to test energy.';
    }
    if (interests.contains('Science')) {
      return isArabic
          ? 'Ù…ÙŠÙˆÙ„ Ø§Ù„Ø¹Ù„ÙˆÙ… ÙˆØ§Ø¶Ø­Ø©. Ø§Ø¨Ø­Ø« Ø¹Ù† Ø¨Ø±Ù†Ø§Ù…Ø¬ ØªØ·Ø¨ÙŠÙ‚ÙŠ ÙˆØªØ¬Ø§Ø±Ø¨ Ø¹Ù…Ù„ÙŠØ©.'
          : 'Science interest looks clear. Prioritize hands-on experiment programs.';
    }
    if (interests.contains('Music')) {
      return isArabic
          ? 'Ø§Ù„Ù…ÙˆØ³ÙŠÙ‚Ù‰ Ø®ÙŠØ§Ø± Ø±Ø§Ø¦Ø¹. Ø§Ø¨Ø¯Ø£ Ø¨Ø­ØµØµ Ù‚ØµÙŠØ±Ø© Ø«Ù… Ø²Ø¯ Ø§Ù„Ù…Ø¯Ø© ØªØ¯Ø±ÙŠØ¬ÙŠØ§Ù‹.'
          : 'Music is a great path. Start with short sessions, then scale duration.';
    }
    if (interests.contains('Art & Craft')) {
      return isArabic
          ? 'Ø§Ù„ÙÙ† Ù…Ù†Ø§Ø³Ø¨ Ù„Ù‡Ø°Ø§ Ø§Ù„Ù…Ù„Ù. Ø±ÙƒØ² Ø¹Ù„Ù‰ Ø¨ÙŠØ¦Ø© Ù‡Ø§Ø¯Ø¦Ø© ÙˆÙ…Ø¯Ø±Ø¨Ø© ØµØ¨ÙˆØ±Ø©.'
          : 'Art fits this profile well. Look for calm spaces with patient mentors.';
    }

    return isArabic
        ? 'Ø§Ø®ØªØ± Ø§Ù‡ØªÙ…Ø§Ù…Ø§Ù‹ Ù„Ø±ÙØ¹ Ø¯Ù‚Ø© Ø§Ù„Ù…Ø·Ø§Ø¨Ù‚Ø© Ù‚Ø¨Ù„ Ø§Ù„Ø§Ù†ØªÙ‚Ø§Ù„ Ù„Ù„Ø®Ø·ÙˆØ© Ø§Ù„ØªØ§Ù„ÙŠØ©.'
        : 'Pick interests to improve matching precision before continuing.';
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = widget.isArabic;
    final score =
        ((widget.kidName.isNotEmpty ? 0.32 : 0.0) +
                (widget.kidAge.isNotEmpty ? 0.24 : 0.0) +
                (widget.kidGender.isNotEmpty ? 0.18 : 0.0) +
                (widget.selectedInterests.isNotEmpty ? 0.26 : 0.0))
            .clamp(0.0, 1.0);
    final scorePercent = (score * 100).round();
    final status = score >= 0.8
        ? (isArabic ? 'Ø¬Ø§Ù‡Ø² Ù„Ù„Ù…Ø·Ø§Ø¨Ù‚Ø©' : 'Ready to match')
        : (isArabic
              ? 'Ø§Ù„Ù…Ù„Ù ÙŠØ­ØªØ§Ø¬ Ù„Ù…Ø³Ø© Ø£Ø®ÙŠØ±Ø©'
              : 'Profile needs one more touch');

    String? savedAtLabel;
    if (widget.savedAt != null) {
      final hour = widget.savedAt!.hour.toString().padLeft(2, '0');
      final minute = widget.savedAt!.minute.toString().padLeft(2, '0');
      savedAtLabel = isArabic
          ? 'Ø¢Ø®Ø± Ø­ÙØ¸ $hour:$minute'
          : 'Saved at $hour:$minute';
    }

    Widget profileChip({required IconData icon, required String text}) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: _aiSurfaceContainer(context),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: _aiCardBorder(context)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 13, color: _aiMutedText(context)),
            const SizedBox(width: 5),
            Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: _aiPrimaryText(context),
              ),
            ),
          ],
        ),
      );
    }

    Widget passionBadge(String interest) {
      final badgePath = _badgePaths[interest];
      final label = _badgeLabels[interest] ?? interest;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _aiSurfaceContainer(context),
              border: Border.all(
                color: kAiColorPrimary.withValues(alpha: 0.15),
                width: 1.5,
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  blurRadius: 12,
                  spreadRadius: -4,
                  color: kAiColorPrimary.withValues(alpha: 0.12),
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: badgePath != null
                ? ClipOval(
                    child: Image.asset(
                      badgePath,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return Icon(
                          Icons.interests_rounded,
                          size: 26,
                          color: kAiColorPrimary,
                        );
                      },
                    ),
                  )
                : Icon(
                    Icons.interests_rounded,
                    size: 26,
                    color: kAiColorPrimary,
                  ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: _aiPrimaryText(context),
            ),
          ),
        ],
      );
    }

    final hasInterests = widget.selectedInterests.isNotEmpty;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _showHint = !_showHint),
        borderRadius: BorderRadius.circular(22),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: _aiCardBackground(context),
            border: Border.all(
              color: widget.detailsSaved
                  ? kAiColorPrimary.withValues(alpha: 0.55)
                  : _aiCardBorder(context),
              width: widget.detailsSaved ? 1.4 : 1,
            ),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                blurRadius: 18,
                spreadRadius: -14,
                offset: Offset(0, 10),
                color: kAiShadowMedium,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // â”€â”€ Header â”€â”€
              Row(
                children: <Widget>[
                  Icon(
                    Icons.auto_awesome_rounded,
                    size: 17,
                    color: kAiColorPrimary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      isArabic ? 'Ø¨Ø·Ø§Ù‚Ø© Ø§Ù„Ù…Ù„Ù Ø§Ù„Ø°ÙƒÙŠØ©' : 'Live Profile Card',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: _aiPrimaryText(context),
                      ),
                    ),
                  ),
                  if (widget.detailsSaved)
                    Icon(
                      Icons.check_circle_rounded,
                      size: 18,
                      color: kAiColorPrimary,
                    ),
                ],
              ),
              const SizedBox(height: 12),

              // â”€â”€ Body â”€â”€
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                child: _showHint
                    ? Text(
                        _interestHint(isArabic),
                        key: const ValueKey<String>('hint-mode'),
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _aiMutedText(context),
                          height: 1.45,
                        ),
                      )
                    : Column(
                        key: const ValueKey<String>('profile-mode'),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Avatar + chips row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _aiSurfaceContainer(context),
                                  border: Border.all(
                                    color: kAiColorPrimary.withValues(
                                      alpha: 0.25,
                                    ),
                                    width: 2,
                                  ),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      blurRadius: 16,
                                      spreadRadius: -4,
                                      color: kAiColorPrimary.withValues(
                                        alpha: 0.18,
                                      ),
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/ai_match/child_avatar.png',
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context,
                                        Object error,
                                        StackTrace? stackTrace) {
                                      return Icon(
                                        Icons.child_care_rounded,
                                        size: 32,
                                        color: kAiColorPrimary,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Wrap(
                                      spacing: 6,
                                      runSpacing: 6,
                                      children: <Widget>[
                                        profileChip(
                                          icon: Icons.badge_rounded,
                                          text: widget.kidName.isEmpty
                                              ? (isArabic
                                                  ? 'Ø§Ù„Ø§Ø³Ù…'
                                                  : 'Name')
                                              : widget.kidName,
                                        ),
                                        profileChip(
                                          icon: Icons.cake_rounded,
                                          text: widget.kidAge.isEmpty
                                              ? (isArabic
                                                  ? 'Ø§Ù„Ø¹Ù…Ø±'
                                                  : 'Age')
                                              : widget.kidAge,
                                        ),
                                        profileChip(
                                          icon:
                                              Icons.person_outline_rounded,
                                          text: widget.kidGender,
                                        ),
                                      ],
                                    ),
                                    if (hasInterests) ...<Widget>[
                                      const SizedBox(height: 8),
                                      Text(
                                        isArabic
                                            ? 'Ù…Ù„Ø®Øµ Ø§Ù„Ø´ØºÙ'
                                            : 'Passions Summary',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w800,
                                          color: _aiPrimaryText(context),
                                        ),
                                      ),
                                      Text(
                                        isArabic
                                            ? 'Ø­Ø§Ù„Ø© Ø§Ù„Ù…Ù„Ù:'
                                            : 'Profile Status:',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 10.5,
                                          fontWeight: FontWeight.w600,
                                          color: _aiMutedText(context),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // Passion badges
                          if (hasInterests) ...<Widget>[
                            const SizedBox(height: 12),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: widget.selectedInterests
                                    .map((String interest) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(right: 18),
                                    child: passionBadge(interest),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],

                          // Empty state
                          if (!hasInterests) ...<Widget>[
                            const SizedBox(height: 8),
                            Text(
                              isArabic
                                  ? 'Ù„Ø§ ØªØ²Ø§Ù„ Ø´ØºÙØ§ØªÙƒ ÙÙŠ Ø§Ù†ØªØ¸Ø§Ø± Ø§Ù„Ø§ÙƒØªØ´Ø§Ùâ€¦'
                                  : 'Passions yet to be discoveredâ€¦',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: _aiMutedText(context),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
              ),

              const SizedBox(height: 12),

              // â”€â”€ Progress bar â”€â”€
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  minHeight: 7,
                  value: score,
                  backgroundColor: _aiSurfaceContainer(context),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    kAiColorPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // â”€â”€ Footer â”€â”€
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '$status â€¢ $scorePercent%',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: _aiPrimaryText(context),
                      ),
                    ),
                  ),
                  Text(
                    savedAtLabel ??
                        (isArabic
                            ? 'Ø§Ù†Ù‚Ø± Ù„Ù„Ø§Ù†ØªÙ‚Ø§Ù„ Ø¨ÙŠÙ† Ø§Ù„Ù…Ù„Ø®Øµ ÙˆØ§Ù„Ù†ØµÙŠØ­Ø©'
                            : 'Tap to switch summary and hint'),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: _aiMutedText(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class _AiInterestOption {
  const _AiInterestOption({
    required this.value,
    required this.label,
    required this.icon,
    required this.imagePath,
  });

  final String value;
  final String label;
  final IconData icon;
  final String imagePath;
}

class _AiInterestHorizontalList extends StatelessWidget {
  const _AiInterestHorizontalList({
    required this.interests,
    required this.selectedInterests,
    required this.onToggleInterest,
  });

  final List<_AiInterestOption> interests;
  final Set<String> selectedInterests;
  final ValueChanged<String> onToggleInterest;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        clipBehavior: Clip.none,
        itemCount: interests.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 12),
        itemBuilder: (BuildContext context, int index) {
          final option = interests[index];
          return _AiInterestVerticalCard(
            option: option,
            selected: selectedInterests.contains(option.value),
            onTap: () => onToggleInterest(option.value),
          );
        },
      ),
    );
  }
}

class _AiInterestVerticalCard extends StatelessWidget {
  const _AiInterestVerticalCard({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final _AiInterestOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOut,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: selected
                  ? kAiColorPrimary
                  : _aiCardBorder(context),
              width: selected ? 2.5 : 1.2,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: selected ? 24 : 14,
                spreadRadius: selected ? -8 : -12,
                offset: const Offset(0, 10),
                color: selected
                    ? kAiColorPrimary.withValues(alpha: 0.30)
                    : kAiShadowMedium,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(21),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                // Background image
                Image.asset(
                  option.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Container(
                      color: _aiSurfaceContainer(context),
                      child: Center(
                        child: Icon(
                          option.icon,
                          size: 48,
                          color: _aiMutedText(context).withValues(alpha: 0.4),
                        ),
                      ),
                    );
                  },
                ),
                // Bottom gradient overlay for label readability
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.70),
                        ],
                      ),
                    ),
                  ),
                ),
                // Label at bottom
                Positioned(
                  left: 10,
                  right: 10,
                  bottom: 10,
                  child: Text(
                    option.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(
                          blurRadius: 6,
                          color: Colors.black.withValues(alpha: 0.5),
                        ),
                      ],
                    ),
                  ),
                ),
                // Selection indicator (top-right checkmark)
                if (selected)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kAiColorPrimary,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurRadius: 8,
                            spreadRadius: -2,
                            color: kAiColorPrimary.withValues(alpha: 0.5),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
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
          const SizedBox(width: 6),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kAiColorPrimary.withValues(alpha: 0.10),
              border: Border.all(
                color: kAiColorPrimary.withValues(alpha: 0.20),
              ),
            ),
            child: const Icon(
              Icons.smart_toy_rounded,
              size: 17,
              color: kAiColorPrimary,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.send,
              style: GoogleFonts.plusJakartaSans(
                color: _aiPrimaryText(context),
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: isArabic ? 'Ø§ÙƒØªØ¨ Ø±Ø³Ø§Ù„ØªÙƒ...' : 'Type your message...',
                hintStyle: GoogleFonts.plusJakartaSans(
                  color: _aiMutedText(context),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 4),
            child: Material(
              color: kAiColorPrimary.withValues(alpha: 0.10),
              shape: const CircleBorder(),
              child: InkWell(
                onTap: () {},
                customBorder: const CircleBorder(),
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(
                    Icons.mic_none_rounded,
                    size: 20,
                    color: kAiColorPrimary,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: <Color>[kAiColorPrimaryAccent, kAiColorPrimary],
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 22,
                    spreadRadius: -16,
                    offset: Offset(0, 10),
                    color: kAiShadowPurple,
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {},
                  customBorder: const CircleBorder(),
                  child: const SizedBox(
                    width: 42,
                    height: 42,
                    child: Icon(
                      Icons.send_rounded,
                      size: 20,
                      color: kColorWhite,
                    ),
                  ),
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
    required this.isChatMode,
    required this.contentBottomPadding,
    required this.inputBottomOffset,
    required this.showBottomNav,
  });

  final bool isInAppMode;
  final bool isChatMode;
  final double contentBottomPadding;
  final double inputBottomOffset;
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
    final topBarTop = kFixedTopSpace + kTopControlsVerticalOffset;
    final fixedChatToggleTop = topBarTop + 52;
    final contentTopPadding = fixedChatToggleTop;
    final topShadowHeight = fixedChatToggleTop;
    final bottomFadeHeight = widget.isChatMode
        ? widget.inputBottomOffset + 108
        : 0.0;

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
                          contentTopPadding,
                          20,
                          widget.contentBottomPadding,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Center(
                              child: _AiSkeletonBlock(
                                height: 54,
                                radius: 18,
                                color: baseColor,
                              ),
                            ),
                            const SizedBox(height: 18),
                            if (!widget.isChatMode) ...<Widget>[
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
                            ] else ...<Widget>[
                              _AiSkeletonBlock(
                                height: 90,
                                radius: 20,
                                color: baseColor,
                              ),
                              const SizedBox(height: 14),
                            ],
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
                top: 0,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: _AiTopShadowOverlay(height: topShadowHeight),
                ),
              ),
              if (widget.isChatMode)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: IgnorePointer(
                    child: _AiBottomShadowOverlay(height: bottomFadeHeight),
                  ),
                ),
              Positioned(
                top: topBarTop,
                left: kTopControlsSidePadding,
                right: kTopControlsSidePadding,
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 40, height: 40),
                    Expanded(
                      child: widget.isChatMode
                          ? const SizedBox.shrink()
                          : Align(
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
              if (widget.isChatMode)
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
