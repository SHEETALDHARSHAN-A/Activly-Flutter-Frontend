part of 'package:activly/activly_app.dart';

class AiTab extends StatefulWidget {
  const AiTab({super.key});

  @override
  State<AiTab> createState() => _AiTabState();
}

class _AiTabState extends State<AiTab> {
  final TextEditingController _promptController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<String> _messages = [
    "Hi Alex! I'm your personal AI fitness coach. How can I help you reach your goals today?",
  ];

  final List<String> _suggestions = [
    'Create a 15-min core workout',
    'What should I eat after training?',
    'How to improve my sleep?',
  ];

  String _tr(String fallback, String Function(AppLocalizations l10n) selector) {
    final l10n = AppLocalizations.of(context);
    return l10n == null ? fallback : selector(l10n);
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) {
      return;
    }

    setState(() {
      _messages.add(text);
      _promptController.clear();
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      if (!_scrollController.hasClients) {
        return;
      }

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _promptController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aiTitle = _tr('Activly AI', (l10n) => l10n.aiTitle);
    final initialMessage = _tr(
      _messages.first,
      (l10n) => l10n.aiInitialMessage,
    );
    final askAnything = _tr('Ask anything...', (l10n) => l10n.aiAskAnything);
    final suggestions = [
      _tr(_suggestions[0], (l10n) => l10n.aiSuggestionCoreWorkout),
      _tr(_suggestions[1], (l10n) => l10n.aiSuggestionPostTraining),
      _tr(_suggestions[2], (l10n) => l10n.aiSuggestionSleep),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
          child: Row(
            children: <Widget>[
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kAiColorPrimary.withValues(alpha: 0.14),
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: kAiColorPrimary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                aiTitle,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: kAiColorTextDark,
                ),
              ),
            ],
          ),
        ),
        if (_messages.length == 1)
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: suggestions
                    .map((String suggestion) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(999),
                            onTap: () {
                              _promptController.text = suggestion;
                              _sendMessage(suggestion);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 9,
                              ),
                              decoration: BoxDecoration(
                                color: kColorWhite,
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: kAiColorInputBorderLight,
                                ),
                              ),
                              child: Text(
                                suggestion,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: kAiColorTextDark,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                    .toList(growable: false),
              ),
            ),
          ),
        Expanded(
          child: ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            physics: const BouncingScrollPhysics(),
            itemCount: _messages.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 12);
            },
            itemBuilder: (BuildContext context, int index) {
              final isBot = index == 0;
              final text = isBot ? initialMessage : _messages[index];
              return _buildMessageBubble(text, isBot);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: kColorWhite.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: kAiColorInputBorderLight),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: kAiColorPrimary.withValues(alpha: 0.10),
                  blurRadius: 18,
                  spreadRadius: -9,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _promptController,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: kAiColorTextDark,
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: _sendMessage,
                    decoration: InputDecoration(
                      hintText: askAnything,
                      hintStyle: GoogleFonts.plusJakartaSans(
                        color: kAiColorHint,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                DecoratedBox(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: <Color>[kColorPrimary, kColorPrimaryAccent],
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: () => _sendMessage(_promptController.text),
                      child: const Padding(
                        padding: EdgeInsets.all(9),
                        child: Icon(
                          Icons.send_rounded,
                          color: kColorWhite,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(String text, bool isBot) {
    if (isBot) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kAiColorPrimary.withValues(alpha: 0.16),
            ),
            child: const Icon(
              Icons.smart_toy_outlined,
              color: kAiColorPrimary,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: kColorWhite,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                border: Border.all(color: kAiColorSurfaceBorder),
              ),
              child: Text(
                text,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: kAiColorTextDark,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 54),
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[kColorPrimary, kColorPrimaryAccent],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(4),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: kColorWhite,
                height: 1.4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
