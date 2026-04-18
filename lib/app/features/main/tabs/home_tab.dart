part of 'package:activly/activly_app.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({
    super.key,
    required this.onSeeAll,
  });

  final VoidCallback onSeeAll;

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
    final goodMorning = _tr(context, 'Good Morning,', (l10n) => l10n.homeGoodMorning);
    final dailyChallenge = _tr(context, 'DAILY CHALLENGE', (l10n) => l10n.homeDailyChallenge);
    final challengeTitle = _tr(context, 'Full Body Power', (l10n) => l10n.homeChallengeTitle);
    final challengeSubtitle = _tr(
      context,
      "Join 2,450 others in today's challenge",
      (l10n) => l10n.homeChallengeSubtitle,
    );
    final startNow = _tr(context, 'Start Now', (l10n) => l10n.homeStartNow);
    final featured = _tr(context, 'Featured', (l10n) => l10n.homeFeatured);
    final seeAll = _tr(context, 'See All', (l10n) => l10n.homeSeeAll);
    final recommendedForYou = _tr(
      context,
      'Recommended for you',
      (l10n) => l10n.homeRecommendedForYou,
    );
    final featuredCardOneTitle = _tr(
      context,
      'Morning Yoga Flow',
      (l10n) => l10n.homeFeaturedCardOneTitle,
    );
    final featuredCardOneCategory = _tr(
      context,
      'WELLNESS',
      (l10n) => l10n.homeFeaturedCardOneCategory,
    );
    final featuredCardOneDuration = _tr(
      context,
      '15 min',
      (l10n) => l10n.homeFeaturedCardOneDuration,
    );
    final featuredCardTwoTitle = _tr(
      context,
      'HIIT Core Crusher',
      (l10n) => l10n.homeFeaturedCardTwoTitle,
    );
    final featuredCardTwoCategory = _tr(
      context,
      'FITNESS',
      (l10n) => l10n.homeFeaturedCardTwoCategory,
    );
    final featuredCardTwoDuration = _tr(
      context,
      '30 min',
      (l10n) => l10n.homeFeaturedCardTwoDuration,
    );

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goodMorning,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFFE2B0FF), Color(0xFF9F44D3)],
                      ).createShader(bounds),
                      child: const Text(
                        'Alex',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1527980965255-d3b416303d12?auto=format&fit=crop&q=80&w=100'),
              )
            ],
          ),
          const SizedBox(height: 32),
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: const DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=600'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    dailyChallenge,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                  ),
                ),
                const Spacer(),
                Text(
                  challengeTitle,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  challengeSubtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.play_arrow, color: Colors.black, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            startNow,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.trending_up, color: Colors.white54, size: 20),
                  SizedBox(width: 8),
                  Text(
                    featured,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onSeeAll,
                child: Row(
                  children: [
                    Text(
                      seeAll,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward, color: Colors.white54, size: 14),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 240,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFeaturedCard(
                  title: featuredCardOneTitle,
                  category: featuredCardOneCategory,
                  duration: featuredCardOneDuration,
                  imageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=400',
                ),
                const SizedBox(width: 16),
                _buildFeaturedCard(
                  title: featuredCardTwoTitle,
                  category: featuredCardTwoCategory,
                  duration: featuredCardTwoDuration,
                  imageUrl: 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?auto=format&fit=crop&q=80&w=400',
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text(
            recommendedForYou,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard({
    required String title,
    required String category,
    required String duration,
    required String imageUrl,
  }) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(Colors.black26, BlendMode.darken),
                  ),
                ),
                alignment: Alignment.topRight,
                padding: const EdgeInsets.all(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.timer_outlined, color: Colors.white, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        duration,
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Colors.white54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
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
