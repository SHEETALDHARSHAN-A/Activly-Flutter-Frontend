part of 'package:activly/activly_app.dart';

enum AppLanguage { en, ar }

enum AppPage { entry, landing, aiMatch, matchResults, login, main, featuredAll }

enum AuthStep { signIn, createAccount, forgotPassword, otp, resetPassword }

enum OtpPurpose { createAccount, resetPassword }

typedef AsyncTapCallback = Future<void> Function();
