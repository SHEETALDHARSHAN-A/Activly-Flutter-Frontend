part of 'package:activly/activly_app.dart';

class FeaturedAllScreen extends StatelessWidget {
  const FeaturedAllScreen({super.key, required this.onBack});

  final VoidCallback onBack;

  String _tr(
    BuildContext context,
    String fallback,
    String Function(AppLocalizations l10n) selector,
  ) {
    final l10n = AppLocalizations.of(context);
    return l10n == null ? fallback : selector(l10n);
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Directionality.of(context) == TextDirection.rtl;
    final screenTitle = _tr(context, 'Featured', (l10n) => l10n.homeFeatured);

    final List<Map<String, String>> featuredItems = [
      {
        'title': 'Morning Yoga Flow',
        'category': 'WELLNESS',
        'duration': '15 min',
        'imageUrl':
            'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=400',
      },
      {
        'title': 'HIIT Core Crusher',
        'category': 'FITNESS',
        'duration': '30 min',
        'imageUrl':
            'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?auto=format&fit=crop&q=80&w=400',
      },
      {
        'title': 'Full Body Power',
        'category': 'STRENGTH',
        'duration': '45 min',
        'imageUrl':
            'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=400',
      },
      {
        'title': 'Mindful Meditation',
        'category': 'WELLNESS',
        'duration': '10 min',
        'imageUrl':
            'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&q=80&w=400',
      },
      {
        'title': 'Advanced Pilates',
        'category': 'FITNESS',
        'duration': '40 min',
        'imageUrl':
            'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&q=80&w=400',
      },
      {
        'title': 'Clean Eating Intro',
        'category': 'NUTRITION',
        'duration': '5 min',
        'imageUrl':
            'https://images.unsplash.com/photo-1490645935967-10de6ba17061?auto=format&fit=crop&q=80&w=400',
      },
    ];

    final localTheme = Theme.of(context).copyWith(
      brightness: Brightness.light,
      textTheme: GoogleFonts.plusJakartaSansTextTheme(
        Theme.of(context).textTheme,
      ).apply(bodyColor: kAiColorTextDark, displayColor: kAiColorTextDark),
    );

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
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(999),
                            onTap: onBack,
                            child: SizedBox(
                              width: 44,
                              height: 44,
                              child: Icon(
                                isArabic
                                    ? Icons.chevron_right_rounded
                                    : Icons.chevron_left_rounded,
                                color: kAiColorTextDark,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            screenTitle,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: kAiColorTextDark,
                            ),
                          ),
                        ),
                        const SizedBox(width: 44, height: 44),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.72,
                          ),
                      itemCount: featuredItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = featuredItems[index];
                        return _buildGridCard(
                          title: item['title']!,
                          category: item['category']!,
                          duration: item['duration']!,
                          imageUrl: item['imageUrl']!,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridCard({
    required String title,
    required String category,
    required String duration,
    required String imageUrl,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: kAiColorSurfaceBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: SizedBox.expand(
                  child: Image.network(imageUrl, fit: BoxFit.cover),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        category,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: kAiColorTextMutedDark,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: kAiColorTextDark,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.timer_outlined,
                            color: kAiColorTextMutedDark,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            duration,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: kAiColorTextMutedDark,
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
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
