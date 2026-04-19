part of 'package:activly/activly_app.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedFilterIndex = 0;

  final List<String> _filters = [
    'All',
    'Fitness',
    'Mindfulness',
    'Nutrition',
    'Recipes',
  ];

  String _tr(String fallback, String Function(AppLocalizations l10n) selector) {
    final l10n = AppLocalizations.of(context);
    return l10n == null ? fallback : selector(l10n);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = _tr('Search', (l10n) => l10n.searchTitle);
    final hint = _tr(
      'Workouts, recipes, articles...',
      (l10n) => l10n.searchHint,
    );
    final recentSearchesTitle = _tr(
      'RECENT SEARCHES',
      (l10n) => l10n.searchRecentSearches,
    );
    final filters = [
      _tr(_filters[0], (l10n) => l10n.searchFilterAll),
      _tr(_filters[1], (l10n) => l10n.searchFilterFitness),
      _tr(_filters[2], (l10n) => l10n.searchFilterMindfulness),
      _tr(_filters[3], (l10n) => l10n.searchFilterNutrition),
      _tr(_filters[4], (l10n) => l10n.searchFilterRecipes),
    ];
    final recentSearches = [
      _tr('Core Workout', (l10n) => l10n.searchRecentCoreWorkout),
      _tr('Yoga for Beginners', (l10n) => l10n.searchRecentYogaBeginners),
      _tr('Healthy Recipes', (l10n) => l10n.searchRecentHealthyRecipes),
      _tr('Meditation', (l10n) => l10n.searchRecentMeditation),
    ];

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
      children: <Widget>[
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: kAiColorTextDark,
          ),
        ),
        const SizedBox(height: 18),
        Container(
          decoration: BoxDecoration(
            color: kAiColorInputFillLight,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: kAiColorInputBorderLight),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: kAiColorPrimary.withValues(alpha: 0.10),
                blurRadius: 20,
                spreadRadius: -10,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: TextField(
            controller: _searchController,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: kAiColorTextDark,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.plusJakartaSans(
                color: kAiColorHint,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: kAiColorTextMutedDark,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 42,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            itemBuilder: (BuildContext context, int index) {
              final isSelected = _selectedFilterIndex == index;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(999),
                    onTap: () {
                      setState(() => _selectedFilterIndex = index);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOut,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? const LinearGradient(
                                colors: <Color>[
                                  kColorPrimary,
                                  kColorPrimaryAccent,
                                ],
                              )
                            : null,
                        color: isSelected ? null : kColorWhite,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : kAiColorInputBorderLight,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if (index == 0) ...<Widget>[
                            Icon(
                              Icons.filter_list_rounded,
                              size: 14,
                              color: isSelected
                                  ? kColorWhite
                                  : kAiColorTextMutedDark,
                            ),
                            const SizedBox(width: 6),
                          ],
                          Text(
                            filters[index],
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: isSelected
                                  ? kColorWhite
                                  : kAiColorTextDark,
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
        const SizedBox(height: 24),
        Text(
          recentSearchesTitle,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: kAiColorTextMutedDark,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 12),
        ...recentSearches.map((String item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  _searchController.text = item;
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: kColorWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: kAiColorSurfaceBorder),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: kAiColorSurfaceContainerLight,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Icon(
                          Icons.access_time_rounded,
                          size: 16,
                          color: kAiColorTextMutedDark,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: kAiColorTextDark,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.north_west_rounded,
                        size: 16,
                        color: kAiColorTextMutedDark,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
