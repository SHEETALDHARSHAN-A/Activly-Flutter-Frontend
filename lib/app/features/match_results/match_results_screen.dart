part of 'package:activly/activly_app.dart';

class MatchResultsScreen extends StatefulWidget {
  const MatchResultsScreen({
    super.key,
    required this.language,
    required this.onToggleLanguage,
    required this.onBack,
    required this.onNavigateToMainTab,
  });

  final AppLanguage language;
  final VoidCallback onToggleLanguage;
  final VoidCallback onBack;
  final ValueChanged<int> onNavigateToMainTab;

  @override
  State<MatchResultsScreen> createState() => _MatchResultsScreenState();
}

class _MatchResultsScreenState extends State<MatchResultsScreen> {
  int _selectedFilterIndex = 0;
  int _activeSliderDotIndex = 0;
  bool _showListLayout = false;
  bool _didPrecacheMatchPhotos = false;

  static const List<_MatchCardData> _sampleCards = <_MatchCardData>[
    _MatchCardData(
      coachName: 'Coach Marcus',
      specialty: 'Soccer Specialist',
      distanceMiles: 2.4,
      rating: 4.9,
      matchPercent: 98,
      ratePerHour: 85,
      experienceYears: 8,
      photoUrl:
          'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?auto=format&fit=crop&q=80&w=1200',
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
      photoUrl:
          'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=1200',
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
      photoUrl:
          'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=1200',
      imageAssetPath: 'assets/images/ai_match/science.png',
    ),
  ];

  List<_MatchCardData> get _orderedCards {
    return _sampleCards;
  }

  void _onSliderPageChanged(int pageIndex) {
    if (_sampleCards.isEmpty) {
      return;
    }

    final normalizedIndex = pageIndex % _sampleCards.length;
    if (normalizedIndex == _activeSliderDotIndex) {
      return;
    }

    setState(() {
      _activeSliderDotIndex = normalizedIndex;
    });
  }

  void _toggleResultsLayout() {
    setState(() {
      _showListLayout = !_showListLayout;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_didPrecacheMatchPhotos) {
      return;
    }

    for (final card in _sampleCards) {
      precacheImage(NetworkImage(card.photoUrl), context);
    }
    _didPrecacheMatchPhotos = true;
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

  Widget _buildSliderResultsContent({
    required double bottomInset,
    required bool isArabic,
  }) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final sliderHeight = (constraints.maxHeight - (170 + bottomInset))
            .clamp(360.0, 590.0)
            .toDouble();

        return Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 138 + bottomInset),
          child: Center(
            child: SizedBox(
              height: sliderHeight,
              child: _MatchResultsCardSlider(
                cards: _orderedCards,
                isArabic: isArabic,
                onPageChanged: _onSliderPageChanged,
              ),
            ),
          ),
        );
      },
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
    final mainNavItems = <_MainNavEntry>[
      _MainNavEntry(
        index: 0,
        icon: Icons.home_rounded,
        label: _mrTr(
          context,
          isArabic ? 'الرئيسية' : 'Home',
          (l10n) => l10n.mainNavHome,
        ),
      ),
      _MainNavEntry(
        index: 1,
        icon: Icons.search_rounded,
        label: _mrTr(
          context,
          isArabic ? 'بحث' : 'Search',
          (l10n) => l10n.mainNavSearch,
        ),
      ),
      _MainNavEntry(
        index: 2,
        icon: Icons.auto_awesome_rounded,
        label: _mrTr(
          context,
          isArabic ? 'الذكاء الاصطناعي' : 'AI',
          (l10n) => l10n.mainNavAi,
        ),
      ),
      _MainNavEntry(
        index: 3,
        icon: Icons.explore_rounded,
        label: _mrTr(
          context,
          isArabic ? 'استكشاف' : 'Explore',
          (l10n) => l10n.mainNavExplore,
        ),
      ),
      _MainNavEntry(
        index: 4,
        icon: Icons.person_rounded,
        label: _mrTr(
          context,
          isArabic ? 'الملف الشخصي' : 'Profile',
          (l10n) => l10n.mainNavProfile,
        ),
      ),
    ];

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
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: kAiColorTextDark,
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
                            : _buildSliderResultsContent(
                                bottomInset: bottomInset,
                                isArabic: isArabic,
                              ),
                      ),
                    ],
                  ),
                ),
                if (!_showListLayout)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 126 + bottomInset,
                    child: _MatchResultsSliderDots(
                      activeIndex: _activeSliderDotIndex,
                      itemCount: _sampleCards.length,
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
                  child: _MainBottomNavigationBar(
                    bottomInset: bottomInset,
                    currentIndex: 3,
                    items: mainNavItems,
                    onSelected: (int index) {
                      if (index == 3) {
                        return;
                      }

                      widget.onNavigateToMainTab(index);
                    },
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
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: selected ? kColorWhite : _kAiMutedText,
            ),
          ),
        ),
      ),
    );
  }
}

class _MatchResultsCardSlider extends StatefulWidget {
  const _MatchResultsCardSlider({
    required this.cards,
    required this.isArabic,
    required this.onPageChanged,
  });

  final List<_MatchCardData> cards;
  final bool isArabic;
  final ValueChanged<int> onPageChanged;

  @override
  State<_MatchResultsCardSlider> createState() =>
      _MatchResultsCardSliderState();
}

class _MatchResultsCardSliderState extends State<_MatchResultsCardSlider> {
  static const int _loopSeedPage = 10000;
  late final PageController _pageController;
  late int _initialLoopPage;

  @override
  void initState() {
    super.initState();
    final cardCount = widget.cards.isEmpty ? 1 : widget.cards.length;
    _initialLoopPage = _loopSeedPage - (_loopSeedPage % cardCount);
    _pageController = PageController(
      initialPage: _initialLoopPage,
      viewportFraction: 0.86,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || widget.cards.isEmpty) {
        return;
      }
      widget.onPageChanged(_initialLoopPage % widget.cards.length);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _MatchResultsCardSlider oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.cards.length == widget.cards.length || widget.cards.isEmpty) {
      return;
    }

    final currentPage = _pageController.hasClients
        ? (_pageController.page?.round() ?? _pageController.initialPage)
        : _pageController.initialPage;
    widget.onPageChanged(currentPage % widget.cards.length);
  }

  double _pageDeltaFor(int pageIndex) {
    final currentPage = _pageController.hasClients
        ? (_pageController.page ?? _pageController.initialPage.toDouble())
        : _pageController.initialPage.toDouble();
    return pageIndex - currentPage;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cards.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: 360,
      child: PageView.builder(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int pageIndex) {
          final card = widget.cards[pageIndex % widget.cards.length];

          return AnimatedBuilder(
            animation: _pageController,
            child: RepaintBoundary(
              child: _MatchResultPrimaryCard(
                data: card,
                isArabic: widget.isArabic,
              ),
            ),
            builder: (BuildContext context, Widget? animatedChild) {
              final pageDelta = _pageDeltaFor(pageIndex);
              final clampedDistance = pageDelta
                  .abs()
                  .clamp(0.0, 1.4)
                  .toDouble();
              final scale = (1 - (clampedDistance * 0.10))
                  .clamp(0.86, 1.0)
                  .toDouble();
              final translateY = (clampedDistance * 18).toDouble();
              final opacity = (1 - (clampedDistance * 0.22))
                  .clamp(0.70, 1.0)
                  .toDouble();

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                child: Opacity(
                  opacity: opacity,
                  child: Transform.translate(
                    offset: Offset(0, translateY),
                    child: Transform.scale(
                      scale: scale,
                      alignment: Alignment.topCenter,
                      child: animatedChild,
                    ),
                  ),
                ),
              );
            },
          );
        },
        onPageChanged: (int pageIndex) {
          widget.onPageChanged(pageIndex % widget.cards.length);
        },
      ),
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
    required this.photoUrl,
  });

  final String coachName;
  final String specialty;
  final double distanceMiles;
  final double rating;
  final int matchPercent;
  final int ratePerHour;
  final int experienceYears;
  final String photoUrl;
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

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final compactByHeight = constraints.maxHeight < 570;
        final veryCompactByHeight = constraints.maxHeight < 535;
        final useCompactLayout = textScale > 1.15 || compactByHeight;
        final titleFontSize = veryCompactByHeight
            ? 25.0
            : useCompactLayout
            ? 27.0
            : 30.0;
        final subtitleFontSize = veryCompactByHeight
            ? 12.0
            : useCompactLayout
            ? 13.0
            : 14.0;
        final rateFontSize = veryCompactByHeight
            ? 22.0
            : useCompactLayout
            ? 24.0
            : 28.0;
        final experienceFontSize = veryCompactByHeight
            ? 21.0
            : useCompactLayout
            ? 23.0
            : 27.0;
        final verticalSectionGap = veryCompactByHeight
            ? 10.0
            : useCompactLayout
            ? 14.0
            : 18.0;
        final imageHeight = veryCompactByHeight
            ? 238.0
            : compactByHeight
            ? 258.0
            : 300.0;
        final metricDividerHeight = veryCompactByHeight ? 36.0 : 44.0;
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
          veryCompactByHeight
              ? 12
              : useCompactLayout
              ? 16
              : 18,
          22,
          veryCompactByHeight
              ? 12
              : useCompactLayout
              ? 16
              : 18,
        );
        final buttonVerticalPadding = veryCompactByHeight
            ? 10.0
            : useCompactLayout
            ? 12.0
            : 14.0;

        return Container(
          decoration: BoxDecoration(
            color: kColorWhite,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: kAiColorSurfaceBorder.withValues(alpha: 0.7),
            ),
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
                height: imageHeight,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.network(
                      data.photoUrl,
                      fit: BoxFit.cover,
                      loadingBuilder:
                          (
                            BuildContext context,
                            Widget child,
                            ImageChunkEvent? loadingProgress,
                          ) {
                            if (loadingProgress == null) {
                              return child;
                            }

                            return ColoredBox(
                              color: const Color(0xFFF4F2FF),
                              child: Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      kAiColorPrimary.withValues(alpha: 0.65),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                      errorBuilder:
                          (
                            BuildContext context,
                            Object error,
                            StackTrace? stackTrace,
                          ) {
                            return Image.asset(
                              data.imageAssetPath,
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
                                  letterSpacing: 0.4,
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
                                  maxLines: veryCompactByHeight ? 1 : 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: titleFontSize,
                                    fontWeight: FontWeight.w800,
                                    color: kAiColorTextDark,
                                    height: 1.05,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '$specialty  •  ${data.distanceMiles.toStringAsFixed(1)} $distanceUnit',
                                  maxLines: useCompactLayout ? 1 : 2,
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
                              border: Border.all(
                                color: const Color(0xFFFDE68A),
                              ),
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
                            height: metricDividerHeight,
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
                                    color: kAiColorPrimary.withValues(
                                      alpha: 0.25,
                                    ),
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
                                        fontSize: 16,
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
                                      fontSize: 16,
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
      },
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
              child: Image.network(
                data.photoUrl,
                fit: BoxFit.cover,
                loadingBuilder:
                    (
                      BuildContext context,
                      Widget child,
                      ImageChunkEvent? loadingProgress,
                    ) {
                      if (loadingProgress == null) {
                        return child;
                      }

                      return const ColoredBox(color: Color(0xFFF4F2FF));
                    },
                errorBuilder:
                    (
                      BuildContext context,
                      Object error,
                      StackTrace? stackTrace,
                    ) {
                      return Image.asset(
                        data.imageAssetPath,
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
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: _kAiMutedText,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 4),
        value,
      ],
    );
  }
}

class _MatchResultsSliderDots extends StatelessWidget {
  const _MatchResultsSliderDots({
    required this.activeIndex,
    required this.itemCount,
  });

  final int activeIndex;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    if (itemCount <= 1) {
      return const SizedBox.shrink();
    }

    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: kColorWhite.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: kAiColorInputBorderLight.withValues(alpha: 0.85),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: kAiColorPrimary.withValues(alpha: 0.12),
              blurRadius: 24,
              spreadRadius: -10,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List<Widget>.generate(itemCount, (int index) {
              final selected = index == activeIndex;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                width: selected ? 18 : 8,
                height: 8,
                margin: EdgeInsetsDirectional.only(
                  end: index == itemCount - 1 ? 0 : 6,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? kAiColorPrimary
                      : kAiColorInputBorderLight.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(999),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _MatchResultsBottomNav extends StatelessWidget {
  const _MatchResultsBottomNav({
    required this.bottomInset,
    required this.isArabic,
    required this.onHomeTap,
  });

  final double bottomInset;
  final bool isArabic;
  final VoidCallback onHomeTap;

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
            onTap: onHomeTap,
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
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? kAiColorPrimary : _kAiMutedText;
    final content = Column(
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
            fontWeight: FontWeight.w800,
            color: color,
            letterSpacing: 0.4,
          ),
        ),
      ],
    );

    if (onTap == null) {
      return content;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
          child: content,
        ),
      ),
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
