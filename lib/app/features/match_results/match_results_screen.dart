part of 'package:activly/activly_app.dart';

class MatchResultsScreen extends StatefulWidget {
  const MatchResultsScreen({
    super.key,
    required this.language,
    required this.onBack,
  });

  final AppLanguage language;
  final VoidCallback onBack;

  @override
  State<MatchResultsScreen> createState() => _MatchResultsScreenState();
}

class _MatchResultsScreenState extends State<MatchResultsScreen> {
  int _selectedFilterIndex = 0;
  int _cardStartIndex = 0;

  static const List<String> _filters = <String>['All', 'Academy', 'Coaches'];
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

  void _showNextCard({required bool swipedRight}) {
    if (_sampleCards.isEmpty) {
      return;
    }

    final step = swipedRight ? 1 : 1;

    setState(() {
      _cardStartIndex = (_cardStartIndex + step) % _sampleCards.length;
    });
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
                                'Match Results',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 39,
                                  fontWeight: FontWeight.w800,
                                  color: kAiColorTextDark,
                                  letterSpacing: -0.6,
                                ),
                              ),
                            ),
                            _topActionButton(
                              icon: Icons.list_rounded,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.fromLTRB(
                            20,
                            16,
                            20,
                            270 + bottomInset,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                child: Row(
                                  children: List<Widget>.generate(
                                    _filters.length,
                                    (int index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          right: 12,
                                        ),
                                        child: _MatchFilterChip(
                                          label: _filters[index],
                                          selected:
                                              index == _selectedFilterIndex,
                                          onTap: () {
                                            setState(
                                              () =>
                                                  _selectedFilterIndex = index,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Center(
                                child: _MatchResultsCardStack(
                                  cards: _orderedCards
                                      .take(3)
                                      .toList(growable: false),
                                  onCardSwiped: (bool swipedRight) {
                                    _showNextCard(swipedRight: swipedRight);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 24,
                  right: 24,
                  bottom: 118 + bottomInset,
                  child: _MatchResultsSwipeControls(
                    onSkip: () => _showNextCard(swipedRight: false),
                    onSave: () => _showNextCard(swipedRight: true),
                    onSwipeHintTap: () => _showNextCard(swipedRight: true),
                  ),
                ),
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
                  child: _MatchResultsBottomNav(bottomInset: bottomInset),
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
    required this.onCardSwiped,
  });

  final List<_MatchCardData> cards;
  final ValueChanged<bool> onCardSwiped;

  @override
  State<_MatchResultsCardStack> createState() => _MatchResultsCardStackState();
}

class _MatchResultsCardStackState extends State<_MatchResultsCardStack> {
  static const double _swipeThreshold = 110;
  static const double _maxDragOffset = 260;

  double _dragDx = 0;
  bool _isAnimatingOut = false;

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

    setState(() {
      _isAnimatingOut = true;
      _dragDx = toRight ? 460 : -460;
    });

    Future<void>.delayed(const Duration(milliseconds: 220), () {
      if (!mounted) {
        return;
      }

      widget.onCardSwiped(toRight);

      setState(() {
        _dragDx = 0;
        _isAnimatingOut = false;
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

    Widget content = _MatchResultPrimaryCard(data: card);

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
          duration: Duration(milliseconds: _isAnimatingOut ? 220 : 170),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(_dragDx, 0, 0)
            ..rotateZ(rotation),
          child: content,
        ),
      );
    } else {
      content = Opacity(
        opacity: opacity,
        child: Transform.scale(
          scale: scale,
          alignment: Alignment.topCenter,
          child: IgnorePointer(child: content),
        ),
      );
    }

    return Positioned(
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

class _MatchResultPrimaryCard extends StatelessWidget {
  const _MatchResultPrimaryCard({required this.data});

  final _MatchCardData data;

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final useCompactLayout = textScale > 1.15;
    final titleFontSize = useCompactLayout ? 27.0 : 30.0;
    final subtitleFontSize = useCompactLayout ? 13.0 : 14.0;
    final rateFontSize = useCompactLayout ? 24.0 : 28.0;
    final experienceFontSize = useCompactLayout ? 23.0 : 27.0;
    final verticalSectionGap = useCompactLayout ? 14.0 : 18.0;
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
                            '${data.matchPercent}% MATCH',
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
                              data.coachName,
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
                              '${data.specialty}  •  ${data.distanceMiles.toStringAsFixed(1)} mi',
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
                          label: 'RATE',
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
                                  text: '/hr',
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
                            label: 'EXPERIENCE',
                            value: Text(
                              '${data.experienceYears} Years',
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
                                  'Book Now',
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
                                'See Profile',
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
    required this.onSkip,
    required this.onSave,
    required this.onSwipeHintTap,
  });

  final VoidCallback onSkip;
  final VoidCallback onSave;
  final VoidCallback onSwipeHintTap;

  Widget _buildSideAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Opacity(
      opacity: 0.34,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(999),
              onTap: onTap,
              child: Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _kAiMutedText.withValues(alpha: 0.28),
                  ),
                ),
                child: Icon(icon, color: _kAiMutedText, size: 31),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _kAiMutedText,
              letterSpacing: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildSideAction(
              icon: Icons.close_rounded,
              label: 'SKIP',
              onTap: onSkip,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: onSwipeHintTap,
                child: Container(
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
              ),
            ),
            _buildSideAction(
              icon: Icons.favorite_border_rounded,
              label: 'SAVE',
              onTap: onSave,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'SWIPE FOR MORE',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: kAiColorPrimary,
            letterSpacing: 2.4,
          ),
        ),
      ],
    );
  }
}

class _MatchResultsBottomNav extends StatelessWidget {
  const _MatchResultsBottomNav({required this.bottomInset});

  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(14, 10, 14, 10 + bottomInset),
      decoration: BoxDecoration(
        color: kColorWhite.withValues(alpha: 0.86),
        border: const Border(top: BorderSide(color: kAiColorSurfaceBorder)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _MatchBottomNavItem(icon: Icons.home_rounded, label: 'HOME'),
          _MatchBottomNavItem(icon: Icons.search_rounded, label: 'SEARCH'),
          _MatchBottomNavItem(
            icon: Icons.explore_rounded,
            label: 'MATCH',
            selected: true,
          ),
          _MatchBottomNavItem(icon: Icons.person_rounded, label: 'PROFILE'),
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
