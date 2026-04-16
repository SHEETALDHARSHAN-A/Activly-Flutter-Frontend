part of 'package:activly/activly_app.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key, required this.t});

  final TranslationCopy t;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFF141414),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.settings_outlined, color: Colors.white70, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Center(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                      colors: [Color(0xFFC084FC), Color(0xFFFA709A), Color(0xFFC084FC)],
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage('https://images.unsplash.com/photo-1527980965255-d3b416303d12?auto=format&fit=crop&q=80&w=200'),
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
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit, color: Colors.black, size: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Alex Chen',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Center(
            child: Text(
              'alex.chen@example.com',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(child: _buildStatStat('24', 'Workouts', false)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatStat('1,250', 'Minutes', true)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatStat('12', 'Streaks', false)),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'ACCOUNT',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white54,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          _buildActionTile(
            icon: Icons.monitor_heart_outlined,
            title: 'Your Activity',
            iconColor: const Color(0xFFB5A1D6),
            iconBgColor: const Color(0xFF2A2234),
          ),
          const SizedBox(height: 12),
          _buildActionTile(
            icon: Icons.bookmark_border,
            title: 'Saved Items',
            iconColor: const Color(0xFFC084FC),
            iconBgColor: const Color(0xFF291D38),
          ),
          const SizedBox(height: 12),
          _buildActionTile(
            icon: Icons.logout,
            title: 'Log Out',
            iconColor: const Color(0xFFEA4335),
            iconBgColor: const Color(0xFF2E1A1A),
            isDestructive: true,
            showChevron: false,
          ),
        ],
      ),
    );
  }

  Widget _buildStatStat(String value, String label, bool isGradient) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          if (isGradient)
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFFC084FC), Color(0xFFFA709A)],
              ).createShader(bounds),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          else
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC084FC),
              ),
            ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
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
            color: const Color(0xFF141414),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
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
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDestructive ? const Color(0xFFE2615B) : Colors.white,
                  ),
                ),
              ),
              if (showChevron)
                const Icon(Icons.chevron_right, color: Colors.white38),
            ],
          ),
        ),
      ),
    );
  }
}
