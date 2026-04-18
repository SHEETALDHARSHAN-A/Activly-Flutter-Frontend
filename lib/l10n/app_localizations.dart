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

  /// No description provided for @aiMatchTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Match'**
  String get aiMatchTitle;

  /// No description provided for @aiMatchKidDetailsRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Please enter kid name and age before saving.'**
  String get aiMatchKidDetailsRequiredError;

  /// No description provided for @aiMatchKidDetailsSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Kid details saved successfully.'**
  String get aiMatchKidDetailsSavedSuccess;

  /// No description provided for @aiMatchStepLabel.
  ///
  /// In en, this message translates to:
  /// **'Step {step} of 3'**
  String aiMatchStepLabel(int step);

  /// No description provided for @aiMatchPercentComplete.
  ///
  /// In en, this message translates to:
  /// **'{percent}% Complete'**
  String aiMatchPercentComplete(int percent);

  /// No description provided for @aiMatchToggleChat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get aiMatchToggleChat;

  /// No description provided for @aiMatchToggleFillDetails.
  ///
  /// In en, this message translates to:
  /// **'Fill Details'**
  String get aiMatchToggleFillDetails;

  /// No description provided for @aiMatchEnergyHigh.
  ///
  /// In en, this message translates to:
  /// **'High Energy'**
  String get aiMatchEnergyHigh;

  /// No description provided for @aiMatchEnergyFocused.
  ///
  /// In en, this message translates to:
  /// **'Focused and Quiet'**
  String get aiMatchEnergyFocused;

  /// No description provided for @aiMatchEnergyBalanced.
  ///
  /// In en, this message translates to:
  /// **'A Bit of Both'**
  String get aiMatchEnergyBalanced;

  /// No description provided for @aiMatchEnergyAdaptive.
  ///
  /// In en, this message translates to:
  /// **'Adaptive'**
  String get aiMatchEnergyAdaptive;

  /// No description provided for @aiMatchCoachIntroQuestion.
  ///
  /// In en, this message translates to:
  /// **'Hi! I am your Activly Coach. How old is your child now?'**
  String get aiMatchCoachIntroQuestion;

  /// No description provided for @aiMatchUserAgeResponse.
  ///
  /// In en, this message translates to:
  /// **'He just turned 6 last month.'**
  String get aiMatchUserAgeResponse;

  /// No description provided for @aiMatchCoachEnergyQuestion.
  ///
  /// In en, this message translates to:
  /// **'Great. What is the usual energy level?'**
  String get aiMatchCoachEnergyQuestion;

  /// No description provided for @aiMatchCoachReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Activly Coach Is Ready'**
  String get aiMatchCoachReadyTitle;

  /// No description provided for @aiMatchCoachReadySubtitle.
  ///
  /// In en, this message translates to:
  /// **'We will personalize activity picks by age, energy, and goal in seconds.'**
  String get aiMatchCoachReadySubtitle;

  /// No description provided for @aiMatchSignalAgeTuned.
  ///
  /// In en, this message translates to:
  /// **'Age tuned'**
  String get aiMatchSignalAgeTuned;

  /// No description provided for @aiMatchSignalGoalAware.
  ///
  /// In en, this message translates to:
  /// **'Goal aware'**
  String get aiMatchSignalGoalAware;

  /// No description provided for @aiMatchStep1Title.
  ///
  /// In en, this message translates to:
  /// **'Start with kid details.'**
  String get aiMatchStep1Title;

  /// No description provided for @aiMatchStep1Subtitle.
  ///
  /// In en, this message translates to:
  /// **'A small precise profile gives smarter matches in seconds.'**
  String get aiMatchStep1Subtitle;

  /// No description provided for @aiMatchAgeHint.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get aiMatchAgeHint;

  /// No description provided for @aiMatchGenderLabel.
  ///
  /// In en, this message translates to:
  /// **'GENDER'**
  String get aiMatchGenderLabel;

  /// No description provided for @aiMatchInterestsLabel.
  ///
  /// In en, this message translates to:
  /// **'WHAT SPARKS THEIR CURIOSITY?'**
  String get aiMatchInterestsLabel;

  /// No description provided for @aiMatchSaveDetails.
  ///
  /// In en, this message translates to:
  /// **'Save Details'**
  String get aiMatchSaveDetails;

  /// No description provided for @aiMatchNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get aiMatchNext;

  /// No description provided for @aiMatchPrevious.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get aiMatchPrevious;

  /// No description provided for @aiMatchGenderGirl.
  ///
  /// In en, this message translates to:
  /// **'Girl'**
  String get aiMatchGenderGirl;

  /// No description provided for @aiMatchGenderBoy.
  ///
  /// In en, this message translates to:
  /// **'Boy'**
  String get aiMatchGenderBoy;

  /// No description provided for @aiMatchGenderOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get aiMatchGenderOther;

  /// No description provided for @aiMatchInterestArtCraft.
  ///
  /// In en, this message translates to:
  /// **'Art & Craft'**
  String get aiMatchInterestArtCraft;

  /// No description provided for @aiMatchInterestSoccer.
  ///
  /// In en, this message translates to:
  /// **'Soccer'**
  String get aiMatchInterestSoccer;

  /// No description provided for @aiMatchInterestScience.
  ///
  /// In en, this message translates to:
  /// **'Science'**
  String get aiMatchInterestScience;

  /// No description provided for @aiMatchInterestMusic.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get aiMatchInterestMusic;

  /// No description provided for @aiMatchStep2Title.
  ///
  /// In en, this message translates to:
  /// **'Level up the fun.'**
  String get aiMatchStep2Title;

  /// No description provided for @aiMatchStep2Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us about their skill level and specific goals.'**
  String get aiMatchStep2Subtitle;

  /// No description provided for @aiMatchSkillLevelLabel.
  ///
  /// In en, this message translates to:
  /// **'CURRENT SKILL LEVEL'**
  String get aiMatchSkillLevelLabel;

  /// No description provided for @aiMatchSpecificInterestLabel.
  ///
  /// In en, this message translates to:
  /// **'SPECIFIC INTEREST'**
  String get aiMatchSpecificInterestLabel;

  /// No description provided for @aiMatchFocusAreasLabel.
  ///
  /// In en, this message translates to:
  /// **'FOCUS AREAS & GOALS'**
  String get aiMatchFocusAreasLabel;

  /// No description provided for @aiMatchMedicalIssuesLabel.
  ///
  /// In en, this message translates to:
  /// **'Medical issues'**
  String get aiMatchMedicalIssuesLabel;

  /// No description provided for @aiMatchMedicalIssuesHint.
  ///
  /// In en, this message translates to:
  /// **'if any, specify here'**
  String get aiMatchMedicalIssuesHint;

  /// No description provided for @aiMatchSpecificInterestHintExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. Learning to build custom PC builds...'**
  String get aiMatchSpecificInterestHintExample;

  /// No description provided for @aiMatchSkillBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get aiMatchSkillBeginner;

  /// No description provided for @aiMatchSkillIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get aiMatchSkillIntermediate;

  /// No description provided for @aiMatchSkillAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get aiMatchSkillAdvanced;

  /// No description provided for @aiMatchFocusConfidence.
  ///
  /// In en, this message translates to:
  /// **'Confidence Building'**
  String get aiMatchFocusConfidence;

  /// No description provided for @aiMatchFocusTechnical.
  ///
  /// In en, this message translates to:
  /// **'Technical Skills'**
  String get aiMatchFocusTechnical;

  /// No description provided for @aiMatchFocusSocial.
  ///
  /// In en, this message translates to:
  /// **'Social Interaction'**
  String get aiMatchFocusSocial;

  /// No description provided for @aiMatchFocusCompetitive.
  ///
  /// In en, this message translates to:
  /// **'Competitive Prep'**
  String get aiMatchFocusCompetitive;

  /// No description provided for @aiMatchFocusCreative.
  ///
  /// In en, this message translates to:
  /// **'Creative Expression'**
  String get aiMatchFocusCreative;

  /// No description provided for @aiMatchStep3Title.
  ///
  /// In en, this message translates to:
  /// **'When and where?'**
  String get aiMatchStep3Title;

  /// No description provided for @aiMatchStep3Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Help us narrow down the perfect schedule and location for your matches.'**
  String get aiMatchStep3Subtitle;

  /// No description provided for @aiMatchPreferredDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'PREFERRED DAYS'**
  String get aiMatchPreferredDaysLabel;

  /// No description provided for @aiMatchTimePreferenceLabel.
  ///
  /// In en, this message translates to:
  /// **'TIME PREFERENCE'**
  String get aiMatchTimePreferenceLabel;

  /// No description provided for @aiMatchBudgetRangeLabel.
  ///
  /// In en, this message translates to:
  /// **'BUDGET RANGE'**
  String get aiMatchBudgetRangeLabel;

  /// No description provided for @aiMatchLocationRadiusLabel.
  ///
  /// In en, this message translates to:
  /// **'LOCATION & RADIUS'**
  String get aiMatchLocationRadiusLabel;

  /// No description provided for @aiMatchRadiusHint.
  ///
  /// In en, this message translates to:
  /// **'RADIUS'**
  String get aiMatchRadiusHint;

  /// No description provided for @aiMatchLocationHint.
  ///
  /// In en, this message translates to:
  /// **'Enter zip code or neighborhood'**
  String get aiMatchLocationHint;

  /// No description provided for @aiMatchFindMatches.
  ///
  /// In en, this message translates to:
  /// **'Find Matches'**
  String get aiMatchFindMatches;

  /// No description provided for @aiMatchEngineCaption.
  ///
  /// In en, this message translates to:
  /// **'Powered by AI Matchmaking Engine v4.2'**
  String get aiMatchEngineCaption;

  /// No description provided for @aiMatchSocialProofTitle.
  ///
  /// In en, this message translates to:
  /// **'Families nearby are matching now'**
  String get aiMatchSocialProofTitle;

  /// No description provided for @aiMatchSocialProofSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Continue to unlock your best personalized matches.'**
  String get aiMatchSocialProofSubtitle;

  /// No description provided for @aiMatchDayMon.
  ///
  /// In en, this message translates to:
  /// **'M'**
  String get aiMatchDayMon;

  /// No description provided for @aiMatchDayTue.
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get aiMatchDayTue;

  /// No description provided for @aiMatchDayWed.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get aiMatchDayWed;

  /// No description provided for @aiMatchDayThu.
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get aiMatchDayThu;

  /// No description provided for @aiMatchDayFri.
  ///
  /// In en, this message translates to:
  /// **'F'**
  String get aiMatchDayFri;

  /// No description provided for @aiMatchDaySat.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get aiMatchDaySat;

  /// No description provided for @aiMatchDaySun.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get aiMatchDaySun;

  /// No description provided for @aiMatchTimeMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get aiMatchTimeMorning;

  /// No description provided for @aiMatchTimeAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Afternoon'**
  String get aiMatchTimeAfternoon;

  /// No description provided for @aiMatchTimeEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get aiMatchTimeEvening;

  /// No description provided for @aiMatchMilesValue.
  ///
  /// In en, this message translates to:
  /// **'{miles} Miles'**
  String aiMatchMilesValue(int miles);

  /// No description provided for @aiMatchInterestHintSoccer.
  ///
  /// In en, this message translates to:
  /// **'Soccer is a strong pick. Try an evening trial first to test energy.'**
  String get aiMatchInterestHintSoccer;

  /// No description provided for @aiMatchInterestHintScience.
  ///
  /// In en, this message translates to:
  /// **'Science interest looks clear. Prioritize hands-on experiment programs.'**
  String get aiMatchInterestHintScience;

  /// No description provided for @aiMatchInterestHintMusic.
  ///
  /// In en, this message translates to:
  /// **'Music is a great path. Start with short sessions, then scale duration.'**
  String get aiMatchInterestHintMusic;

  /// No description provided for @aiMatchInterestHintArt.
  ///
  /// In en, this message translates to:
  /// **'Art fits this profile well. Look for calm spaces with patient mentors.'**
  String get aiMatchInterestHintArt;

  /// No description provided for @aiMatchInterestHintDefault.
  ///
  /// In en, this message translates to:
  /// **'Pick interests to improve matching precision before continuing.'**
  String get aiMatchInterestHintDefault;

  /// No description provided for @aiMatchStatusReady.
  ///
  /// In en, this message translates to:
  /// **'Ready to match'**
  String get aiMatchStatusReady;

  /// No description provided for @aiMatchStatusNeedsTouch.
  ///
  /// In en, this message translates to:
  /// **'Profile needs one more touch'**
  String get aiMatchStatusNeedsTouch;

  /// No description provided for @aiMatchSavedAt.
  ///
  /// In en, this message translates to:
  /// **'Saved at {time}'**
  String aiMatchSavedAt(String time);

  /// No description provided for @aiMatchLiveProfileCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Live Profile Card'**
  String get aiMatchLiveProfileCardTitle;

  /// No description provided for @aiMatchPassionsSummary.
  ///
  /// In en, this message translates to:
  /// **'Passions Summary'**
  String get aiMatchPassionsSummary;

  /// No description provided for @aiMatchProfileStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Profile Status:'**
  String get aiMatchProfileStatusLabel;

  /// No description provided for @aiMatchPassionsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Passions yet to be discovered...'**
  String get aiMatchPassionsEmpty;

  /// No description provided for @aiMatchTapSwitchHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to switch summary and hint'**
  String get aiMatchTapSwitchHint;

  /// No description provided for @aiMatchBadgeArts.
  ///
  /// In en, this message translates to:
  /// **'Arts'**
  String get aiMatchBadgeArts;

  /// No description provided for @aiMatchBadgeSoccer.
  ///
  /// In en, this message translates to:
  /// **'Soccer'**
  String get aiMatchBadgeSoccer;

  /// No description provided for @aiMatchBadgeScience.
  ///
  /// In en, this message translates to:
  /// **'Science'**
  String get aiMatchBadgeScience;

  /// No description provided for @aiMatchBadgeMusic.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get aiMatchBadgeMusic;

  /// No description provided for @aiMatchTypeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type your message...'**
  String get aiMatchTypeMessage;

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
