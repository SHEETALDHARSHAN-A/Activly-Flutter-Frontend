part of 'package:activly/activly_app.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    required this.language,
    required this.t,
    required this.onToggleLanguage,
    required this.onSeeAllFeatured,
  });

  final AppLanguage language;
  final TranslationCopy t;
  final VoidCallback onToggleLanguage;
  final VoidCallback onSeeAllFeatured;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBlack,
      extendBody: true,
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.05),
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
          Positioned(
            top: 48,
            right: 16,
            child: LanguageToggle(
              language: widget.language,
              onToggle: widget.onToggleLanguage,
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: _buildBottomNavigationBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return HomeTab(t: widget.t, onSeeAll: widget.onSeeAllFeatured);
      case 1:
        return const SearchTab();
      case 2:
        return AiTab(t: widget.t);
      case 3:
        return ExploreTab(t: widget.t);
      case 4:
        return ProfileTab(t: widget.t);
      default:
        return const SizedBox();
    }
  }

  Widget _buildBottomNavigationBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A).withValues(alpha: 0.65),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(1, Icons.search_outlined, 'Search'),
              _buildNavItem(3, Icons.explore_outlined, 'Explore'),
              _buildNavItem(0, Icons.home_outlined, 'Home', isGlow: true),
              _buildNavItem(2, Icons.auto_awesome, 'AI'),
              _buildNavItem(4, Icons.person_outline, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, {bool isGlow = false}) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? Colors.white : Colors.white54;

    return GestureDetector(
      onTap: () {
        if (_currentIndex != index) {
          setState(() => _currentIndex = index);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 150),
        scale: isSelected ? 1.05 : 1.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isGlow)
              Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: kColorPrimary.withValues(alpha: 0.6),
                                blurRadius: 16,
                                spreadRadius: 4,
                              ),
                            ]
                          : [],
                    ),
                  ),
                  Icon(icon, color: color, size: 26),
                ],
              )
            else
              Icon(icon, color: color, size: 26),
            const SizedBox(height: 4),
            if (isSelected)
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            if (isSelected && !isGlow)
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 16,
                height: 2,
                decoration: BoxDecoration(
                  color: kColorPrimary,
                  borderRadius: BorderRadius.circular(1),
                  boxShadow: [
                    BoxShadow(color: kColorPrimary.withValues(alpha: 0.5), blurRadius: 4),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

}
