import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

part 'app/core/types/app_types.dart';
part 'app/core/models/translation_copy.dart';
part 'app/core/constants/app_constants.dart';
part 'app/features/shell/activly_shell.dart';
part 'app/features/landing/landing_screen.dart';
part 'app/features/auth/auth_screen.dart';
part 'app/shared/widgets/video_widgets.dart';
part 'app/shared/widgets/loading_overlay.dart';
part 'app/shared/widgets/language_toggle.dart';
part 'app/shared/widgets/landing_buttons.dart';
part 'app/shared/widgets/auth_buttons.dart';
part 'app/shared/painters/google_g_arcs_painter.dart';

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
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF7C4CFF),
          surface: Color(0xFF0D0D0D),
        ),
        textTheme: baseText.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        scrollbars: false,
      ),
      home: ActivlyShell(enableVideos: enableVideos),
    );
  }
}
