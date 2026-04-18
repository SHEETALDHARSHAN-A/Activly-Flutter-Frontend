part of 'package:activly/activly_app.dart';

class MatchResultsScreen extends StatefulWidget {
  const MatchResultsScreen({
    super.key,
    required this.language,
    required this.onToggleLanguage,
    required this.onBack,
  });

  final AppLanguage language;
  final VoidCallback onToggleLanguage;
  final VoidCallback onBack;

  @override
  State<MatchResultsScreen> createState() => _MatchResultsScreenState();
}

class _MatchResultsScreenState extends State<MatchResultsScreen> {
  int _selectedFilterIndex = 0;
  int _cardStartIndex = 0;
  bool _hasSwipedFirstCard = false;
  bool _showListLayout = false;

  static const List<_MatchCardData> _sampleCards = <_MatchCardData>[
    _MatchCardData(
      coachName: 'Coach Marcus',
      specialty: 'Soccer Specialist',
      distanceMiles: 2.4,
      rating: 4.9,
      matchPercent: 98,
      ratePerHour: 85,
      experienceYears: 8,
      imageAssetPath: 'assets/images/ai_match/soccer.png',
    ),
    _MatchCardData(
      coachName: 'Coach Elena',
      specialty: 'Creative Dance Coach',
      distanceMiles: 1.8,
      rating: 4.8,
      matchPercent: 96,
      ratePerHour: 72,
      experienceYears: 6,
      imageAssetPath: 'assets/images/ai_match/music.png',
    ),
    _MatchCardData(
      coachName: 'Coach Samir',
      specialty: 'STEM Activity Mentor',
      distanceMiles: 3.1,
      rating: 4.7,
      matchPercent: 94,
      ratePerHour: 68,
      experienceYears: 7,
      imageAssetPath: 'assets/images/ai_match/science.png',
    ),
  ];

  List<_MatchCardData> get _orderedCards {
    if (_sampleCards.isEmpty) {
      return const <_MatchCardData>[];
    }

    return List<_MatchCardData>.generate(_sampleCards.length, (int index) {
      final sourceIndex = (_cardStartIndex + index) % _sampleCards.length;
      return _sampleCards[sourceIndex];
    }, growable: false);
  }

  void _showNextCard({
    required bool swipedRight,
    bool markSwipeHintConsumed = false,
  }) {
    if (_sampleCards.isEmpty) {
      return;
    }

    final step = swipedRight ? 1 : 1;

    setState(() {
      _cardStartIndex = (_cardStartIndex + step) % _sampleCards.length;
      if (markSwipeHintConsumed) {
        _hasSwipedFirstCard = true;
      }
    });
  }

  void _toggleResultsLayout() {
    setState(() {
      _showListLayout = !_showListLayout;
    });
  }

  Widget _buildFilterRow({required bool isArabic}) {
    final filters = <String>[
      _mrTr(
        context,
        isArabic ? 'الكل' : 'All',
        (l10n) => l10n.matchResultsFilterAll,
      ),
      _mrTr(
        context,
        isArabic ? 'الأكاديميات' : 'Academy',
        (l10n) => l10n.matchResultsFilterAcademy,
      ),
      _mrTr(
        context,
        isArabic ? 'المدربون' : 'Coaches',
        (l10n) => l10n.matchResultsFilterCoaches,
      ),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List<Widget>.generate(filters.length, (int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _MatchFilterChip(
              label: filters[index],
              selected: index == _selectedFilterIndex,
              onTap: () {
                setState(() => _selectedFilterIndex = index);
              },
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSwipeResultsContent({
    required double bottomInset,
    required bool isArabic,
  }) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(20, 16, 20, 270 + bottomInset),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: _MatchResultsCardStack(
              cards: _orderedCards.take(3).toList(growable: false),
              isArabic: isArabic,
              onCardSwiped: (bool swipedRight) {
                _showNextCard(
                  swipedRight: swipedRight,
                  markSwipeHintConsumed: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListResultsContent({
    required double bottomInset,
    required bool isArabic,
  }) {
    final cards = _orderedCards;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildFilterRow(isArabic: isArabic),
          const SizedBox(height: 14),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 140 + bottomInset),
              itemCount: cards.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 12),
              itemBuilder: (BuildContext context, int index) {
                return _MatchResultListCard(
                  data: cards[index],
                  isArabic: isArabic,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _topActionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, color: kAiColorTextDark, size: 28),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = widget.language == AppLanguage.ar;
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final screenTitle = _mrTr(
      context,
      isArabic ? 'نتائج المطابقة' : 'Match Results',
      (l10n) => l10n.matchResultsTitle,
    );

    return Theme(
      data: Theme.of(context).copyWith(brightness: Brightness.light),
      child: Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: SafeArea(
          top: false,
          child: DecoratedBox(
            decoration: const BoxDecoration(color: kAiColorPageBackground),
            child: Stack(
              children: <Widget>[
                const Positioned.fill(child: _AiAmbientBackground()),
                Positioned.fill(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: kFixedTopSpace + kTopControlsVerticalOffset + 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: <Widget>[
                            _topActionButton(
                              icon: isArabic
                                  ? Icons.chevron_right_rounded
                                  : Icons.chevron_left_rounded,
                              onTap: widget.onBack,
                            ),
                            Expanded(
                              child: Text(
                                screenTitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 39,
                                  fontWeight: FontWeight.w800,
                                  color: kAiColorTextDark,
                                  letterSpacing: -0.6,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Transform.scale(
                                  scale: 0.90,
                                  alignment: Alignment.center,
                                  child: LanguageToggle(
                                    language: widget.language,
                                    onToggle: widget.onToggleLanguage,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                _topActionButton(
                                  icon: Icons.list_rounded,
                                  onTap: _toggleResultsLayout,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: _showListLayout
                            ? _buildListResultsContent(
                                bottomInset: bottomInset,
                                isArabic: isArabic,
                              )
                            : _buildSwipeResultsContent(
                                bottomInset: bottomInset,
                                isArabic: isArabic,
                              ),
                      ),
                    ],
                  ),
                ),
                if (!_showListLayout)
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: 118 + bottomInset,
                    child: _MatchResultsSwipeControls(
                      showHint: !_hasSwipedFirstCard,
                      isArabic: isArabic,
                    ),
                  ),
                if (!_showListLayout)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 62 + bottomInset,
                    child: IgnorePointer(
                      child: SizedBox(
                        height: 120,
                        child: CustomPaint(painter: _MatchResultsWavePainter()),
                      ),
                    ),
                  ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _MatchResultsBottomNav(
                    bottomInset: bottomInset,
                    isArabic: isArabic,
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

class _MatchFilterChip extends StatelessWidget {
  const _MatchFilterChip({
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
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            gradient: selected
                ? const LinearGradient(
                    colors: <Color>[kColorPrimary, kColorPrimaryAccent],
                  )
                : null,
            color: selected ? null : kColorWhite,
            border: Border.all(
              color: selected
                  ? Colors.transparent
                  : kAiColorInputBorderLight.withValues(alpha: 0.9),
            ),
            boxShadow: selected
                ? <BoxShadow>[
                    BoxShadow(
                      color: kAiColorPrimary.withValues(alpha: 0.22),
                      blurRadius: 16,
                      spreadRadius: -4,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : const <BoxShadow>[],
          ),
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: selected ? kColorWhite : _kAiMutedText,
            ),
          ),
        ),
      ),
    );
  }
}

class _MatchResultsCardStack extends StatefulWidget {
  const _MatchResultsCardStack({
    required this.cards,
    required this.isArabic,
    required this.onCardSwiped,
  });

  final List<_MatchCardData> cards;
  final bool isArabic;
  final ValueChanged<bool> onCardSwiped;

  @override
  State<_MatchResultsCardStack> createState() => _MatchResultsCardStackState();
}

class _MatchResultsCardStackState extends State<_MatchResultsCardStack> {
  static const double _swipeThreshold = 110;
  static const double _maxDragOffset = 260;

  double _dragDx = 0;
  bool _isAnimatingOut = false;
  int _incomingEntranceTick = 0;
  String? _incomingTopCardKey;
  bool _lastSwipeToRight = true;

  @override
  void didUpdateWidget(covariant _MatchResultsCardStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    final oldTopCardKey = oldWidget.cards.isEmpty
        ? null
        : _cardIdentity(oldWidget.cards.first);
    final newTopCardKey = widget.cards.isEmpty
        ? null
        : _cardIdentity(widget.cards.first);

    if (newTopCardKey != null && newTopCardKey != oldTopCardKey) {
      _incomingTopCardKey = newTopCardKey;
      _incomingEntranceTick++;
    }
  }

  String _cardIdentity(_MatchCardData card) {
    return '${card.coachName}:${card.imageAssetPath}:${card.matchPercent}';
  }

  Widget _buildFlowingEntrance({
    required Widget child,
    required String cardKey,
  }) {
    final shouldAnimateEntrance =
        _incomingTopCardKey == cardKey &&
        !_isAnimatingOut &&
        _dragDx.abs() < 0.1;

    if (!shouldAnimateEntrance) {
      return child;
    }

    return TweenAnimationBuilder<double>(
      key: ValueKey<String>('flow-$cardKey-$_incomingEntranceTick'),
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 210),
      curve: Curves.easeOutCubic,
      child: child,
      builder: (BuildContext context, double t, Widget? animatedChild) {
        final direction = _lastSwipeToRight ? -1.0 : 1.0;
        final driftX = direction * 14 * (1 - t);
        final driftY = 9 * (1 - t);
        final arcLift = 6 * t * (1 - t);
        final rotation = direction * 0.018 * (1 - t);
        final flowScale = 0.97 + (0.03 * t);

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..translate(driftX, driftY - arcLift)
            ..rotateZ(rotation)
            ..scale(flowScale),
          child: Opacity(opacity: 0.90 + (0.10 * t), child: animatedChild),
        );
      },
    );
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_isAnimatingOut) {
      return;
    }

    setState(() {
      _dragDx = (_dragDx + details.delta.dx)
          .clamp(-_maxDragOffset, _maxDragOffset)
          .toDouble();
    });
  }

  void _animateOutCard({required bool toRight}) {
    if (_isAnimatingOut) {
      return;
    }

    _lastSwipeToRight = toRight;

    setState(() {
      _isAnimatingOut = true;
      _dragDx = toRight ? 460 : -460;
    });

    Future<void>.delayed(const Duration(milliseconds: 220), () {
      if (!mounted) {
        return;
      }

      setState(() {
        _dragDx = 0;
        _isAnimatingOut = false;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        widget.onCardSwiped(toRight);
      });
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (_isAnimatingOut) {
      return;
    }

    final velocityX = details.velocity.pixelsPerSecond.dx;
    final shouldSwipeRight = _dragDx > _swipeThreshold || velocityX > 900;
    final shouldSwipeLeft = _dragDx < -_swipeThreshold || velocityX < -900;

    if (shouldSwipeRight) {
      _animateOutCard(toRight: true);
      return;
    }

    if (shouldSwipeLeft) {
      _animateOutCard(toRight: false);
      return;
    }

    setState(() {
      _dragDx = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cards = widget.cards.take(3).toList(growable: false);

    return SizedBox(
      width: 340,
      height: 610,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          for (int depth = cards.length - 1; depth >= 0; depth--)
            _buildCardLayer(card: cards[depth], depth: depth),
        ],
      ),
    );
  }

  Widget _buildCardLayer({required _MatchCardData card, required int depth}) {
    final isTopCard = depth == 0;
    final cardKey = _cardIdentity(card);
    final horizontalInset = depth * 10.0;
    final topInset = depth * 12.0;
    final bottomInset = depth * -2.0;
    final opacity = depth == 0
        ? 1.0
        : depth == 1
        ? 0.82
        : 0.62;
    final scale = depth == 0
        ? 1.0
        : depth == 1
        ? 0.97
        : 0.94;

    Widget content = _MatchResultPrimaryCard(
      data: card,
      isArabic: widget.isArabic,
    );

    if (isTopCard) {
      final normalizedDrag = (_dragDx / _maxDragOffset).clamp(-1.0, 1.0);
      final rotation = normalizedDrag * 0.09;

      content = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        onPanCancel: () {
          setState(() {
            _dragDx = 0;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: _isAnimatingOut ? 200 : 150),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(_dragDx, 0, 0)
            ..rotateZ(rotation),
          child: content,
        ),
      );

      content = _buildFlowingEntrance(child: content, cardKey: cardKey);
    }

    content = Opacity(
      opacity: opacity,
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.topCenter,
        child: isTopCard ? content : IgnorePointer(child: content),
      ),
    );

    return AnimatedPositioned(
      key: ValueKey<String>('layer-$cardKey'),
      duration: const Duration(milliseconds: 170),
      curve: Curves.easeOut,
      left: horizontalInset,
      right: horizontalInset,
      top: topInset,
      bottom: bottomInset,
      child: content,
    );
  }
}

class _MatchCardData {
  const _MatchCardData({
    required this.coachName,
    required this.specialty,
    required this.distanceMiles,
    required this.rating,
    required this.matchPercent,
    required this.ratePerHour,
    required this.experienceYears,
    required this.imageAssetPath,
  });

  final String coachName;
  final String specialty;
  final double distanceMiles;
  final double rating;
  final int matchPercent;
  final int ratePerHour;
  final int experienceYears;
  final String imageAssetPath;
}

String _mrTr(
  BuildContext context,
  String fallback,
  String Function(AppLocalizations l10n) selector,
) {
  final l10n = AppLocalizations.of(context);
  return l10n == null ? fallback : selector(l10n);
}

String _localizedCoachName(
  BuildContext context,
  String name, {
  required bool isArabic,
}) {

  switch (name) {
    case 'Coach Marcus':
      return _mrTr(
        context,
        isArabic ? 'المدرب ماركوس' : 'Coach Marcus',
        (l10n) => l10n.matchResultsCoachMarcus,
      );
    case 'Coach Elena':
      return _mrTr(
        context,
        isArabic ? 'المدربة إلينا' : 'Coach Elena',
        (l10n) => l10n.matchResultsCoachElena,
      );
    case 'Coach Samir':
      return _mrTr(
        context,
        isArabic ? 'المدرب سمير' : 'Coach Samir',
        (l10n) => l10n.matchResultsCoachSamir,
      );
    default:
      return name;
  }
}

String _localizedSpecialty(
  BuildContext context,
  String specialty, {
  required bool isArabic,
}) {

  switch (specialty) {
    case 'Soccer Specialist':
      return _mrTr(
        context,
        isArabic ? 'متخصص كرة القدم' : 'Soccer Specialist',
        (l10n) => l10n.matchResultsSpecialtySoccer,
      );
    case 'Creative Dance Coach':
      return _mrTr(
        context,
        isArabic ? 'مدرب الرقص الإبداعي' : 'Creative Dance Coach',
        (l10n) => l10n.matchResultsSpecialtyCreativeDance,
      );
    case 'STEM Activity Mentor':
      return _mrTr(
        context,
        isArabic ? 'مرشد أنشطة STEM' : 'STEM Activity Mentor',
        (l10n) => l10n.matchResultsSpecialtyStem,
      );
    default:
      return specialty;
  }
}

class _MatchResultPrimaryCard extends StatelessWidget {
  const _MatchResultPrimaryCard({
    super.key,
    required this.data,
    required this.isArabic,
  });

  final _MatchCardData data;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final useCompactLayout = textScale > 1.15;
    final titleFontSize = useCompactLayout ? 27.0 : 30.0;
    final subtitleFontSize = useCompactLayout ? 13.0 : 14.0;
    final rateFontSize = useCompactLayout ? 24.0 : 28.0;
    final experienceFontSize = useCompactLayout ? 23.0 : 27.0;
    final verticalSectionGap = useCompactLayout ? 14.0 : 18.0;
    final distanceUnit = _mrTr(
      context,
      isArabic ? 'ميل' : 'mi',
      (l10n) => l10n.matchResultsDistanceUnitMiles,
    );
    final matchLabel = _mrTr(
      context,
      isArabic ? 'تطابق' : 'MATCH',
      (l10n) => l10n.matchResultsBadgeMatch,
    );
    final rateLabel = _mrTr(
      context,
      isArabic ? 'السعر' : 'RATE',
      (l10n) => l10n.matchResultsRateLabel,
    );
    final perHourLabel = _mrTr(
      context,
      isArabic ? '/ساعة' : '/hr',
      (l10n) => l10n.matchResultsPerHour,
    );
    final experienceLabel = _mrTr(
      context,
      isArabic ? 'الخبرة' : 'EXPERIENCE',
      (l10n) => l10n.matchResultsExperienceLabel,
    );
    final yearsLabel = _mrTr(
      context,
      isArabic ? 'سنوات' : 'Years',
      (l10n) => l10n.matchResultsYears,
    );
    final bookNowLabel = _mrTr(
      context,
      isArabic ? 'احجز الآن' : 'Book Now',
      (l10n) => l10n.matchResultsBookNow,
    );
    final seeProfileLabel = _mrTr(
      context,
      isArabic ? 'عرض الملف' : 'See Profile',
      (l10n) => l10n.matchResultsSeeProfile,
    );
    final coachName = _localizedCoachName(
      context,
      data.coachName,
      isArabic: isArabic,
    );
    final specialty = _localizedSpecialty(
      context,
      data.specialty,
      isArabic: isArabic,
    );
    final contentPadding = EdgeInsets.fromLTRB(
      22,
      useCompactLayout ? 16 : 18,
      22,
      useCompactLayout ? 16 : 18,
    );
    final buttonVerticalPadding = useCompactLayout ? 12.0 : 14.0;

    return Container(
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: kAiColorSurfaceBorder.withValues(alpha: 0.7)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kAiColorPrimary.withValues(alpha: 0.15),
            blurRadius: 40,
            spreadRadius: -12,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 300,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(
                  data.imageAssetPath,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (
                        BuildContext context,
                        Object error,
                        StackTrace? stackTrace,
                      ) {
                        return Image.asset(
                          'assets/images/ai_match/soccer.png',
                          fit: BoxFit.cover,
                        );
                      },
                ),
                Positioned(
                  top: 18,
                  right: 18,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      gradient: const LinearGradient(
                        colors: <Color>[kColorPrimary, kColorPrimaryAccent],
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: kAiColorPrimary.withValues(alpha: 0.32),
                          blurRadius: 16,
                          spreadRadius: -4,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(
                            Icons.auto_awesome_rounded,
                            color: kColorWhite,
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${data.matchPercent}% $matchLabel',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: kColorWhite,
                              letterSpacing: 1.0,
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
          Expanded(
            child: Padding(
              padding: contentPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              coachName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.w800,
                                color: kAiColorTextDark,
                                letterSpacing: -0.6,
                                height: 1.05,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '$specialty  •  ${data.distanceMiles.toStringAsFixed(1)} $distanceUnit',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: subtitleFontSize,
                                fontWeight: FontWeight.w600,
                                color: _kAiMutedText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFBEB),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFFDE68A)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Icon(
                              Icons.star_rounded,
                              color: Color(0xFFEAB308),
                              size: 17,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              data.rating.toStringAsFixed(1),
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFA16207),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: verticalSectionGap),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: _MatchMetricBlock(
                          label: rateLabel,
                          value: RichText(
                            text: TextSpan(
                              style: GoogleFonts.plusJakartaSans(
                                color: kAiColorPrimary,
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: '\$${data.ratePerHour}',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: rateFontSize,
                                    fontWeight: FontWeight.w800,
                                    height: 1.0,
                                  ),
                                ),
                                TextSpan(
                                  text: perHourLabel,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: _kAiMutedText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 44,
                        color: kAiColorInputBorderLight,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: _MatchMetricBlock(
                            label: experienceLabel,
                            value: Text(
                              '${data.experienceYears} $yearsLabel',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: experienceFontSize,
                                fontWeight: FontWeight.w800,
                                color: kAiColorTextDark,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            gradient: const LinearGradient(
                              colors: <Color>[
                                kColorPrimary,
                                kColorPrimaryAccent,
                              ],
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: kAiColorPrimary.withValues(alpha: 0.25),
                                blurRadius: 16,
                                spreadRadius: -4,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(22),
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: buttonVerticalPadding,
                                ),
                                child: Text(
                                  bookNowLabel,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    color: kColorWhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(22),
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: buttonVerticalPadding,
                              ),
                              decoration: BoxDecoration(
                                color: kColorWhite,
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                  color: kAiColorInputBorderLight,
                                ),
                              ),
                              child: Text(
                                seeProfileLabel,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: kAiColorTextDark,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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

class _MatchResultListCard extends StatelessWidget {
  const _MatchResultListCard({required this.data, required this.isArabic});

  final _MatchCardData data;
  final bool isArabic;

  Widget _buildActionButton({
    required String label,
    required bool primary,
    required VoidCallback onTap,
  }) {
    if (primary) {
      return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: const LinearGradient(
            colors: <Color>[kColorPrimary, kColorPrimaryAccent],
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: kColorWhite,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: kColorWhite,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: kAiColorInputBorderLight),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: kAiColorTextDark,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final distanceUnit = _mrTr(
      context,
      isArabic ? 'ميل' : 'mi',
      (l10n) => l10n.matchResultsDistanceUnitMiles,
    );
    final matchLabel = _mrTr(
      context,
      isArabic ? 'تطابق' : 'Match',
      (l10n) => l10n.matchResultsBadgeMatchCompact,
    );
    final perHourLabel = _mrTr(
      context,
      isArabic ? '/ساعة' : '/hr',
      (l10n) => l10n.matchResultsPerHour,
    );
    final expLabel = _mrTr(
      context,
      isArabic ? 'سنوات خبرة' : 'y exp',
      (l10n) => l10n.matchResultsExperienceCompact,
    );
    final bookLabel = _mrTr(
      context,
      isArabic ? 'احجز' : 'Book',
      (l10n) => l10n.matchResultsBook,
    );
    final profileLabel = _mrTr(
      context,
      isArabic ? 'الملف' : 'Profile',
      (l10n) => l10n.matchResultsProfile,
    );
    final coachName = _localizedCoachName(
      context,
      data.coachName,
      isArabic: isArabic,
    );
    final specialty = _localizedSpecialty(
      context,
      data.specialty,
      isArabic: isArabic,
    );

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: kAiColorSurfaceBorder.withValues(alpha: 0.8)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kAiColorPrimary.withValues(alpha: 0.12),
            blurRadius: 20,
            spreadRadius: -8,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: SizedBox(
              width: 108,
              height: 108,
              child: Image.asset(
                data.imageAssetPath,
                fit: BoxFit.cover,
                errorBuilder:
                    (
                      BuildContext context,
                      Object error,
                      StackTrace? stackTrace,
                    ) {
                      return Image.asset(
                        'assets/images/ai_match/soccer.png',
                        fit: BoxFit.cover,
                      );
                    },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        coachName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: kAiColorTextDark,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFFDE68A)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(
                            Icons.star_rounded,
                            color: Color(0xFFEAB308),
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            data.rating.toStringAsFixed(1),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFA16207),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '$specialty  •  ${data.distanceMiles.toStringAsFixed(1)} $distanceUnit',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _kAiMutedText,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: <Widget>[
                    _MatchListInfoPill(
                      icon: Icons.auto_awesome_rounded,
                      label: '${data.matchPercent}% $matchLabel',
                    ),
                    _MatchListInfoPill(
                      icon: Icons.payments_rounded,
                      label: '\$${data.ratePerHour}$perHourLabel',
                    ),
                    _MatchListInfoPill(
                      icon: Icons.workspace_premium_rounded,
                      label: '${data.experienceYears} $expLabel',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _buildActionButton(
                        label: bookLabel,
                        primary: true,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildActionButton(
                        label: profileLabel,
                        primary: false,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchListInfoPill extends StatelessWidget {
  const _MatchListInfoPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: kAiColorSurfaceContainerLight.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: kAiColorInputBorderLight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 13, color: kAiColorPrimary),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: _kAiMutedText,
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchMetricBlock extends StatelessWidget {
  const _MatchMetricBlock({required this.label, required this.value});

  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: _kAiMutedText,
            letterSpacing: 1.8,
          ),
        ),
        const SizedBox(height: 4),
        value,
      ],
    );
  }
}

class _MatchResultsSwipeControls extends StatelessWidget {
  const _MatchResultsSwipeControls({
    required this.showHint,
    required this.isArabic,
  });

  final bool showHint;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: showHint ? 1 : 0,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOut,
      child: IgnorePointer(
        ignoring: !showHint,
        child: Column(
          children: <Widget>[
            Container(
              width: 74,
              height: 74,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kColorWhite,
                border: Border.all(color: kAiColorInputBorderLight),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: kAiColorPrimary.withValues(alpha: 0.14),
                    blurRadius: 24,
                    spreadRadius: -8,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.swipe_rounded,
                color: kAiColorPrimary,
                size: 40,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _mrTr(
                context,
                isArabic ? 'اسحب للمزيد' : 'SWIPE FOR MORE',
                (l10n) => l10n.matchResultsSwipeForMore,
              ),
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: kAiColorPrimary,
                letterSpacing: isArabic ? 0.4 : 2.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MatchResultsBottomNav extends StatelessWidget {
  const _MatchResultsBottomNav({
    required this.bottomInset,
    required this.isArabic,
  });

  final double bottomInset;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(14, 10, 14, 10 + bottomInset),
      decoration: BoxDecoration(
        color: kColorWhite.withValues(alpha: 0.86),
        border: const Border(top: BorderSide(color: kAiColorSurfaceBorder)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _MatchBottomNavItem(
            icon: Icons.home_rounded,
            label: _mrTr(
              context,
              isArabic ? 'الرئيسية' : 'HOME',
              (l10n) => l10n.matchResultsNavHome,
            ),
          ),
          _MatchBottomNavItem(
            icon: Icons.search_rounded,
            label: _mrTr(
              context,
              isArabic ? 'بحث' : 'SEARCH',
              (l10n) => l10n.matchResultsNavSearch,
            ),
          ),
          _MatchBottomNavItem(
            icon: Icons.explore_rounded,
            label: _mrTr(
              context,
              isArabic ? 'مطابقة' : 'MATCH',
              (l10n) => l10n.matchResultsNavMatch,
            ),
            selected: true,
          ),
          _MatchBottomNavItem(
            icon: Icons.person_rounded,
            label: _mrTr(
              context,
              isArabic ? 'ملفي' : 'PROFILE',
              (l10n) => l10n.matchResultsNavProfile,
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchBottomNavItem extends StatelessWidget {
  const _MatchBottomNavItem({
    required this.icon,
    required this.label,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected ? kAiColorPrimary : _kAiMutedText;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 34,
          height: 34,
          decoration: selected
              ? BoxDecoration(
                  shape: BoxShape.circle,
                  color: kAiColorPrimary.withValues(alpha: 0.14),
                )
              : null,
          child: Icon(icon, color: color, size: 25),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: color,
            letterSpacing: 0.9,
          ),
        ),
      ],
    );
  }
}

class _MatchResultsWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = kAiColorPrimary.withValues(alpha: 0.24);

    final ui.Path path = ui.Path()
      ..moveTo(0, size.height * 0.62)
      ..cubicTo(
        size.width * 0.16,
        size.height * 0.28,
        size.width * 0.34,
        size.height * 0.86,
        size.width * 0.52,
        size.height * 0.56,
      )
      ..cubicTo(
        size.width * 0.70,
        size.height * 0.26,
        size.width * 0.84,
        size.height * 0.72,
        size.width,
        size.height * 0.42,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _MatchResultsWavePainter oldDelegate) => false;
}
