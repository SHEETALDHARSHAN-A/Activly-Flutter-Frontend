import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Activly'**
  String get appName;

  /// No description provided for @taglineLine1.
  ///
  /// In en, this message translates to:
  /// **'The most playful way for kids'**
  String get taglineLine1;

  /// No description provided for @taglineLine2.
  ///
  /// In en, this message translates to:
  /// **'to discover activities and make new friends.'**
  String get taglineLine2;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithApple;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @emailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Email or Phone'**
  String get emailOrPhone;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to keep discovering activities and friends.'**
  String get loginSubtitle;

  /// No description provided for @signInCta.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInCta;

  /// No description provided for @createAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccountTitle;

  /// No description provided for @createAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set up your account to start exploring activities.'**
  String get createAccountSubtitle;

  /// No description provided for @createAccountCta.
  ///
  /// In en, this message translates to:
  /// **'Create New Account'**
  String get createAccountCta;

  /// No description provided for @createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create New Account'**
  String get createNewAccount;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @createOne.
  ///
  /// In en, this message translates to:
  /// **'Create one'**
  String get createOne;

  /// No description provided for @byContinuing.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our'**
  String get byContinuing;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get terms;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Recover Password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email or phone to receive a verification code.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send Verification Code'**
  String get sendCode;

  /// No description provided for @otpTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get otpTitle;

  /// No description provided for @otpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code sent to'**
  String get otpSubtitle;

  /// No description provided for @verifyCode.
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verifyCode;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// No description provided for @changeContact.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get changeContact;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Create New Password'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your new password must be different from the previous one.'**
  String get resetPasswordSubtitle;

  /// No description provided for @saveNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Save New Password'**
  String get saveNewPassword;

  /// No description provided for @accountCreatedNotice.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully. Please sign in.'**
  String get accountCreatedNotice;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password updated. You can now sign in.'**
  String get passwordResetSuccess;

  /// No description provided for @authPasswordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get authPasswordsDoNotMatch;

  /// No description provided for @authMissingSignupFields.
  ///
  /// In en, this message translates to:
  /// **'Please enter both email and phone.'**
  String get authMissingSignupFields;

  /// No description provided for @authMissingIdentifier.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email or phone.'**
  String get authMissingIdentifier;

  /// No description provided for @authMissingSignInFields.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email/phone and password.'**
  String get authMissingSignInFields;

  /// No description provided for @authExpiredOtp.
  ///
  /// In en, this message translates to:
  /// **'Expired OTP'**
  String get authExpiredOtp;

  /// No description provided for @authOrContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get authOrContinueWith;

  /// No description provided for @authTermsAndPrivacyAgreement.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our Terms and Privacy Policy.'**
  String get authTermsAndPrivacyAgreement;

  /// No description provided for @authFullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Your full name'**
  String get authFullNameHint;

  /// Shown when a social sign-in provider is tapped before integration is available.
  ///
  /// In en, this message translates to:
  /// **'{provider} sign in will be available soon.'**
  String authSocialSignInComingSoon(String provider);

  /// No description provided for @backToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Back to Sign In'**
  String get backToSignIn;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @skipForNow.
  ///
  /// In en, this message translates to:
  /// **'Skip for Now'**
  String get skipForNow;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @mainNavHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get mainNavHome;

  /// No description provided for @mainNavSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get mainNavSearch;

  /// No description provided for @mainNavExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get mainNavExplore;

  /// No description provided for @mainNavAi.
  ///
  /// In en, this message translates to:
  /// **'AI'**
  String get mainNavAi;

  /// No description provided for @mainNavProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get mainNavProfile;

  /// No description provided for @homeGoodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning,'**
  String get homeGoodMorning;

  /// No description provided for @homeDailyChallenge.
  ///
  /// In en, this message translates to:
  /// **'DAILY CHALLENGE'**
  String get homeDailyChallenge;

  /// No description provided for @homeChallengeTitle.
  ///
  /// In en, this message translates to:
  /// **'Full Body Power'**
  String get homeChallengeTitle;

  /// No description provided for @homeChallengeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join 2,450 others in today\'s challenge'**
  String get homeChallengeSubtitle;

  /// No description provided for @homeStartNow.
  ///
  /// In en, this message translates to:
  /// **'Start Now'**
  String get homeStartNow;

  /// No description provided for @homeFeatured.
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get homeFeatured;

  /// No description provided for @homeSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get homeSeeAll;

  /// No description provided for @homeRecommendedForYou.
  ///
  /// In en, this message translates to:
  /// **'Recommended for you'**
  String get homeRecommendedForYou;

  /// No description provided for @homeFeaturedCardOneTitle.
  ///
  /// In en, this message translates to:
  /// **'Morning Yoga Flow'**
  String get homeFeaturedCardOneTitle;

  /// No description provided for @homeFeaturedCardOneCategory.
  ///
  /// In en, this message translates to:
  /// **'WELLNESS'**
  String get homeFeaturedCardOneCategory;

  /// No description provided for @homeFeaturedCardOneDuration.
  ///
  /// In en, this message translates to:
  /// **'15 min'**
  String get homeFeaturedCardOneDuration;

  /// No description provided for @homeFeaturedCardTwoTitle.
  ///
  /// In en, this message translates to:
  /// **'HIIT Core Crusher'**
  String get homeFeaturedCardTwoTitle;

  /// No description provided for @homeFeaturedCardTwoCategory.
  ///
  /// In en, this message translates to:
  /// **'FITNESS'**
  String get homeFeaturedCardTwoCategory;

  /// No description provided for @homeFeaturedCardTwoDuration.
  ///
  /// In en, this message translates to:
  /// **'30 min'**
  String get homeFeaturedCardTwoDuration;

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Workouts, recipes, articles...'**
  String get searchHint;

  /// No description provided for @searchRecentSearches.
  ///
  /// In en, this message translates to:
  /// **'RECENT SEARCHES'**
  String get searchRecentSearches;

  /// No description provided for @searchFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get searchFilterAll;

  /// No description provided for @searchFilterFitness.
  ///
  /// In en, this message translates to:
  /// **'Fitness'**
  String get searchFilterFitness;

  /// No description provided for @searchFilterMindfulness.
  ///
  /// In en, this message translates to:
  /// **'Mindfulness'**
  String get searchFilterMindfulness;

  /// No description provided for @searchFilterNutrition.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get searchFilterNutrition;

  /// No description provided for @searchFilterRecipes.
  ///
  /// In en, this message translates to:
  /// **'Recipes'**
  String get searchFilterRecipes;

  /// No description provided for @searchRecentCoreWorkout.
  ///
  /// In en, this message translates to:
  /// **'Core Workout'**
  String get searchRecentCoreWorkout;

  /// No description provided for @searchRecentYogaBeginners.
  ///
  /// In en, this message translates to:
  /// **'Yoga for Beginners'**
  String get searchRecentYogaBeginners;

  /// No description provided for @searchRecentHealthyRecipes.
  ///
  /// In en, this message translates to:
  /// **'Healthy Recipes'**
  String get searchRecentHealthyRecipes;

  /// No description provided for @searchRecentMeditation.
  ///
  /// In en, this message translates to:
  /// **'Meditation'**
  String get searchRecentMeditation;

  /// No description provided for @exploreTitle.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get exploreTitle;

  /// No description provided for @exploreTrending.
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get exploreTrending;

  /// No description provided for @exploreNutrition.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get exploreNutrition;

  /// No description provided for @exploreMindfulness.
  ///
  /// In en, this message translates to:
  /// **'Mindfulness'**
  String get exploreMindfulness;

  /// No description provided for @exploreCardio.
  ///
  /// In en, this message translates to:
  /// **'Cardio'**
  String get exploreCardio;

  /// No description provided for @exploreDiscover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get exploreDiscover;

  /// No description provided for @exploreArticleTag.
  ///
  /// In en, this message translates to:
  /// **'ARTICLE'**
  String get exploreArticleTag;

  /// No description provided for @exploreVideoTag.
  ///
  /// In en, this message translates to:
  /// **'VIDEO'**
  String get exploreVideoTag;

  /// No description provided for @exploreArticleOneTitle.
  ///
  /// In en, this message translates to:
  /// **'The Science of Muscle Hypertrophy'**
  String get exploreArticleOneTitle;

  /// No description provided for @exploreArticleOneSubtitle.
  ///
  /// In en, this message translates to:
  /// **'By Dr. Sarah Jenkins'**
  String get exploreArticleOneSubtitle;

  /// No description provided for @exploreArticleTwoTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Home Workout with your dog'**
  String get exploreArticleTwoTitle;

  /// No description provided for @exploreArticleTwoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'10 Min routine'**
  String get exploreArticleTwoSubtitle;

  /// No description provided for @aiTitle.
  ///
  /// In en, this message translates to:
  /// **'Activly AI'**
  String get aiTitle;

  /// No description provided for @aiInitialMessage.
  ///
  /// In en, this message translates to:
  /// **'Hi Alex! I\'m your personal AI fitness coach. How can I help you reach your goals today?'**
  String get aiInitialMessage;

  /// No description provided for @aiSuggestionCoreWorkout.
  ///
  /// In en, this message translates to:
  /// **'Create a 15-min core workout'**
  String get aiSuggestionCoreWorkout;

  /// No description provided for @aiSuggestionPostTraining.
  ///
  /// In en, this message translates to:
  /// **'What should I eat after training?'**
  String get aiSuggestionPostTraining;

  /// No description provided for @aiSuggestionSleep.
  ///
  /// In en, this message translates to:
  /// **'How to improve my sleep?'**
  String get aiSuggestionSleep;

  /// No description provided for @aiAskAnything.
  ///
  /// In en, this message translates to:
  /// **'Ask anything...'**
  String get aiAskAnything;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Workouts'**
  String get profileWorkouts;

  /// No description provided for @profileMinutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get profileMinutes;

  /// No description provided for @profileStreaks.
  ///
  /// In en, this message translates to:
  /// **'Streaks'**
  String get profileStreaks;

  /// No description provided for @profileAccount.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get profileAccount;

  /// No description provided for @profileYourActivity.
  ///
  /// In en, this message translates to:
  /// **'Your Activity'**
  String get profileYourActivity;

  /// No description provided for @profileSavedItems.
  ///
  /// In en, this message translates to:
  /// **'Saved Items'**
  String get profileSavedItems;

  /// No description provided for @profileLogOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get profileLogOut;

  /// No description provided for @matchResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Match Results'**
  String get matchResultsTitle;

  /// No description provided for @matchResultsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get matchResultsFilterAll;

  /// No description provided for @matchResultsFilterAcademy.
  ///
  /// In en, this message translates to:
  /// **'Academy'**
  String get matchResultsFilterAcademy;

  /// No description provided for @matchResultsFilterCoaches.
  ///
  /// In en, this message translates to:
  /// **'Coaches'**
  String get matchResultsFilterCoaches;

  /// No description provided for @matchResultsCoachMarcus.
  ///
  /// In en, this message translates to:
  /// **'Coach Marcus'**
  String get matchResultsCoachMarcus;

  /// No description provided for @matchResultsCoachElena.
  ///
  /// In en, this message translates to:
  /// **'Coach Elena'**
  String get matchResultsCoachElena;

  /// No description provided for @matchResultsCoachSamir.
  ///
  /// In en, this message translates to:
  /// **'Coach Samir'**
  String get matchResultsCoachSamir;

  /// No description provided for @matchResultsSpecialtySoccer.
  ///
  /// In en, this message translates to:
  /// **'Soccer Specialist'**
  String get matchResultsSpecialtySoccer;

  /// No description provided for @matchResultsSpecialtyCreativeDance.
  ///
  /// In en, this message translates to:
  /// **'Creative Dance Coach'**
  String get matchResultsSpecialtyCreativeDance;

  /// No description provided for @matchResultsSpecialtyStem.
  ///
  /// In en, this message translates to:
  /// **'STEM Activity Mentor'**
  String get matchResultsSpecialtyStem;

  /// No description provided for @matchResultsDistanceUnitMiles.
  ///
  /// In en, this message translates to:
  /// **'mi'**
  String get matchResultsDistanceUnitMiles;

  /// No description provided for @matchResultsBadgeMatch.
  ///
  /// In en, this message translates to:
  /// **'MATCH'**
  String get matchResultsBadgeMatch;

  /// No description provided for @matchResultsBadgeMatchCompact.
  ///
  /// In en, this message translates to:
  /// **'Match'**
  String get matchResultsBadgeMatchCompact;

  /// No description provided for @matchResultsRateLabel.
  ///
  /// In en, this message translates to:
  /// **'RATE'**
  String get matchResultsRateLabel;

  /// No description provided for @matchResultsPerHour.
  ///
  /// In en, this message translates to:
  /// **'/hr'**
  String get matchResultsPerHour;

  /// No description provided for @matchResultsExperienceLabel.
  ///
  /// In en, this message translates to:
  /// **'EXPERIENCE'**
  String get matchResultsExperienceLabel;

  /// No description provided for @matchResultsYears.
  ///
  /// In en, this message translates to:
  /// **'Years'**
  String get matchResultsYears;

  /// No description provided for @matchResultsExperienceCompact.
  ///
  /// In en, this message translates to:
  /// **'y exp'**
  String get matchResultsExperienceCompact;

  /// No description provided for @matchResultsBookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get matchResultsBookNow;

  /// No description provided for @matchResultsSeeProfile.
  ///
  /// In en, this message translates to:
  /// **'See Profile'**
  String get matchResultsSeeProfile;

  /// No description provided for @matchResultsBook.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get matchResultsBook;

  /// No description provided for @matchResultsProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get matchResultsProfile;

  /// No description provided for @matchResultsSwipeForMore.
  ///
  /// In en, this message translates to:
  /// **'SWIPE FOR MORE'**
  String get matchResultsSwipeForMore;

  /// No description provided for @matchResultsNavHome.
  ///
  /// In en, this message translates to:
  /// **'HOME'**
  String get matchResultsNavHome;

  /// No description provided for @matchResultsNavSearch.
  ///
  /// In en, this message translates to:
  /// **'SEARCH'**
  String get matchResultsNavSearch;

  /// No description provided for @matchResultsNavMatch.
  ///
  /// In en, this message translates to:
  /// **'MATCH'**
  String get matchResultsNavMatch;

  /// No description provided for @matchResultsNavProfile.
  ///
  /// In en, this message translates to:
  /// **'PROFILE'**
  String get matchResultsNavProfile;

  /// No description provided for @en.
  ///
  /// In en, this message translates to:
  /// **'EN'**
  String get en;

  /// No description provided for @ar.
  ///
  /// In en, this message translates to:
  /// **'عربي'**
  String get ar;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
