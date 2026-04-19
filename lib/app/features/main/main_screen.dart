part of 'package:activly/activly_app.dart';

const double _kMainBodyBottomClearance = 0;

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    required this.language,
    required this.onToggleLanguage,
    required this.onSeeAllFeatured,
    required this.onOpenMatchResults,
    this.initialTabIndex = 0,
  });

  final AppLanguage language;
  final VoidCallback onToggleLanguage;
  final VoidCallback onSeeAllFeatured;
  final VoidCallback onOpenMatchResults;
  final int initialTabIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  int _normalizeTabIndex(int index) {
    if (index < 0 || index > 4) {
      return 0;
    }

    return index;
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = _normalizeTabIndex(widget.initialTabIndex);
  }

  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialTabIndex == widget.initialTabIndex) {
      return;
    }

    final nextIndex = _normalizeTabIndex(widget.initialTabIndex);
    if (nextIndex != _currentIndex) {
      setState(() => _currentIndex = nextIndex);
    }
  }

  String _tr(String fallback, String Function(AppLocalizations l10n) selector) {
    final l10n = AppLocalizations.of(context);
    return l10n == null ? fallback : selector(l10n);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final localTheme = Theme.of(context).copyWith(
      brightness: Brightness.light,
      textTheme: GoogleFonts.plusJakartaSansTextTheme(
        Theme.of(context).textTheme,
      ).apply(bodyColor: kAiColorTextDark, displayColor: kAiColorTextDark),
    );

    final navItems = <_MainNavEntry>[
      _MainNavEntry(
        index: 0,
        icon: Icons.home_rounded,
        label: _tr('Home', (l10n) => l10n.mainNavHome),
      ),
      _MainNavEntry(
        index: 1,
        icon: Icons.search_rounded,
        label: _tr('Search', (l10n) => l10n.mainNavSearch),
      ),
      _MainNavEntry(
        index: 2,
        icon: Icons.auto_awesome_rounded,
        label: _tr('AI', (l10n) => l10n.mainNavAi),
      ),
      _MainNavEntry(
        index: 3,
        icon: Icons.explore_rounded,
        label: _tr('Explore', (l10n) => l10n.mainNavExplore),
      ),
      _MainNavEntry(
        index: 4,
        icon: Icons.person_rounded,
        label: _tr('Profile', (l10n) => l10n.mainNavProfile),
      ),
    ];

    return Theme(
      data: localTheme,
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
                        const Spacer(),
                        Transform.scale(
                          scale: 0.90,
                          alignment: Alignment.center,
                          child: LanguageToggle(
                            language: widget.language,
                            onToggle: widget.onToggleLanguage,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: _kMainBodyBottomClearance + bottomInset,
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 280),
                        switchInCurve: Curves.easeOutCubic,
                        switchOutCurve: Curves.easeInCubic,
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, 0.04),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                        child: KeyedSubtree(
                          key: ValueKey<int>(_currentIndex),
                          child: _buildBody(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _MainBottomNavigationBar(
                bottomInset: bottomInset,
                currentIndex: _currentIndex,
                items: navItems,
                onSelected: (int index) {
                  if (index == 3) {
                    widget.onOpenMatchResults();
                    return;
                  }

                  if (_currentIndex != index) {
                    setState(() => _currentIndex = index);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return HomeTab(onSeeAll: widget.onSeeAllFeatured);
      case 1:
        return const SearchTab();
      case 2:
        return const AiTab();
      case 3:
        return const SizedBox.shrink();
      case 4:
        return const ProfileTab();
      default:
        return const SizedBox();
    }
  }
}

class _MainNavEntry {
  const _MainNavEntry({
    required this.index,
    required this.icon,
    required this.label,
  });

  final int index;
  final IconData icon;
  final String label;
}

class _MainBottomNavigationBar extends StatelessWidget {
  const _MainBottomNavigationBar({
    required this.bottomInset,
    required this.currentIndex,
    required this.items,
    required this.onSelected,
  });

  final double bottomInset;
  final int currentIndex;
  final List<_MainNavEntry> items;
  final ValueChanged<int> onSelected;

  static const double _kDockHeight = 86;
  static const double _kCenterHomeButtonSize = 64;
  static const double _kExtraTopSpace = 26;

  @override
  Widget build(BuildContext context) {
    final dockHeight = _kDockHeight + bottomInset;
    final entriesByIndex = <int, _MainNavEntry>{
      for (final entry in items) entry.index: entry,
    };
    final homeEntry = entriesByIndex[0] ?? items.first;
    final sideEntries = <_MainNavEntry>[];

    for (final sideIndex in <int>[2, 1, 3, 4]) {
      final entry = entriesByIndex[sideIndex];
      if (entry != null) {
        sideEntries.add(entry);
      }
    }

    for (final entry in items) {
      if (entry.index == homeEntry.index || sideEntries.contains(entry)) {
        continue;
      }
      sideEntries.add(entry);
    }

    Widget sideSlot(int slotIndex) {
      if (slotIndex >= sideEntries.length) {
        return const SizedBox(width: 44, height: 44);
      }

      final entry = sideEntries[slotIndex];
      return _MainBottomNavItem(
        icon: entry.icon,
        label: entry.label,
        selected: currentIndex == entry.index,
        onTap: () => onSelected(entry.index),
      );
    }

    return SizedBox(
      height: dockHeight + _kExtraTopSpace,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: dockHeight,
              padding: EdgeInsets.fromLTRB(18, 14, 18, 10 + bottomInset),
              decoration: BoxDecoration(
                color: kColorWhite,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                border: Border(
                  top: BorderSide(
                    color: kAiColorSurfaceBorder.withValues(alpha: 0.95),
                  ),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: kAiColorPrimary.withValues(alpha: 0.10),
                    blurRadius: 20,
                    spreadRadius: -10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  sideSlot(0),
                  sideSlot(1),
                  const SizedBox(width: _kCenterHomeButtonSize + 20),
                  sideSlot(2),
                  sideSlot(3),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 24 + bottomInset,
            child: Center(
              child: _MainBottomNavItem(
                icon: homeEntry.icon,
                label: homeEntry.label,
                selected: true,
                onTap: () => onSelected(homeEntry.index),
                isCenterHome: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MainBottomNavItem extends StatelessWidget {
  const _MainBottomNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.isCenterHome = false,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool isCenterHome;

  @override
  Widget build(BuildContext context) {
    final iconColor = isCenterHome
        ? kColorWhite
        : selected
        ? kAiColorPrimary
        : kAiColorTextMutedDark;
    final buttonSize = isCenterHome
        ? _MainBottomNavigationBar._kCenterHomeButtonSize
        : 42.0;
    final iconSize = isCenterHome ? 29.0 : 22.0;

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isCenterHome
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[kColorPrimaryAccent, kColorPrimary],
                  )
                : null,
            color: isCenterHome
                ? null
                : selected
                ? kColorWhite
                : kColorWhite.withValues(alpha: 0.88),
            border: Border.all(
              color: isCenterHome
                  ? Colors.transparent
                  : selected
                  ? kAiColorPrimary.withValues(alpha: 0.42)
                  : kAiColorSurfaceBorder.withValues(alpha: 0.86),
              width: isCenterHome ? 0 : (selected ? 1.4 : 1),
            ),
            boxShadow: <BoxShadow>[
              if (isCenterHome)
                BoxShadow(
                  color: kColorBlack.withValues(alpha: 0.14),
                  blurRadius: 10,
                  spreadRadius: -6,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Center(
            child: Icon(icon, color: iconColor, size: iconSize),
          ),
        ),
      ),
    );
  }
}
