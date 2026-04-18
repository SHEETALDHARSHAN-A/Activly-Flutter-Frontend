import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' show ImageFilter;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class ActivlyApp extends StatelessWidget {
  const ActivlyApp({super.key, this.enableVideos = true});

  final bool enableVideos;

  @override
  Widget build(BuildContext context) {
    final baseText = GoogleFonts.poppinsTextTheme();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Activly',
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
      home: ActivlyShell(enableVideos: enableVideos),
    );
  }
}
