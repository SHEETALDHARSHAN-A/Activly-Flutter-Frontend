# Graph Report - D:\Uday-workspace\Activly-Flutter-Frontend  (2026-04-20)

## Corpus Check
- 61 files · ~745,559 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 548 nodes · 537 edges · 43 communities detected
- Extraction: 98% EXTRACTED · 2% INFERRED · 0% AMBIGUOUS · INFERRED: 12 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Community 0|Community 0]]
- [[_COMMUNITY_Community 1|Community 1]]
- [[_COMMUNITY_Community 2|Community 2]]
- [[_COMMUNITY_Community 3|Community 3]]
- [[_COMMUNITY_Community 4|Community 4]]
- [[_COMMUNITY_Community 5|Community 5]]
- [[_COMMUNITY_Community 6|Community 6]]
- [[_COMMUNITY_Community 7|Community 7]]
- [[_COMMUNITY_Community 8|Community 8]]
- [[_COMMUNITY_Community 9|Community 9]]
- [[_COMMUNITY_Community 10|Community 10]]
- [[_COMMUNITY_Community 11|Community 11]]
- [[_COMMUNITY_Community 12|Community 12]]
- [[_COMMUNITY_Community 13|Community 13]]
- [[_COMMUNITY_Community 14|Community 14]]
- [[_COMMUNITY_Community 15|Community 15]]
- [[_COMMUNITY_Community 16|Community 16]]
- [[_COMMUNITY_Community 17|Community 17]]
- [[_COMMUNITY_Community 18|Community 18]]
- [[_COMMUNITY_Community 19|Community 19]]
- [[_COMMUNITY_Community 20|Community 20]]
- [[_COMMUNITY_Community 21|Community 21]]
- [[_COMMUNITY_Community 22|Community 22]]
- [[_COMMUNITY_Community 23|Community 23]]
- [[_COMMUNITY_Community 24|Community 24]]
- [[_COMMUNITY_Community 25|Community 25]]
- [[_COMMUNITY_Community 26|Community 26]]
- [[_COMMUNITY_Community 27|Community 27]]
- [[_COMMUNITY_Community 28|Community 28]]
- [[_COMMUNITY_Community 29|Community 29]]
- [[_COMMUNITY_Community 30|Community 30]]
- [[_COMMUNITY_Community 31|Community 31]]
- [[_COMMUNITY_Community 32|Community 32]]
- [[_COMMUNITY_Community 33|Community 33]]
- [[_COMMUNITY_Community 34|Community 34]]
- [[_COMMUNITY_Community 35|Community 35]]
- [[_COMMUNITY_Community 36|Community 36]]
- [[_COMMUNITY_Community 37|Community 37]]
- [[_COMMUNITY_Community 38|Community 38]]
- [[_COMMUNITY_Community 39|Community 39]]
- [[_COMMUNITY_Community 40|Community 40]]
- [[_COMMUNITY_Community 41|Community 41]]
- [[_COMMUNITY_Community 42|Community 42]]

## God Nodes (most connected - your core abstractions)
1. `AppDelegate` - 8 edges
2. `Create()` - 7 edges
3. `Destroy()` - 6 edges
4. `package:activly/activly_app.dart` - 5 edges
5. `OnCreate()` - 5 edges
6. `wWinMain()` - 5 edges
7. `MessageHandler()` - 5 edges
8. `GeneratedPluginRegistrant` - 4 edges
9. `RunnerTests` - 4 edges
10. `package:flutter/widgets.dart` - 4 edges

## Surprising Connections (you probably didn't know these)
- `RegisterPlugins()` --calls--> `OnCreate()`  [INFERRED]
  D:\Uday-workspace\Activly-Flutter-Frontend\windows\flutter\generated_plugin_registrant.cc → D:\Uday-workspace\Activly-Flutter-Frontend\windows\runner\flutter_window.cpp
- `OnCreate()` --calls--> `Show()`  [INFERRED]
  D:\Uday-workspace\Activly-Flutter-Frontend\windows\runner\flutter_window.cpp → D:\Uday-workspace\Activly-Flutter-Frontend\windows\runner\win32_window.cpp
- `wWinMain()` --calls--> `CreateAndAttachConsole()`  [INFERRED]
  D:\Uday-workspace\Activly-Flutter-Frontend\windows\runner\main.cpp → D:\Uday-workspace\Activly-Flutter-Frontend\windows\runner\utils.cpp
- `wWinMain()` --calls--> `SetQuitOnClose()`  [INFERRED]
  D:\Uday-workspace\Activly-Flutter-Frontend\windows\runner\main.cpp → D:\Uday-workspace\Activly-Flutter-Frontend\windows\runner\win32_window.cpp
- `dispose` --calls--> `my_application_dispose()`  [INFERRED]
  D:\Uday-workspace\Activly-Flutter-Frontend\lib\app\shared\widgets\loading_overlay.dart → D:\Uday-workspace\Activly-Flutter-Frontend\linux\runner\my_application.cc

## Communities

### Community 0 - "Community 0"
Cohesion: 0.02
Nodes (102): _AiAmbientBackground, _AiAvatarBadgeCircles, _AiAvatarCirclesStrip, _aiBackdropOrbPrimary, _aiBackdropOrbWarm, _AiBackgroundOrb, _aiBottomNavBackground, _aiBottomNavBorder (+94 more)

### Community 1 - "Community 1"
Cohesion: 0.04
Nodes (48): AnimatedBuilder, AnimatedContainer, build, _buildActionButton, _buildFilterRow, _buildListResultsContent, _buildSliderResultsContent, Center (+40 more)

### Community 2 - "Community 2"
Cohesion: 0.06
Nodes (35): app_localizations_ar.dart, app_localizations_en.dart, ActivlyApp, _ActivlyAppState, build, initState, Locale, MaterialApp (+27 more)

### Community 3 - "Community 3"
Cohesion: 0.09
Nodes (25): FlutterWindow(), OnCreate(), RegisterPlugins(), wWinMain(), CreateAndAttachConsole(), GetCommandLineArguments(), Utf8FromUtf16(), Create() (+17 more)

### Community 4 - "Community 4"
Cohesion: 0.06
Nodes (31): ActivlyShell, _ActivlyShellState, AiMatchOnboardingScreen, AnimatedOpacity, _appLanguageFromLocale, AuthScreen, build, didUpdateWidget (+23 more)

### Community 5 - "Community 5"
Cohesion: 0.06
Nodes (22): _BladeSpinner, _BladeSpinnerState, build, _circle, Column, Container, dispose, IgnorePointer (+14 more)

### Community 6 - "Community 6"
Cohesion: 0.07
Nodes (27): _AuthProviderButton, AuthScreen, _AuthScreenState, BorderSide, build, _centerFocusedInput, _clearOtpDigits, Column (+19 more)

### Community 7 - "Community 7"
Cohesion: 0.09
Nodes (21): AiTab, build, _buildBody, didUpdateWidget, FadeTransition, HomeTab, initState, _MainBottomNavigationBar (+13 more)

### Community 8 - "Community 8"
Cohesion: 0.1
Nodes (19): _ActionButton, _AsyncSegmentButton, _AsyncSegmentButtonState, _BladeSpinner, build, GestureDetector, _LoadingLinkText, _LoadingLinkTextState (+11 more)

### Community 9 - "Community 9"
Cohesion: 0.12
Nodes (16): _AnimatedSkipForNow, _AnimatedSkipForNowState, build, Container, Directionality, dispose, _FadeSlide, GestureDetector (+8 more)

### Community 10 - "Community 10"
Cohesion: 0.12
Nodes (15): build, _buildChallengeCard, _buildFeaturedCard, _buildRecommendationTile, _buildSectionHeader, _buildWelcomeHeader, Container, Function (+7 more)

### Community 11 - "Community 11"
Cohesion: 0.13
Nodes (14): app_localizations.dart, aiMatchMilesValue, aiMatchPercentComplete, aiMatchSavedAt, aiMatchStepLabel, AppLocalizationsAr, authSocialSignInComingSoon, aiMatchMilesValue (+6 more)

### Community 12 - "Community 12"
Cohesion: 0.18
Nodes (10): main, main, main, main, main, package:activly/activly_app.dart, package:activly/l10n/app_localizations.dart, package:flutter/material.dart (+2 more)

### Community 13 - "Community 13"
Cohesion: 0.14
Nodes (13): Align, build, Function, _GlassPillButton, _GlassPillButtonState, _GoogleBrandIcon, MouseRegion, _PillButton (+5 more)

### Community 14 - "Community 14"
Cohesion: 0.15
Nodes (12): build, _buildActionTile, _buildStatCard, Container, Function, Icon, ListView, Material (+4 more)

### Community 15 - "Community 15"
Cohesion: 0.17
Nodes (11): AiTab, _AiTabState, build, _buildMessageBubble, Column, dispose, Padding, Row (+3 more)

### Community 16 - "Community 16"
Cohesion: 0.18
Nodes (10): build, _buildGridCard, Container, FeaturedAllScreen, Function, Icon, SizedBox, SliverGridDelegateWithFixedCrossAxisCount (+2 more)

### Community 17 - "Community 17"
Cohesion: 0.2
Nodes (9): build, dispose, Icon, ListView, Padding, SearchTab, _SearchTabState, SizedBox (+1 more)

### Community 18 - "Community 18"
Cohesion: 0.22
Nodes (3): AppDelegate, FlutterAppDelegate, FlutterImplicitEngineDelegate

### Community 19 - "Community 19"
Cohesion: 0.29
Nodes (6): build, DecoratedBox, FittedBox, LayoutBuilder, _VideoFallback, _VideoLayer

### Community 20 - "Community 20"
Cohesion: 0.33
Nodes (3): RegisterGeneratedPlugins(), MainFlutterWindow, NSWindow

### Community 21 - "Community 21"
Cohesion: 0.4
Nodes (2): GeneratedPluginRegistrant, -registerWithRegistry

### Community 22 - "Community 22"
Cohesion: 0.4
Nodes (2): RunnerTests, XCTestCase

### Community 23 - "Community 23"
Cohesion: 0.4
Nodes (4): arc, _GoogleGArcsPainter, paint, shouldRepaint

### Community 24 - "Community 24"
Cohesion: 0.5
Nodes (2): handle_new_rx_page(), Intercept NOTIFY_DEBUGGER_ABOUT_RX_PAGES and touch the pages.

### Community 25 - "Community 25"
Cohesion: 0.5
Nodes (3): build, GestureDetector, LanguageToggle

### Community 26 - "Community 26"
Cohesion: 0.67
Nodes (2): FlutterSceneDelegate, SceneDelegate

### Community 27 - "Community 27"
Cohesion: 1.0
Nodes (1): MainActivity

### Community 28 - "Community 28"
Cohesion: 1.0
Nodes (1): TranslationCopy

### Community 29 - "Community 29"
Cohesion: 1.0
Nodes (0): 

### Community 30 - "Community 30"
Cohesion: 1.0
Nodes (0): 

### Community 31 - "Community 31"
Cohesion: 1.0
Nodes (0): 

### Community 32 - "Community 32"
Cohesion: 1.0
Nodes (0): 

### Community 33 - "Community 33"
Cohesion: 1.0
Nodes (0): 

### Community 34 - "Community 34"
Cohesion: 1.0
Nodes (0): 

### Community 35 - "Community 35"
Cohesion: 1.0
Nodes (0): 

### Community 36 - "Community 36"
Cohesion: 1.0
Nodes (0): 

### Community 37 - "Community 37"
Cohesion: 1.0
Nodes (0): 

### Community 38 - "Community 38"
Cohesion: 1.0
Nodes (0): 

### Community 39 - "Community 39"
Cohesion: 1.0
Nodes (0): 

### Community 40 - "Community 40"
Cohesion: 1.0
Nodes (0): 

### Community 41 - "Community 41"
Cohesion: 1.0
Nodes (0): 

### Community 42 - "Community 42"
Cohesion: 1.0
Nodes (0): 

## Knowledge Gaps
- **416 isolated node(s):** `MainActivity`, `Intercept NOTIFY_DEBUGGER_ABOUT_RX_PAGES and touch the pages.`, `-registerWithRegistry`, `ActivlyApp`, `_ActivlyAppState` (+411 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `Community 27`** (2 nodes): `MainActivity.kt`, `MainActivity`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 28`** (2 nodes): `translation_copy.dart`, `TranslationCopy`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 29`** (1 nodes): `build.gradle.kts`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 30`** (1 nodes): `settings.gradle.kts`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 31`** (1 nodes): `build.gradle.kts`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 32`** (1 nodes): `GeneratedPluginRegistrant.h`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 33`** (1 nodes): `Runner-Bridging-Header.h`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 34`** (1 nodes): `app_constants.dart`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 35`** (1 nodes): `app_types.dart`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 36`** (1 nodes): `generated_plugin_registrant.h`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 37`** (1 nodes): `my_application.h`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 38`** (1 nodes): `flutter_bootstrap.js`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 39`** (1 nodes): `generated_plugin_registrant.h`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 40`** (1 nodes): `resource.h`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 41`** (1 nodes): `utils.h`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 42`** (1 nodes): `win32_window.h`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `package:intl/intl.dart` connect `Community 11` to `Community 2`?**
  _High betweenness centrality (0.005) - this node is a cross-community bridge._
- **Why does `package:flutter/widgets.dart` connect `Community 12` to `Community 2`?**
  _High betweenness centrality (0.003) - this node is a cross-community bridge._
- **Are the 4 inferred relationships involving `OnCreate()` (e.g. with `GetClientArea()` and `RegisterPlugins()`) actually correct?**
  _`OnCreate()` has 4 INFERRED edges - model-reasoned connections that need verification._
- **What connects `MainActivity`, `Intercept NOTIFY_DEBUGGER_ABOUT_RX_PAGES and touch the pages.`, `-registerWithRegistry` to the rest of the system?**
  _416 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 0` be split into smaller, more focused modules?**
  _Cohesion score 0.02 - nodes in this community are weakly interconnected._
- **Should `Community 1` be split into smaller, more focused modules?**
  _Cohesion score 0.04 - nodes in this community are weakly interconnected._
- **Should `Community 2` be split into smaller, more focused modules?**
  _Cohesion score 0.06 - nodes in this community are weakly interconnected._