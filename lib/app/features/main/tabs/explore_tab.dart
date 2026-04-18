part of 'package:activly/activly_app.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

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
    final title = _tr(context, 'Explore', (l10n) => l10n.exploreTitle);
    final trending = _tr(context, 'Trending', (l10n) => l10n.exploreTrending);
    final nutrition = _tr(context, 'Nutrition', (l10n) => l10n.exploreNutrition);
    final mindfulness = _tr(context, 'Mindfulness', (l10n) => l10n.exploreMindfulness);
    final cardio = _tr(context, 'Cardio', (l10n) => l10n.exploreCardio);
    final discover = _tr(context, 'Discover', (l10n) => l10n.exploreDiscover);
    final articleTag = _tr(context, 'ARTICLE', (l10n) => l10n.exploreArticleTag);
    final videoTag = _tr(context, 'VIDEO', (l10n) => l10n.exploreVideoTag);
    final articleOneTitle = _tr(
      context,
      'The Science of Muscle Hypertrophy',
      (l10n) => l10n.exploreArticleOneTitle,
    );
    final articleOneSubtitle = _tr(
      context,
      'By Dr. Sarah Jenkins',
      (l10n) => l10n.exploreArticleOneSubtitle,
    );
    final articleTwoTitle = _tr(
      context,
      'Quick Home Workout with your dog',
      (l10n) => l10n.exploreArticleTwoTitle,
    );
    final articleTwoSubtitle = _tr(
      context,
      '10 Min routine',
      (l10n) => l10n.exploreArticleTwoSubtitle,
    );

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.8,
            children: [
              _buildCategoryCard(trending, Icons.local_fire_department_outlined, const Color(0xFFA0523C)),
              _buildCategoryCard(nutrition, Icons.eco_outlined, const Color(0xFF2E6B4B)),
              _buildCategoryCard(mindfulness, Icons.explore_outlined, const Color(0xFF454C8F)),
              _buildCategoryCard(cardio, Icons.monitor_heart_outlined, const Color(0xFF7A2B4E)),
            ],
          ),
          const SizedBox(height: 40),
          Text(
            discover,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildArticleCard(
            tag: articleTag,
            title: articleOneTitle,
            subtitle: articleOneSubtitle,
            imageUrl: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=600',
          ),
          const SizedBox(height: 16),
          _buildArticleCard(
            tag: videoTag,
            title: articleTwoTitle,
            subtitle: articleTwoSubtitle,
            imageUrl: 'https://images.unsplash.com/photo-1548199973-03cce0bbc87b?auto=format&fit=crop&q=80&w=600',
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color color) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: Colors.white, size: 24),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticleCard({
    required String tag,
    required String title,
    required String subtitle,
    required String imageUrl,
  }) {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
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
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
