part of 'package:activly/activly_app.dart';

const Duration kButtonLoadingDuration = Duration(milliseconds: 550);
const Duration kButtonFillDuration = Duration(milliseconds: 320);
const Duration kButtonLoaderRevealDelay = Duration(milliseconds: 380);
const double kFixedTopSpace = 51.0;
const double kTopControlsVerticalOffset = 8.0;
const double kTopControlsSidePadding = 16.0;
const double kTopControlHeight = 36.0;
const double kTopControlWidth = 82.0;

const Color kColorWhite = Color(0xFFFFFFFF);
const Color kColorBlack = Color(0xFF000000);
const Color kColorPrimary = Color(0xFF7C4CFF);
const Color kColorPrimaryAccent = Color(0xFF8B5CF6);
const Color kColorPrimarySoft = Color(0xFF9F7BFF);
const Color kColorSurfaceDark = Color(0xFF0D0D0D);
const Color kColorPanelDark = Color(0xFF0B0B0D);
const Color kColorLavender = Color(0xFFECE8FE);
const Color kColorSpinnerNeutral = Color(0xFF69717D);
const Color kColorLoaderHeart = Color(0xFFFC0065);
const Color kColorLoaderShadowBase = Color(0xFFD7D7D7);
const Color kColorLoaderShadowPulse = Color(0xFFE4E4E4);
const Color kColorVideoFallbackStart = Color(0xFF2A2A2A);
const Color kColorVideoFallbackEnd = Color(0xFF101010);

const Color kColorGoogleRed = Color(0xFFEA4335);
const Color kColorGoogleYellow = Color(0xFFFBBC05);
const Color kColorGoogleGreen = Color(0xFF34A853);
const Color kColorGoogleBlue = Color(0xFF4285F4);

const Color kColorShadowBlack70 = Color.fromRGBO(0, 0, 0, 0.70);
const Color kColorShadowPurple44 = Color.fromRGBO(124, 76, 255, 0.44);

const Color kAiColorPrimary = kColorPrimary;
const Color kAiColorPrimaryAccent = kColorPrimaryAccent;
const Color kAiColorPrimarySoft = kColorPrimarySoft;
const Color kAiColorAvatarStart = Color(0xFFF5F3FF);
const Color kAiColorAvatarEnd = Color(0xFFE0D8FF);
const Color kAiColorSurface = kColorWhite;
const Color kAiColorSurfaceBorder = Color(0xFFE8E8E8);
const Color kAiColorSurfaceSelected = Color(0xFFF4EFFF);
const Color kAiColorTextDark = Color(0xFF161616);
const Color kAiColorTextInput = Color(0xFF1A1C1C);
const Color kAiColorHint = Color(0xFF8B8F98);

const Color kAiColorPageBackground = Color(0xFFF8F9FF);
const Color kAiColorBackdropOrbPrimary = Color(0xFFE8E1FF);
const Color kAiColorBackdropOrbWarm = Color(0xFFFFEED9);
const Color kAiColorTextMutedDark = Color(0xFF677285);
const Color kAiColorSurfaceContainerLight = Color(0xFFF0F2F8);
const Color kAiColorInputBorderLight = Color(0xFFDCE1EA);
const Color kAiColorInputFillLight = Color(0xFFFCFDFF);
const Color kAiColorProgressInactive = Color(0xFFD6DCE8);
const Color kAiColorProgressTrack = Color(0xFFE4E8F0);
const Color kAiColorBubbleBorder = Color(0xFFE5EAF2);
const Color kAiColorBottomNavBackgroundLight = Color(0xF2F9FAFD);
const Color kAiColorBottomNavBorderLight = Color(0xFFE0E4EE);
const Color kAiColorBottomNavInactiveLight = Color(0xFF8A93A5);

const Color kAiShadowMedium = Color.fromRGBO(0, 0, 0, 0.45);
const Color kAiShadowInput = Color.fromRGBO(0, 0, 0, 0.40);
const Color kAiShadowPurple = Color.fromRGBO(124, 76, 255, 0.75);

const Map<AppLanguage, TranslationCopy> kTranslations = {
  AppLanguage.en: TranslationCopy(
    appName: 'Activly',
    taglineLine1: 'The most playful way for kids',
    taglineLine2: 'to discover activities and make new friends.',
    continueWithGoogle: 'Continue with Google',
    continueWithApple: 'Continue with Apple',
    email: 'Email',
    phone: 'Phone',
    emailOrPhone: 'Email or Phone',
    fullName: 'Full Name',
    password: 'Password',
    confirmPassword: 'Confirm Password',
    loginTitle: 'Welcome Back',
    loginSubtitle: 'Sign in to keep discovering activities and friends.',
    signInCta: 'Sign In',
    createAccountTitle: 'Create Account',
    createAccountSubtitle: 'Set up your account to start exploring activities.',
    createAccountCta: 'Create New Account',
    createNewAccount: 'Create New Account',
    dontHaveAccount: "Don't have an account?",
    createOne: 'Create one',
    byContinuing: 'By continuing, you agree to our',
    terms: 'Terms',
    privacyPolicy: 'Privacy Policy',
    alreadyHaveAccount: 'Already have an account?',
    forgotPassword: 'Forgot Password?',
    forgotPasswordTitle: 'Recover Password',
    forgotPasswordSubtitle:
        'Enter your email or phone to receive a verification code.',
    sendCode: 'Send Verification Code',
    otpTitle: 'Verify OTP',
    otpSubtitle: 'Enter the 6-digit code sent to',
    verifyCode: 'Verify Code',
    resendCode: 'Resend Code',
    changeContact: 'Change',
    resetPasswordTitle: 'Create New Password',
    resetPasswordSubtitle:
        'Your new password must be different from the previous one.',
    saveNewPassword: 'Save New Password',
    accountCreatedNotice: 'Account created successfully. Please sign in.',
    passwordResetSuccess: 'Password updated. You can now sign in.',
    backToSignIn: 'Back to Sign In',
    back: 'Back',
    skipForNow: 'Skip for Now',
    or: 'or',
    en: 'EN',
    ar: 'عربي',
  ),
  AppLanguage.ar: TranslationCopy(
    appName: 'أكتيفلي',
    taglineLine1: 'الطريقة الأكثر متعة للأطفال',
    taglineLine2: 'لاكتشاف الأنشطة وتكوين صداقات جديدة.',
    continueWithGoogle: 'المتابعة مع Google',
    continueWithApple: 'المتابعة مع Apple',
    email: 'البريد',
    phone: 'الهاتف',
    emailOrPhone: 'البريد أو الهاتف',
    fullName: 'الاسم الكامل',
    password: 'كلمة المرور',
    confirmPassword: 'تأكيد كلمة المرور',
    loginTitle: 'مرحباً بعودتك',
    loginSubtitle: 'سجّل الدخول لمواصلة اكتشاف الأنشطة وتكوين الأصدقاء.',
    signInCta: 'تسجيل الدخول',
    createAccountTitle: 'إنشاء حساب',
    createAccountSubtitle: 'أنشئ حسابك لبدء استكشاف الأنشطة.',
    createAccountCta: 'إنشاء حساب جديد',
    createNewAccount: 'إنشاء حساب جديد',
    dontHaveAccount: 'ليس لديك حساب؟',
    createOne: 'أنشئ حساباً',
    byContinuing: 'بالمتابعة فإنك توافق على',
    terms: 'الشروط',
    privacyPolicy: 'سياسة الخصوصية',
    alreadyHaveAccount: 'هل لديك حساب بالفعل؟',
    forgotPassword: 'هل نسيت كلمة المرور؟',
    forgotPasswordTitle: 'استعادة كلمة المرور',
    forgotPasswordSubtitle: 'أدخل بريدك أو هاتفك لإرسال رمز التحقق.',
    sendCode: 'إرسال رمز التحقق',
    otpTitle: 'التحقق من الرمز',
    otpSubtitle: 'أدخل الرمز المكون من 6 أرقام المرسل إلى',
    verifyCode: 'تأكيد الرمز',
    resendCode: 'إعادة إرسال الرمز',
    changeContact: 'تعديل',
    resetPasswordTitle: 'إنشاء كلمة مرور جديدة',
    resetPasswordSubtitle: 'يجب أن تكون كلمة المرور الجديدة مختلفة عن السابقة.',
    saveNewPassword: 'حفظ كلمة المرور الجديدة',
    accountCreatedNotice: 'تم إنشاء الحساب بنجاح. يمكنك تسجيل الدخول الآن.',
    passwordResetSuccess: 'تم تحديث كلمة المرور. يمكنك تسجيل الدخول الآن.',
    backToSignIn: 'العودة لتسجيل الدخول',
    back: 'رجوع',
    skipForNow: 'تخطي للآن',
    or: 'أو',
    en: 'EN',
    ar: 'عربي',
  ),
};

const List<String> kVideoAssets = <String>[
  'assets/videos/indor-guitar-6s.mp4',
  'assets/videos/study-6s.mp4',
  'assets/videos/swimmig-pool-6s.mp4',
  'assets/videos/gaint-wheel-6s.mp4',
];
