part of 'package:activly/activly_app.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key, required this.onSeeAll});

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
    final goodMorning = _tr(
      context,
      'Good Morning,',
      (l10n) => l10n.homeGoodMorning,
    );
    final dailyChallenge = _tr(
      context,
      'DAILY CHALLENGE',
      (l10n) => l10n.homeDailyChallenge,
    );
    final challengeTitle = _tr(
      context,
      'Full Body Power',
      (l10n) => l10n.homeChallengeTitle,
    );
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

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
      children: <Widget>[
        _buildWelcomeHeader(goodMorning: goodMorning),
        const SizedBox(height: 18),
        _buildChallengeCard(
          dailyChallenge: dailyChallenge,
          challengeTitle: challengeTitle,
          challengeSubtitle: challengeSubtitle,
          startNow: startNow,
        ),
        const SizedBox(height: 22),
        _buildSectionHeader(
          title: featured,
          trailingLabel: seeAll,
          onTrailingTap: onSeeAll,
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 246,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              _buildFeaturedCard(
                title: featuredCardOneTitle,
                category: featuredCardOneCategory,
                duration: featuredCardOneDuration,
                imageUrl:
                    'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=400',
              ),
              const SizedBox(width: 14),
              _buildFeaturedCard(
                title: featuredCardTwoTitle,
                category: featuredCardTwoCategory,
                duration: featuredCardTwoDuration,
                imageUrl:
                    'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?auto=format&fit=crop&q=80&w=400',
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Text(
          recommendedForYou,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: kAiColorTextDark,
          ),
        ),
        const SizedBox(height: 12),
        _buildRecommendationTile(
          title: featuredCardOneTitle,
          subtitle: challengeSubtitle,
          icon: Icons.play_circle_fill_rounded,
          imageUrl:
              'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=400',
        ),
        const SizedBox(height: 10),
        _buildRecommendationTile(
          title: featuredCardTwoTitle,
          subtitle: featuredCardTwoDuration,
          icon: Icons.auto_awesome_rounded,
          imageUrl:
              'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?auto=format&fit=crop&q=80&w=400',
        ),
      ],
    );
  }

  Widget _buildWelcomeHeader({required String goodMorning}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: kColorWhite.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: kAiColorSurfaceBorder),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kAiColorPrimary.withValues(alpha: 0.12),
            blurRadius: 24,
            spreadRadius: -10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  goodMorning,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: kAiColorTextMutedDark,
                  ),
                ),
                const SizedBox(height: 3),
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: <Color>[kColorPrimary, kColorPrimaryAccent],
                    ).createShader(bounds);
                  },
                  child: Text(
                    'Alex',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 27,
                      fontWeight: FontWeight.w800,
                      color: kColorWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: <Color>[kColorPrimary, kColorPrimaryAccent],
              ),
            ),
            child: const CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1527980965255-d3b416303d12?auto=format&fit=crop&q=80&w=100',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeCard({
    required String dailyChallenge,
    required String challengeTitle,
    required String challengeSubtitle,
    required String startNow,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: kAiColorSurfaceBorder),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kAiColorPrimary.withValues(alpha: 0.14),
            blurRadius: 34,
            spreadRadius: -12,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 156,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.network(
                  'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=600',
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 14,
                  left: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: kColorBlack.withValues(alpha: 0.40),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      dailyChallenge,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: kColorWhite,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  challengeTitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: kAiColorTextDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  challengeSubtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: kAiColorTextMutedDark,
                  ),
                ),
                const SizedBox(height: 14),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: <Color>[kColorPrimary, kColorPrimaryAccent],
                    ),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(22),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Icon(
                              Icons.play_arrow_rounded,
                              color: kColorWhite,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              startNow,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: kColorWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required String trailingLabel,
    required VoidCallback onTrailingTap,
  }) {
    return Row(
      children: <Widget>[
        const Icon(Icons.auto_graph_rounded, color: kAiColorPrimary, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: kAiColorTextDark,
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onTrailingTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    trailingLabel,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: kAiColorTextMutedDark,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: kAiColorTextMutedDark,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedCard({
    required String title,
    required String category,
    required String duration,
    required String imageUrl,
  }) {
    return Container(
      width: 206,
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: kAiColorSurfaceBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 144,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.network(imageUrl, fit: BoxFit.cover),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: kColorBlack.withValues(alpha: 0.48),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(
                          Icons.timer_outlined,
                          color: kColorWhite,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          duration,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: kColorWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  category,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                    color: kAiColorTextMutedDark,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: kAiColorTextDark,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kAiColorSurfaceBorder),
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              imageUrl,
              width: 74,
              height: 74,
              fit: BoxFit.cover,
            ),
          ),
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
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: kAiColorTextDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: kAiColorTextMutedDark,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: kAiColorPrimary.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: kAiColorPrimary, size: 18),
          ),
        ],
      ),
    );
  }
}
