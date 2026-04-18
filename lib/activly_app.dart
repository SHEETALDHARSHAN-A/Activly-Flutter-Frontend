import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' show ImageFilter;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:activly/l10n/app_localizations.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

part 'app/core/types/app_types.dart';
part 'app/core/models/translation_copy.dart';
part 'app/core/constants/app_constants.dart';
part 'app/features/shell/activly_shell.dart';
part 'app/features/landing/landing_screen.dart';
part 'app/features/auth/auth_screen.dart';
part 'app/features/ai_match/ai_match_onboarding_screen.dart';
part 'app/features/match_results/match_results_screen.dart';
part 'app/shared/widgets/video_widgets.dart';
part 'app/shared/widgets/loading_overlay.dart';
part 'app/shared/widgets/language_toggle.dart';
part 'app/shared/widgets/landing_buttons.dart';
part 'app/shared/widgets/auth_buttons.dart';
part 'app/shared/painters/google_g_arcs_painter.dart';
part 'app/features/main/main_screen.dart';
part 'app/features/main/featured_all_screen.dart';
part 'app/features/main/tabs/home_tab.dart';
part 'app/features/main/tabs/search_tab.dart';
part 'app/features/main/tabs/explore_tab.dart';
part 'app/features/main/tabs/ai_tab.dart';
part 'app/features/main/tabs/profile_tab.dart';

void runActivlyApp() {
  runApp(const ActivlyApp());
}

class ActivlyApp extends StatefulWidget {
  const ActivlyApp({super.key, this.enableVideos = true});

  final bool enableVideos;

  @override
  State<ActivlyApp> createState() => _ActivlyAppState();
}

class _ActivlyAppState extends State<ActivlyApp> {
  static const String _localePreferenceKey = 'app.locale';

  late Locale _locale;

  Locale? _supportedLocaleForLanguageCode(String? languageCode) {
    if (languageCode == null) {
      return null;
    }

    for (final locale in AppLocalizations.supportedLocales) {
      if (locale.languageCode == languageCode) {
        return locale;
      }
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    _locale =
        _supportedLocaleForLanguageCode(
          WidgetsBinding.instance.platformDispatcher.locale.languageCode,
        ) ??
        const Locale('en');

    unawaited(_restoreLocalePreference());
  }

  Future<void> _restoreLocalePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedLanguageCode = prefs.getString(_localePreferenceKey);
      final storedLocale = _supportedLocaleForLanguageCode(storedLanguageCode);

      if (storedLocale == null || !mounted) {
        return;
      }

      if (storedLocale.languageCode != _locale.languageCode) {
        setState(() {
          _locale = storedLocale;
        });
      }
    } catch (_) {
      // Keep the in-memory locale when preference restore fails.
    }
  }

  Future<void> _setLocale(Locale locale) async {
    final nextLocale =
        _supportedLocaleForLanguageCode(locale.languageCode) ??
        const Locale('en');

    if (nextLocale.languageCode == _locale.languageCode) {
      return;
    }

    setState(() {
      _locale = nextLocale;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localePreferenceKey, nextLocale.languageCode);
    } catch (_) {
      // Keep runtime locale even if persistence fails.
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseText = GoogleFonts.poppinsTextTheme();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Activly',
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kColorBlack,
        colorScheme: const ColorScheme.dark(
          primary: kColorPrimary,
          surface: kColorSurfaceDark,
        ),
        textTheme: baseText.apply(
          bodyColor: kColorWhite,
          displayColor: kColorWhite,
        ),
      ),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        scrollbars: false,
      ),
      home: ActivlyShell(
        enableVideos: widget.enableVideos,
        appLocale: _locale,
        onLocaleChanged: _setLocale,
      ),
    );
  }
}
