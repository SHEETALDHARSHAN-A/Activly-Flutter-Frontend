part of 'package:activly/activly_app.dart';

class AiMatchOnboardingScreen extends StatefulWidget {
  const AiMatchOnboardingScreen({
    super.key,
    required this.language,
    required this.t,
    required this.onToggleLanguage,
    required this.onSkip,
  });

  final AppLanguage language;
  final TranslationCopy t;
  final VoidCallback onToggleLanguage;
  final VoidCallback onSkip;

  @override
  State<AiMatchOnboardingScreen> createState() =>
      _AiMatchOnboardingScreenState();
}

class _AiMatchOnboardingScreenState extends State<AiMatchOnboardingScreen> {
  bool _chatMode = true;
  int _selectedEnergy = -1;
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _childAgeController = TextEditingController(
    text: '6',
  );
  final TextEditingController _goalsController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    _childAgeController.dispose();
    _goalsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = widget.language == AppLanguage.ar;
    final title = isArabic ? 'مطابقة ذكية' : 'AI Match';
    final subtitle = isArabic
        ? 'اختر نمط الدردشة او املأ التفاصيل للحصول على اقتراحات دقيقة.'
        : 'Chat with Activly Coach or fill details for better activity matches.';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: SafeArea(
        top: false,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        kFixedTopSpace + kTopControlHeight + 32,
                        20,
                        210,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: kColorWhite,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            subtitle,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                              color: kAiColorSubtitle,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _AiModeToggle(
                            isArabic: isArabic,
                            chatSelected: _chatMode,
                            onSelectChat: () => setState(() => _chatMode = true),
                            onSelectDetails: () =>
                                setState(() => _chatMode = false),
                          ),
                          const SizedBox(height: 18),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            switchInCurve: Curves.easeOut,
                            switchOutCurve: Curves.easeIn,
                            child: _chatMode
                                ? _AiChatPanel(
                                    key: const ValueKey<String>('chat-mode'),
                                    isArabic: isArabic,
                                    selectedEnergy: _selectedEnergy,
                                    onSelectEnergy: (int index) {
                                      setState(() => _selectedEnergy = index);
                                    },
                                  )
                                : _AiDetailsPanel(
                                    key: const ValueKey<String>('details-mode'),
                                    isArabic: isArabic,
                                    ageController: _childAgeController,
                                    goalsController: _goalsController,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: kFixedTopSpace + kTopControlsVerticalOffset,
              left: kTopControlsSidePadding,
              right: kTopControlsSidePadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _AiTopSkipButton(
                    label: widget.t.skipForNow,
                    onTap: widget.onSkip,
                  ),
                  LanguageToggle(
                    language: widget.language,
                    onToggle: widget.onToggleLanguage,
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 78,
              child: IgnorePointer(
                child: SizedBox(
                  height: 138,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          kAiColorWaveStart,
                          kAiColorWaveEnd,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 76,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: _AiChatInput(
                      isArabic: isArabic,
                      controller: _messageController,
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _AiBottomNav(),
            ),
          ],
        ),
      ),
    );
  }
}

class _AiTopSkipButton extends StatelessWidget {
  const _AiTopSkipButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kTopControlWidth,
      height: kTopControlHeight,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: kAiColorSkipBorder),
          backgroundColor: kAiColorSkipBackground,
          foregroundColor: kColorWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _AiModeToggle extends StatelessWidget {
  const _AiModeToggle({
    required this.isArabic,
    required this.chatSelected,
    required this.onSelectChat,
    required this.onSelectDetails,
  });

  final bool isArabic;
  final bool chatSelected;
  final VoidCallback onSelectChat;
  final VoidCallback onSelectDetails;

  @override
  Widget build(BuildContext context) {
    final chatLabel = isArabic ? 'الدردشة' : 'Chat';
    final detailsLabel = isArabic ? 'ادخل التفاصيل' : 'Fill Details';

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: kAiColorGlass,
        border: Border.all(color: kAiColorGlassBorderSoft),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _AiModeToggleButton(
              label: chatLabel,
              selected: chatSelected,
              onTap: onSelectChat,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _AiModeToggleButton(
              label: detailsLabel,
              selected: !chatSelected,
              onTap: onSelectDetails,
            ),
          ),
        ],
      ),
    );
  }
}

class _AiModeToggleButton extends StatelessWidget {
  const _AiModeToggleButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? kAiColorSurface
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: selected
              ? const <BoxShadow>[
                  BoxShadow(
                    blurRadius: 20,
                    spreadRadius: -14,
                    offset: Offset(0, 8),
                    color: kAiShadowMedium,
                  ),
                ]
              : const <BoxShadow>[],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: selected ? FontWeight.w800 : FontWeight.w700,
            color: selected
                ? kAiColorPrimary
                : kAiColorMutedText,
          ),
        ),
      ),
    );
  }
}

class _AiChatPanel extends StatelessWidget {
  const _AiChatPanel({
    super.key,
    required this.isArabic,
    required this.selectedEnergy,
    required this.onSelectEnergy,
  });

  final bool isArabic;
  final int selectedEnergy;
  final ValueChanged<int> onSelectEnergy;

  @override
  Widget build(BuildContext context) {
    final optionTexts = isArabic
        ? <String>[
            'طاقة عالية',
            'تركيز وهدوء',
            'مزيج متوازن',
          ]
        : <String>[
            'High Energy',
            'Focused and Quiet',
            'A Mix of Both',
          ];

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
      decoration: BoxDecoration(
        color: kAiColorGlass,
        border: Border.all(color: kAiColorGlassBorder),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: <Widget>[
          _AiCoachBubble(
            text: isArabic
                ? 'اهلا! انا مساعد Activly. كم عمر طفلك الان؟'
                : 'Hi! I am your Activly Coach. How old is your child now?',
          ),
          const SizedBox(height: 12),
          _AiUserBubble(
            text: isArabic
                ? 'عمره 6 سنوات.'
                : 'He just turned 6 last month.',
          ),
          const SizedBox(height: 12),
          _AiCoachBubble(
            text: isArabic
                ? 'ممتاز. هل يميل لنشاط عالي ام تركيز هادئ؟'
                : 'Great. Does he prefer high movement or focused activities?',
          ),
          const SizedBox(height: 14),
          Column(
            children: List<Widget>.generate(optionTexts.length, (int index) {
              return Padding(
                padding: EdgeInsets.only(bottom: index == optionTexts.length - 1 ? 0 : 10),
                child: _AiChoiceButton(
                  label: optionTexts[index],
                  selected: selectedEnergy == index,
                  onTap: () => onSelectEnergy(index),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _AiCoachBubble extends StatelessWidget {
  const _AiCoachBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: <Color>[kAiColorAvatarStart, kAiColorAvatarEnd],
            ),
          ),
          child: const Icon(Icons.auto_awesome, color: kAiColorPrimary, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kAiColorSurface,
              borderRadius: BorderRadius.circular(18).copyWith(
                topLeft: const Radius.circular(6),
              ),
              border: Border.all(color: kAiColorSurfaceBorder),
            ),
            child: Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                color: kAiColorTextDark,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.35,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AiUserBubble extends StatelessWidget {
  const _AiUserBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 290),
        decoration: BoxDecoration(
          color: kAiColorPrimary,
          borderRadius: BorderRadius.circular(18).copyWith(
            topRight: const Radius.circular(6),
          ),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              blurRadius: 26,
              spreadRadius: -20,
              offset: Offset(0, 12),
              color: kAiShadowPurple,
            ),
          ],
        ),
        child: Text(
          text,
          style: GoogleFonts.plusJakartaSans(
            color: kColorWhite,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _AiChoiceButton extends StatelessWidget {
  const _AiChoiceButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? kAiColorSurfaceSelected
                : kAiColorSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected
                  ? kAiColorPrimary
                  : kAiColorSurfaceBorder,
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: kAiColorTextDark,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 18,
                color: selected
                    ? kAiColorPrimary
                    : kAiColorChoiceChevronInactive,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AiDetailsPanel extends StatelessWidget {
  const _AiDetailsPanel({
    super.key,
    required this.isArabic,
    required this.ageController,
    required this.goalsController,
  });

  final bool isArabic;
  final TextEditingController ageController;
  final TextEditingController goalsController;

  @override
  Widget build(BuildContext context) {
    final ageLabel = isArabic ? 'عمر الطفل' : 'Child Age';
    final goalsLabel = isArabic ? 'الهدف الرئيسي' : 'Main Goal';
    final goalsHint = isArabic
        ? 'مثال: نشاط اجتماعي او تركيز'
        : 'Example: social confidence or focus';
    final cta = isArabic ? 'ابحث عن الانشطة' : 'Generate Matches';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kAiColorGlass,
        border: Border.all(color: kAiColorGlassBorder),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _AiField(
            label: ageLabel,
            controller: ageController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          _AiField(
            label: goalsLabel,
            controller: goalsController,
            hintText: goalsHint,
          ),
          const SizedBox(height: 16),
          _ActionButton(
            label: cta,
            icon: Icons.auto_awesome,
            onTap: () async {},
          ),
        ],
      ),
    );
  }
}

class _AiField extends StatelessWidget {
  const _AiField({
    required this.label,
    required this.controller,
    this.hintText,
    this.keyboardType,
  });

  final String label;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.plusJakartaSans(
        color: kColorWhite,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: GoogleFonts.plusJakartaSans(
          color: kAiColorInputLabel,
          fontWeight: FontWeight.w600,
        ),
        hintStyle: GoogleFonts.plusJakartaSans(
          color: kAiColorInputHintLight,
        ),
        filled: true,
        fillColor: kAiColorInputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: kAiColorInputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: kAiColorInputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: kAiColorPrimary),
        ),
      ),
    );
  }
}

class _AiChatInput extends StatelessWidget {
  const _AiChatInput({required this.isArabic, required this.controller});

  final bool isArabic;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: kAiColorSurface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: kAiColorSurfaceBorder),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            blurRadius: 28,
            spreadRadius: -20,
            offset: Offset(0, 14),
            color: kAiShadowInput,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              style: GoogleFonts.plusJakartaSans(
                color: kAiColorTextInput,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: isArabic ? 'اكتب رسالتك...' : 'Type your message...',
                hintStyle: GoogleFonts.plusJakartaSans(
                  color: kAiColorHint,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Material(
              color: kAiColorPrimary,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: () {},
                customBorder: const CircleBorder(),
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(Icons.send_rounded, size: 20, color: kColorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AiBottomNav extends StatelessWidget {
  const _AiBottomNav();

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(12, 10, 12, math.max(12, bottomInset)),
      decoration: BoxDecoration(
        color: kAiColorBottomNavBackground,
        border: Border(
          top: const BorderSide(color: kAiColorBottomNavBorder),
        ),
      ),
      child: const Row(
        children: <Widget>[
          Expanded(
            child: _AiBottomNavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              active: false,
            ),
          ),
          Expanded(
            child: _AiBottomNavItem(
              icon: Icons.search,
              label: 'Search',
              active: false,
            ),
          ),
          Expanded(
            child: _AiBottomNavItem(
              icon: Icons.explore,
              label: 'Explore',
              active: true,
            ),
          ),
          Expanded(
            child: _AiBottomNavItem(
              icon: Icons.person_outline,
              label: 'Profile',
              active: false,
            ),
          ),
        ],
      ),
    );
  }
}

class _AiBottomNavItem extends StatelessWidget {
  const _AiBottomNavItem({
    required this.icon,
    required this.label,
    required this.active,
  });

  final IconData icon;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active
        ? kAiColorPrimarySoft
        : kAiColorBottomNavInactive;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
