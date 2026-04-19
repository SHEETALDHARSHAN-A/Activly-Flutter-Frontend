part of 'package:activly/activly_app.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

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
    final title = _tr(context, 'Profile', (l10n) => l10n.profileTitle);
    final workouts = _tr(context, 'Workouts', (l10n) => l10n.profileWorkouts);
    final minutes = _tr(context, 'Minutes', (l10n) => l10n.profileMinutes);
    final streaks = _tr(context, 'Streaks', (l10n) => l10n.profileStreaks);
    final account = _tr(context, 'ACCOUNT', (l10n) => l10n.profileAccount);
    final yourActivity = _tr(
      context,
      'Your Activity',
      (l10n) => l10n.profileYourActivity,
    );
    final savedItems = _tr(
      context,
      'Saved Items',
      (l10n) => l10n.profileSavedItems,
    );
    final logOut = _tr(context, 'Log Out', (l10n) => l10n.profileLogOut);

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: kAiColorTextDark,
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kColorWhite,
                    border: Border.all(color: kAiColorSurfaceBorder),
                  ),
                  child: const Icon(
                    Icons.settings_outlined,
                    color: kAiColorTextMutedDark,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
          decoration: BoxDecoration(
            color: kColorWhite,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: kAiColorSurfaceBorder),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: kAiColorPrimary.withValues(alpha: 0.10),
                blurRadius: 20,
                spreadRadius: -10,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: <Color>[kColorPrimary, kColorPrimaryAccent],
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1527980965255-d3b416303d12?auto=format&fit=crop&q=80&w=200',
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(999),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kColorWhite,
                            border: Border.all(color: kAiColorSurfaceBorder),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: kAiColorTextDark,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                'Alex Chen',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: kAiColorTextDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'alex.chen@example.com',
                style: GoogleFonts.plusJakartaSans(
                  color: kAiColorTextMutedDark,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            Expanded(child: _buildStatCard('24', workouts, false)),
            const SizedBox(width: 10),
            Expanded(child: _buildStatCard('1,250', minutes, true)),
            const SizedBox(width: 10),
            Expanded(child: _buildStatCard('12', streaks, false)),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          account,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: kAiColorTextMutedDark,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 10),
        _buildActionTile(
          icon: Icons.monitor_heart_outlined,
          title: yourActivity,
          iconColor: kAiColorPrimary,
          iconBgColor: const Color(0xFFEDE9FE),
        ),
        const SizedBox(height: 10),
        _buildActionTile(
          icon: Icons.bookmark_border,
          title: savedItems,
          iconColor: const Color(0xFF4F46E5),
          iconBgColor: const Color(0xFFE9EAFE),
        ),
        const SizedBox(height: 10),
        _buildActionTile(
          icon: Icons.logout,
          title: logOut,
          iconColor: const Color(0xFFB42318),
          iconBgColor: const Color(0xFFFEE4E2),
          isDestructive: true,
          showChevron: false,
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, bool isGradient) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kAiColorSurfaceBorder),
      ),
      child: Column(
        children: <Widget>[
          if (isGradient)
            ShaderMask(
              shaderCallback: (Rect bounds) => const LinearGradient(
                colors: <Color>[kColorPrimary, kColorPrimaryAccent],
              ).createShader(bounds),
              child: Text(
                value,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: kColorWhite,
                ),
              ),
            )
          else
            Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: kAiColorPrimary,
              ),
            ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              color: kAiColorTextMutedDark,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required Color iconColor,
    required Color iconBgColor,
    bool isDestructive = false,
    bool showChevron = true,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kColorWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: kAiColorSurfaceBorder),
          ),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isDestructive
                        ? const Color(0xFFB42318)
                        : kAiColorTextDark,
                  ),
                ),
              ),
              if (showChevron)
                const Icon(
                  Icons.chevron_right_rounded,
                  color: kAiColorTextMutedDark,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
