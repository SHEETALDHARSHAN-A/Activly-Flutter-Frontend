# Activly Design System

This document is the project-wide design system and implementation reference for Activly.
It consolidates product context, visual foundations, interaction patterns, component contracts, and feature-level behavior from the current Flutter codebase.

## 1. Scope And Goals

### Scope
- Entire Flutter client in this repository.
- App structure, visual system, reusable components, feature screens, state patterns, assets, i18n, and quality baseline.

### Goals
- Keep design and code aligned through one source of truth.
- Make UI decisions repeatable across features.
- Define how to extend the product without visual drift.

## 2. Product Context

Activly is a family activity discovery and booking app with AI-assisted onboarding and recommendation experiences.

Primary references:
- Product requirements: [PRD.md](PRD.md)
- App setup and workflow notes: [README.md](README.md)
- Graph-based architecture audit: [graphify-out/GRAPH_REPORT.md](graphify-out/GRAPH_REPORT.md)

## 3. Project Architecture

### Entry And Composition Model
- Entrypoint: [lib/main.dart](lib/main.dart)
- Root app shell and all imports/parts: [lib/activly_app.dart](lib/activly_app.dart)

The app uses a monolithic part-based composition pattern:
- `lib/activly_app.dart` imports dependencies once and includes all feature files via `part`.

### Navigation Model
- Global page switching is state-driven in `ActivlyShell`.
- Page enum: `AppPage { entry, landing, aiMatch, login, main, featuredAll }` in [lib/app/core/types/app_types.dart](lib/app/core/types/app_types.dart).
- No router package is used.

### Feature Modules
- Shell: [lib/app/features/shell/activly_shell.dart](lib/app/features/shell/activly_shell.dart)
- Landing: [lib/app/features/landing/landing_screen.dart](lib/app/features/landing/landing_screen.dart)
- Auth: [lib/app/features/auth/auth_screen.dart](lib/app/features/auth/auth_screen.dart)
- AI Match onboarding: [lib/app/features/ai_match/ai_match_onboarding_screen.dart](lib/app/features/ai_match/ai_match_onboarding_screen.dart)
- Main app shell: [lib/app/features/main/main_screen.dart](lib/app/features/main/main_screen.dart)
- Main tabs:
  - [lib/app/features/main/tabs/home_tab.dart](lib/app/features/main/tabs/home_tab.dart)
  - [lib/app/features/main/tabs/search_tab.dart](lib/app/features/main/tabs/search_tab.dart)
  - [lib/app/features/main/tabs/ai_tab.dart](lib/app/features/main/tabs/ai_tab.dart)
  - [lib/app/features/main/tabs/explore_tab.dart](lib/app/features/main/tabs/explore_tab.dart)
  - [lib/app/features/main/tabs/profile_tab.dart](lib/app/features/main/tabs/profile_tab.dart)

### Shared Layer
- Constants/tokens: [lib/app/core/constants/app_constants.dart](lib/app/core/constants/app_constants.dart)
- Translation model: [lib/app/core/models/translation_copy.dart](lib/app/core/models/translation_copy.dart)
- Shared widgets:
  - [lib/app/shared/widgets/language_toggle.dart](lib/app/shared/widgets/language_toggle.dart)
  - [lib/app/shared/widgets/loading_overlay.dart](lib/app/shared/widgets/loading_overlay.dart)
  - [lib/app/shared/widgets/video_widgets.dart](lib/app/shared/widgets/video_widgets.dart)
  - [lib/app/shared/widgets/landing_buttons.dart](lib/app/shared/widgets/landing_buttons.dart)
  - [lib/app/shared/widgets/auth_buttons.dart](lib/app/shared/widgets/auth_buttons.dart)
- Custom painter:
  - [lib/app/shared/painters/google_g_arcs_painter.dart](lib/app/shared/painters/google_g_arcs_painter.dart)

## 4. Design Foundations

### 4.1 Color System

Primary tokens (global dark theme):
- `kColorBlack` `#000000`
- `kColorWhite` `#FFFFFF`
- `kColorPrimary` `#7C4CFF`
- `kColorPrimaryAccent` `#8B5CF6`
- `kColorPrimarySoft` `#9F7BFF`
- `kColorSurfaceDark` `#0D0D0D`
- `kColorPanelDark` `#0B0B0D`

Support tokens:
- Loader and feedback colors:
  - `kColorLoaderHeart` `#FC0065`
  - `kColorLoaderShadowBase` `#D7D7D7`
  - `kColorLoaderShadowPulse` `#E4E4E4`
- Video fallback:
  - `kColorVideoFallbackStart` `#2A2A2A`
  - `kColorVideoFallbackEnd` `#101010`
- Google brand arcs/icons:
  - `kColorGoogleRed`, `kColorGoogleYellow`, `kColorGoogleGreen`, `kColorGoogleBlue`

AI Match light-surface palette:
- `kAiColorPageBackground` `#F8F9FF`
- `kAiColorSurface` `#FFFFFF`
- `kAiColorSurfaceBorder` `#E8E8E8`
- `kAiColorTextDark` `#161616`
- `kAiColorTextMutedDark` `#677285`
- `kAiColorSurfaceContainerLight` `#F0F2F8`
- `kAiColorInputFillLight` `#FCFDFF`
- `kAiColorInputBorderLight` `#DCE1EA`

All tokens are defined in [lib/app/core/constants/app_constants.dart](lib/app/core/constants/app_constants.dart).

### 4.2 Typography

Current implementation:
- App-level text theme uses `GoogleFonts.poppinsTextTheme()` in [lib/activly_app.dart](lib/activly_app.dart).
- Feature widgets use inline `TextStyle` and `GoogleFonts.plusJakartaSans` in AI Match.
- Custom font family registered: `LTBeverage` from `assets/fonts/LT_Beverage.otf`.

Design rule:
- Prefer semantic text roles in new code (`headline`, `title`, `body`, `caption`) and avoid creating new ad hoc font stacks.

### 4.3 Spacing

Global constants:
- `kFixedTopSpace = 51`
- `kTopControlsVerticalOffset = 8`
- `kTopControlsSidePadding = 16`
- `kTopControlHeight = 36`
- `kTopControlWidth = 82`

Working scale in current UI:
- Micro: 4, 6, 8
- Base: 10, 12, 14, 16
- Section: 20, 24, 28, 32
- Large: 40+

### 4.4 Shape And Radius

Observed radius primitives:
- Chips and pills: `999`
- Buttons and compact cards: `12-20`
- Large cards/containers: `20-32`

### 4.5 Motion

Global timings:
- `kButtonLoadingDuration = 550ms`
- `kButtonFillDuration = 320ms`
- `kButtonLoaderRevealDelay = 380ms`

Interaction transitions are typically in `180-400ms`, with `Curves.easeOut`, `easeOutCubic`, and `easeOutBack`.

## 5. Layout System

### Shell Layout
- Split layout breakpoint is `1100px` in `ActivlyShell`.
- Below breakpoint: full-screen stacked layouts.
- At/above breakpoint: video panel + content panel split.

### Main Screen Layout
- Bottom navigation in blurred glass container.
- Language toggle pinned top-right.
- Body switches with `AnimatedSwitcher` fade/slide transitions.

### AI Match Layout
- Three-step details flow + chat mode.
- Light surface system over ambient background orbs.
- Sticky top controls, progress bar, cards, chip controls, and map preview.

## 6. Localization And Directionality

### Supported Languages
- English (`AppLanguage.en`)
- Arabic (`AppLanguage.ar`)

### i18n Model
- String container model: `TranslationCopy`
- Translation dictionary: `kTranslations`
- Manual language toggle via `LanguageToggle`

### RTL
- Screen-level `Directionality` wrappers switch between LTR and RTL.
- Use `AlignmentDirectional` and directional paddings where required.

## 7. Components Catalog

### 7.1 Global Components
- `LanguageToggle`: compact EN/AR pill switch.
- `LoadingOverlay`: branded heart loader with staged image/loader reveal.
- `_VideoLayer` and `_VideoFallback`: robust media rendering and graceful fallback.

### 7.2 CTA And Interactive Buttons
- `_SocialButton`: OAuth-style sweep-fill button.
- `_PillButton`: small glass pill action button.
- `_ActionButton`: main CTA with hover/active icon shift.
- `_AsyncSegmentButton`: segmented option with async loading state.
- `_LoadingTextButton`, `_LoadingOutlinedButtonIcon`, `_LoadingLinkText`: loading-aware affordances.

### 7.3 Auth Form Controls
- Multi-step form fields with visibility toggles.
- OTP row with auto-focus, paste handling, and resend timer.
- Shared auth controls in [lib/app/shared/widgets/auth_buttons.dart](lib/app/shared/widgets/auth_buttons.dart).

### 7.4 AI Match Components

Core containers and controls include:
- `_AiGlassPanel`, `_AiTopBar`, `_AiModeToggle`, `_AiThreeStepProgressBar`
- `_AiCompactInputField`, `_AiGenderChip`, `_AiSkillLevelButton`, `_AiFocusAreaChip`
- `_AiInterestHorizontalList`, `_AiInterestVerticalCard`
- `_AiKidLiveProfileCard`
- `_AiRealtimeMapPreview`

Design behavior highlights:
- Input, chip, and card visuals use the AI token set.
- Live profile card reacts to form choices and selected interests.
- Skill level controls now use moon-phase iconography (quarter/half/full style mapping).

## 8. Screen And Flow Specifications

### 8.1 Entry To Landing
- Entry state presents loader while media initializes.
- Landing includes hero logo, tagline, social buttons, email/phone entry options, and skip action.

### 8.2 Authentication
- Steps: sign-in, create account, forgot password, OTP verification, reset password.
- Uses local state machine with `AuthStep` and `OtpPurpose` enums.

### 8.3 AI Match Onboarding

Step 1 (kid basics):
- Age input, gender, curiosity interests, live profile card.

Step 2 (goals and intensity):
- Skill level selector, specific interest free text, focus areas and goals.
- Medical issues field appears below Focus Areas and Goals.

Step 3 (planning constraints):
- Preferred days/time, budget range, location and radius, map preview, matches CTA.

Chat mode:
- Conversational alternatives with coach and user bubbles.

### 8.4 Main App Tabs
- Home: greeting, challenge hero, featured carousel, recommendations.
- Search: keyword input, filter chips, recent search list.
- AI: simple assistant chat with suggestion chips and composer.
- Explore: categories and discover cards.
- Profile: avatar, stats, account actions.

## 9. State, Persistence, And Data Contracts

### State Management
- Current approach is StatefulWidget + `setState`.
- Shell-level state controls navigation and language.
- Feature-level local state for forms and interactions.

### Local Persistence
- AI Match uses `SharedPreferences`.
- Keys include:
  - `ai_match.kid_name`
  - `ai_match.kid_age`
  - `ai_match.kid_gender`
  - `ai_match.kid_interest`

## 10. Assets And Media System

Registered assets in [pubspec.yaml](pubspec.yaml):
- `assets/videos/`
- `assets/`
- `assets/images/ai_match/`

Registered fonts:
- Family `LTBeverage` -> `assets/fonts/LT_Beverage.otf`

Notable media:
- Landing videos from `kVideoAssets`.
- OAuth imagery: `assets/google.svg`, `assets/Apple_light.svg`.
- AI Match images in `assets/images/ai_match/`.

## 11. Accessibility Baseline

Current state:
- Basic contrast and hit-target sizing are generally acceptable.
- Semantics coverage is limited and should be expanded.

Required direction:
- Add semantic labels for custom controls and image-only affordances.
- Ensure focus order and keyboard traversal are predictable.
- Keep RTL parity for alignments, paddings, and directional icons.

## 12. Quality And Testing

Lint and analysis:
- [analysis_options.yaml](analysis_options.yaml) includes `flutter_lints`.

Current tests:
- [test/widget_test.dart](test/widget_test.dart)
- [test/app/features/shell/activly_shell_smoke_test.dart](test/app/features/shell/activly_shell_smoke_test.dart)
- [test/app/features/landing/landing_screen_smoke_test.dart](test/app/features/landing/landing_screen_smoke_test.dart)
- [test/app/features/auth/auth_screen_smoke_test.dart](test/app/features/auth/auth_screen_smoke_test.dart)

Current coverage profile:
- Smoke-level rendering tests exist.
- No deep integration coverage for all flows yet.

## 13. Implementation Rules

1. Add new visual tokens only in [lib/app/core/constants/app_constants.dart](lib/app/core/constants/app_constants.dart).
2. Do not hardcode new brand colors in feature files when a semantic token exists.
3. Reuse shared widgets before creating new variants.
4. Keep animation timings within the existing motion envelope unless there is a specific UX reason.
5. Preserve EN/AR parity for all new user-facing text.
6. Prefer stable, semantic naming for new components and constants.
7. Update this document whenever component contracts or visual tokens change.

## 14. Known Gaps And Improvement Backlog

1. Consolidate typography into semantic text styles to reduce inline duplication.
2. Normalize spacing and radius scales across all feature screens.
3. Expand accessibility semantics for custom components.
4. Introduce stronger component-level tests for critical flows (auth, AI Match steps).
5. Consider extracting app state to a dedicated state architecture as feature complexity grows.

## 15. Change Log

- 2026-04-18: Replaced prior OpenCode-inspired draft with a complete project-wide Activly design system aligned to current implementation.
