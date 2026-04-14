part of 'package:activly/activly_app.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({
    super.key,
    required this.language,
    required this.onToggle,
  });

  final AppLanguage language;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final t = kTranslations[language]!;
    final selectedTextColor = Colors.black;
    final unselectedTextColor = Colors.white;

    return GestureDetector(
      onTap: onToggle,
      child: Container(
        width: 82,
        height: 36,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.50),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Stack(
          children: <Widget>[
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              alignment: language == AppLanguage.en
                  ? AlignmentDirectional.centerStart
                  : AlignmentDirectional.centerEnd,
              child: Container(
                width: 36,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      t.en,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: language == AppLanguage.en
                            ? selectedTextColor
                            : unselectedTextColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      t.ar,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: language == AppLanguage.ar
                            ? selectedTextColor
                            : unselectedTextColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
