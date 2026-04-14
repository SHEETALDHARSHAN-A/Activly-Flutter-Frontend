part of 'package:activly/activly_app.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    super.key,
    required this.language,
    required this.t,
    required this.onToggleLanguage,
    required this.onBackToLanding,
  });

  final AppLanguage language;
  final TranslationCopy t;
  final VoidCallback onToggleLanguage;
  final VoidCallback onBackToLanding;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  static const int _otpLength = 6;
  static const int _resendDurationSeconds = 45;

  AuthStep _step = AuthStep.signIn;
  OtpPurpose _otpPurpose = OtpPurpose.createAccount;
  String _otpDestination = '';
  int _resendSeconds = _resendDurationSeconds;
  String _notice = '';

  late final TextEditingController _signInIdentifier;
  late final TextEditingController _signInPassword;
  late final TextEditingController _createName;
  late final TextEditingController _createEmail;
  late final TextEditingController _createPhone;
  late final TextEditingController _createPassword;
  late final TextEditingController _createConfirmPassword;
  late final TextEditingController _forgotIdentifier;
  late final TextEditingController _resetPassword;
  late final TextEditingController _resetConfirmPassword;

  late final List<TextEditingController> _otpControllers;
  late final List<FocusNode> _otpFocusNodes;
  List<String> _otpDigits = List<String>.filled(_otpLength, '');

  bool _showSignInPassword = false;
  bool _showCreatePassword = false;
  bool _showCreateConfirmPassword = false;
  bool _showResetPassword = false;
  bool _showResetConfirmPassword = false;

  Timer? _resendTimer;

  bool get _isArabic => widget.language == AppLanguage.ar;

  @override
  void initState() {
    super.initState();
    _signInIdentifier = TextEditingController();
    _signInPassword = TextEditingController();
    _createName = TextEditingController();
    _createEmail = TextEditingController();
    _createPhone = TextEditingController();
    _createPassword = TextEditingController();
    _createConfirmPassword = TextEditingController();
    _forgotIdentifier = TextEditingController();
    _resetPassword = TextEditingController();
    _resetConfirmPassword = TextEditingController();
    _otpControllers = List<TextEditingController>.generate(
      _otpLength,
      (_) => TextEditingController(),
    );
    _otpFocusNodes = List<FocusNode>.generate(_otpLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    _signInIdentifier.dispose();
    _signInPassword.dispose();
    _createName.dispose();
    _createEmail.dispose();
    _createPhone.dispose();
    _createPassword.dispose();
    _createConfirmPassword.dispose();
    _forgotIdentifier.dispose();
    _resetPassword.dispose();
    _resetConfirmPassword.dispose();

    for (final controller in _otpControllers) {
      controller.dispose();
    }
    for (final node in _otpFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _goToStep(AuthStep nextStep) {
    setState(() {
      _notice = '';
      _step = nextStep;
    });
    if (nextStep != AuthStep.otp) {
      _resendTimer?.cancel();
    }
  }

  String get _passwordMismatchText =>
      _isArabic ? 'كلمتا المرور غير متطابقتين.' : 'Passwords do not match.';

  String get _missingSignupFieldsText => _isArabic
      ? 'يرجى إدخال البريد والهاتف.'
      : 'Please enter both email and phone.';

  String get _missingIdentifierText => _isArabic
      ? 'يرجى إدخال البريد أو الهاتف.'
      : 'Please enter your email or phone.';

  String get _expiredOtpText => _isArabic ? 'انتهت صلاحية الرمز' : 'Expired OTP';

  void _handleTopBack() {
    if (_step == AuthStep.signIn) {
      widget.onBackToLanding();
      return;
    }

    if (_step == AuthStep.otp) {
      setState(() {
        _step = _otpPurpose == OtpPurpose.createAccount
            ? AuthStep.createAccount
            : AuthStep.forgotPassword;
      });
      _resendTimer?.cancel();
      return;
    }

    setState(() {
      _step = AuthStep.signIn;
    });
  }

  void _clearOtpDigits() {
    _otpDigits = List<String>.filled(_otpLength, '');
    for (final c in _otpControllers) {
      c.clear();
    }
  }

  void _startOtpTimer() {
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        _resendSeconds = math.max(_resendSeconds - 1, 0);
      });

      if (_resendSeconds == 0) {
        timer.cancel();
      }
    });
  }

  void _handleCreateAccount() {
    if (_createEmail.text.trim().isEmpty || _createPhone.text.trim().isEmpty) {
      setState(() => _notice = _missingSignupFieldsText);
      return;
    }

    if (_createPassword.text != _createConfirmPassword.text) {
      setState(() => _notice = _passwordMismatchText);
      return;
    }

    setState(() {
      _notice = '';
      _otpPurpose = OtpPurpose.createAccount;
      _otpDestination = _createEmail.text.trim().isNotEmpty
          ? _createEmail.text.trim()
          : _createPhone.text.trim();
      _clearOtpDigits();
      _resendSeconds = _resendDurationSeconds;
      _step = AuthStep.otp;
    });

    _startOtpTimer();
    Future<void>.delayed(Duration.zero, () {
      if (mounted) {
        _otpFocusNodes.first.requestFocus();
      }
    });
  }

  void _handleSendResetCode() {
    if (_forgotIdentifier.text.trim().isEmpty) {
      setState(() => _notice = _missingIdentifierText);
      return;
    }

    setState(() {
      _notice = '';
      _otpPurpose = OtpPurpose.resetPassword;
      _otpDestination = _forgotIdentifier.text.trim();
      _clearOtpDigits();
      _resendSeconds = _resendDurationSeconds;
      _step = AuthStep.otp;
    });

    _startOtpTimer();
    Future<void>.delayed(Duration.zero, () {
      if (mounted) {
        _otpFocusNodes.first.requestFocus();
      }
    });
  }

  void _handleVerifyOtp() {
    if (_resendSeconds <= 0) {
      setState(() => _notice = _expiredOtpText);
      return;
    }

    final otpCode = _otpDigits.join();
    if (otpCode.length < _otpLength) {
      return;
    }

    if (_otpPurpose == OtpPurpose.resetPassword) {
      setState(() {
        _notice = '';
        _step = AuthStep.resetPassword;
      });
      _resendTimer?.cancel();
      return;
    }

    setState(() {
      _signInIdentifier.text = _otpDestination;
      _signInPassword.clear();
      _notice = widget.t.accountCreatedNotice;
      _step = AuthStep.signIn;
    });
    _resendTimer?.cancel();
  }

  void _handleSaveNewPassword() {
    if (_resetPassword.text != _resetConfirmPassword.text) {
      setState(() => _notice = _passwordMismatchText);
      return;
    }

    setState(() {
      _notice = widget.t.passwordResetSuccess;
      _signInIdentifier.text = _otpDestination;
      _signInPassword.clear();
      _step = AuthStep.signIn;
    });
  }

  void _handleSignInSubmit() {
    // Reference behavior is currently UI-only (no backend call/navigation).
  }

  void _onOtpChanged(int index, String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');

    if (digits.isEmpty) {
      setState(() {
        _otpDigits[index] = '';
      });
      if (index > 0) {
        _otpFocusNodes[index - 1].requestFocus();
      }
      return;
    }

    if (digits.length > 1) {
      final chars = digits.split('');
      setState(() {
        for (int i = 0; i < chars.length && (index + i) < _otpLength; i++) {
          final target = index + i;
          _otpDigits[target] = chars[i];
          _otpControllers[target].text = chars[i];
          _otpControllers[target].selection = TextSelection.fromPosition(
            const TextPosition(offset: 1),
          );
        }
      });

      final focusIndex = math.min(index + chars.length, _otpLength - 1);
      _otpFocusNodes[focusIndex].requestFocus();
      return;
    }

    final digit = digits.substring(digits.length - 1);
    if (_otpControllers[index].text != digit) {
      _otpControllers[index].text = digit;
      _otpControllers[index].selection = TextSelection.fromPosition(
        const TextPosition(offset: 1),
      );
    }

    setState(() {
      _otpDigits[index] = digit;
    });

    if (index < _otpLength - 1) {
      _otpFocusNodes[index + 1].requestFocus();
    } else {
      _otpFocusNodes[index].unfocus();
    }
  }

  Widget _inputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction? textInputAction,
    ValueChanged<String>? onSubmitted,
    bool obscure = false,
    bool showToggle = false,
    required bool showText,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.80),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onSubmitted: onSubmitted,
          obscureText: obscure && !showText,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.45)),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.10),
            prefixIcon: Icon(
              icon,
              color: Colors.white.withValues(alpha: 0.55),
              size: 18,
            ),
            suffixIcon: showToggle
                ? IconButton(
                    onPressed: onToggle,
                    icon: Icon(
                      showText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.white.withValues(alpha: 0.55),
                      size: 18,
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.20),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.50),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final backIcon = _isArabic ? Icons.chevron_right : Icons.chevron_left;
    final actionIcon = _isArabic ? Icons.chevron_left : Icons.chevron_right;

    final stepTitle = switch (_step) {
      AuthStep.signIn => widget.t.loginTitle,
      AuthStep.createAccount => widget.t.createAccountTitle,
      AuthStep.forgotPassword => widget.t.forgotPasswordTitle,
      AuthStep.otp => widget.t.otpTitle,
      AuthStep.resetPassword => widget.t.resetPasswordTitle,
    };

    final stepSubtitle = switch (_step) {
      AuthStep.signIn => widget.t.loginSubtitle,
      AuthStep.createAccount => widget.t.createAccountSubtitle,
      AuthStep.forgotPassword => widget.t.forgotPasswordSubtitle,
      AuthStep.otp => widget.t.otpSubtitle,
      AuthStep.resetPassword => widget.t.resetPasswordSubtitle,
    };

    final showAuthTypeSwitch =
        _step == AuthStep.signIn || _step == AuthStep.createAccount;

    return Directionality(
      textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _LoadingOutlinedButtonIcon(
                        onTap: () async => _handleTopBack(),
                        icon: Icon(backIcon, size: 16),
                        label: widget.t.back,
                      ),
                      LanguageToggle(
                        language: widget.language,
                        onToggle: widget.onToggleLanguage,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Image.asset(
                    'assets/Activly-logo.png',
                    width: 186,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.45),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.20),
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              blurRadius: 60,
                              spreadRadius: -35,
                              offset: Offset(0, 24),
                              color: Color.fromRGBO(0, 0, 0, 0.70),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            if (_notice.isNotEmpty)
                              Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF7C4CFF,
                                  ).withValues(alpha: 0.15),
                                  border: Border.all(
                                    color: const Color(
                                      0xFF7C4CFF,
                                    ).withValues(alpha: 0.40),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  _notice,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            Text(
                              stepTitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              stepSubtitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white.withValues(alpha: 0.70),
                              ),
                            ),
                            if (_step == AuthStep.otp && _otpDestination.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  _otpDestination,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white.withValues(alpha: 0.9),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            if (showAuthTypeSwitch) ...<Widget>[
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.10),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.20),
                                  ),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: _SegmentButton(
                                        label: widget.t.signInCta,
                                        selected: _step == AuthStep.signIn,
                                        onTap: () async => _goToStep(AuthStep.signIn),
                                      ),
                                    ),
                                    Expanded(
                                      child: _SegmentButton(
                                        label: widget.t.createNewAccount,
                                        selected: _step == AuthStep.createAccount,
                                        onTap: () async =>
                                            _goToStep(AuthStep.createAccount),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            const SizedBox(height: 16),
                            if (_step == AuthStep.signIn)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  _inputField(
                                    label: widget.t.emailOrPhone,
                                    controller: _signInIdentifier,
                                    icon: Icons.mail_outline,
                                    hint: widget.t.emailOrPhone,
                                    showText: true,
                                    onToggle: () {},
                                  ),
                                  const SizedBox(height: 12),
                                  _inputField(
                                    label: widget.t.password,
                                    controller: _signInPassword,
                                    icon: Icons.lock_outline,
                                    obscure: true,
                                    showToggle: true,
                                    showText: _showSignInPassword,
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (_) => _handleSignInSubmit(),
                                    onToggle: () => setState(
                                      () => _showSignInPassword =
                                          !_showSignInPassword,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: _LoadingTextButton(
                                      label: widget.t.forgotPassword,
                                      onTap: () async =>
                                          _goToStep(AuthStep.forgotPassword),
                                      textStyle: TextStyle(
                                        color: Colors.white.withValues(
                                          alpha: 0.80,
                                        ),
                                        fontSize: 12,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                  _ActionButton(
                                    label: widget.t.signInCta,
                                    icon: actionIcon,
                                    onTap: () async => _handleSignInSubmit(),
                                  ),
                                  const SizedBox(height: 10),
                                  Text.rich(
                                    TextSpan(
                                      style: TextStyle(
                                        color: Colors.white.withValues(
                                          alpha: 0.70,
                                        ),
                                        fontSize: 12,
                                      ),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: '${widget.t.dontHaveAccount} ',
                                        ),
                                        WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: _LoadingLinkText(
                                            text: widget.t.createOne,
                                            onTap: () async =>
                                                _goToStep(AuthStep.createAccount),
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${widget.t.byContinuing} ${widget.t.terms} ${_isArabic ? 'و' : 'and'} ${widget.t.privacyPolicy}.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white.withValues(
                                        alpha: 0.55,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (_step == AuthStep.createAccount)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  _inputField(
                                    label: widget.t.fullName,
                                    controller: _createName,
                                    icon: Icons.person_outline,
                                    hint:
                                        _isArabic ? 'اسمك الكامل' : 'Your full name',
                                    showText: true,
                                    onToggle: () {},
                                  ),
                                  const SizedBox(height: 12),
                                  _inputField(
                                    label: widget.t.email,
                                    controller: _createEmail,
                                    icon: Icons.mail_outline,
                                    hint: 'name@example.com',
                                    keyboardType: TextInputType.emailAddress,
                                    showText: true,
                                    onToggle: () {},
                                  ),
                                  const SizedBox(height: 12),
                                  _inputField(
                                    label: widget.t.phone,
                                    controller: _createPhone,
                                    icon: Icons.phone_outlined,
                                    hint: '+971 50 000 0000',
                                    keyboardType: TextInputType.phone,
                                    showText: true,
                                    onToggle: () {},
                                  ),
                                  const SizedBox(height: 12),
                                  _inputField(
                                    label: widget.t.password,
                                    controller: _createPassword,
                                    icon: Icons.lock_outline,
                                    obscure: true,
                                    showToggle: true,
                                    showText: _showCreatePassword,
                                    onToggle: () => setState(
                                      () =>
                                          _showCreatePassword = !_showCreatePassword,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  _inputField(
                                    label: widget.t.confirmPassword,
                                    controller: _createConfirmPassword,
                                    icon: Icons.lock_outline,
                                    obscure: true,
                                    showToggle: true,
                                    showText: _showCreateConfirmPassword,
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (_) => _handleCreateAccount(),
                                    onToggle: () => setState(
                                      () => _showCreateConfirmPassword =
                                          !_showCreateConfirmPassword,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  _ActionButton(
                                    label: widget.t.createAccountCta,
                                    icon: actionIcon,
                                    onTap: () async => _handleCreateAccount(),
                                  ),
                                  const SizedBox(height: 10),
                                  Text.rich(
                                    TextSpan(
                                      style: TextStyle(
                                        color: Colors.white.withValues(
                                          alpha: 0.70,
                                        ),
                                        fontSize: 12,
                                      ),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text:
                                              '${widget.t.alreadyHaveAccount} ',
                                        ),
                                        WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: _LoadingLinkText(
                                            text: widget.t.signInCta,
                                            onTap: () async =>
                                                _goToStep(AuthStep.signIn),
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            if (_step == AuthStep.forgotPassword)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  _inputField(
                                    label: widget.t.emailOrPhone,
                                    controller: _forgotIdentifier,
                                    icon: Icons.mail_outline,
                                    hint: widget.t.emailOrPhone,
                                    showText: true,
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (_) => _handleSendResetCode(),
                                    onToggle: () {},
                                  ),
                                  const SizedBox(height: 12),
                                  _ActionButton(
                                    label: widget.t.sendCode,
                                    icon: actionIcon,
                                    onTap: () async => _handleSendResetCode(),
                                  ),
                                  const SizedBox(height: 10),
                                  _LoadingTextButton(
                                    label: widget.t.backToSignIn,
                                    onTap: () async => _goToStep(AuthStep.signIn),
                                    textStyle: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.75),
                                      fontSize: 12,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                            if (_step == AuthStep.otp)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.05),
                                      border: Border.all(
                                        color: Colors.white.withValues(alpha: 0.20),
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          _otpDestination.contains('@')
                                              ? Icons.mail_outline
                                              : Icons.phone_outlined,
                                          color: const Color(0xFF7C4CFF),
                                          size: 16,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            _otpDestination.isEmpty
                                                ? widget.t.emailOrPhone
                                                : _otpDestination,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        _LoadingTextButton(
                                          label: widget.t.changeContact,
                                          onTap: () async {
                                            _goToStep(
                                              _otpPurpose ==
                                                      OtpPurpose.createAccount
                                                  ? AuthStep.createAccount
                                                  : AuthStep.forgotPassword,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.edit_outlined,
                                            size: 14,
                                          ),
                                          style: TextButton.styleFrom(
                                            foregroundColor:
                                                const Color(0xFFECE8FE),
                                            backgroundColor:
                                                const Color(0xFF7C4CFF)
                                                    .withValues(alpha: 0.10),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(999),
                                              side: BorderSide(
                                                color: const Color(0xFF7C4CFF)
                                                    .withValues(alpha: 0.40),
                                              ),
                                            ),
                                          ),
                                          textStyle:
                                              const TextStyle(fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: List<Widget>.generate(_otpLength, (
                                        index,
                                      ) {
                                        return SizedBox(
                                          width: 44,
                                          height: 50,
                                          child: Focus(
                                            onKeyEvent: (_, KeyEvent event) {
                                              if (event is! KeyDownEvent) {
                                                return KeyEventResult.ignored;
                                              }

                                              if (event.logicalKey ==
                                                      LogicalKeyboardKey
                                                          .backspace &&
                                                  _otpControllers[index]
                                                      .text
                                                      .isEmpty &&
                                                  index > 0) {
                                                _otpFocusNodes[index - 1]
                                                    .requestFocus();
                                                return KeyEventResult.handled;
                                              }
                                              return KeyEventResult.ignored;
                                            },
                                            child: TextField(
                                              controller: _otpControllers[index],
                                              focusNode: _otpFocusNodes[index],
                                              onChanged: (value) =>
                                                  _onOtpChanged(index, value),
                                              keyboardType: TextInputType.number,
                                              textInputAction:
                                                  index < _otpLength - 1
                                                  ? TextInputAction.next
                                                  : TextInputAction.done,
                                              inputFormatters:
                                                  <TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                  ],
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              decoration: InputDecoration(
                                                counterText: '',
                                                filled: true,
                                                fillColor: Colors.white
                                                    .withValues(alpha: 0.10),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: BorderSide(
                                                    color: Colors.white
                                                        .withValues(alpha: 0.20),
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFF7C4CFF),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  _ActionButton(
                                    label: widget.t.verifyCode,
                                    icon: actionIcon,
                                    enabled: _otpDigits.join().length >= _otpLength &&
                                        _resendSeconds > 0,
                                    onTap: () async => _handleVerifyOtp(),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        _resendSeconds > 0
                                            ? '${widget.t.resendCode} : $_resendSeconds'
                                            : _expiredOtpText,
                                        style: TextStyle(
                                          color: Colors.white.withValues(
                                            alpha: 0.70,
                                          ),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      _LoadingTextButton(
                                        label: widget.t.resendCode,
                                        enabled: _resendSeconds == 0,
                                        onTap: () async {
                                          setState(() {
                                            _clearOtpDigits();
                                            _notice = '';
                                            _resendSeconds =
                                                _resendDurationSeconds;
                                          });
                                          _startOtpTimer();
                                          _otpFocusNodes.first.requestFocus();
                                        },
                                        textStyle: const TextStyle(
                                          color: Color(0xFF7C4CFF),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            if (_step == AuthStep.resetPassword)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  _inputField(
                                    label: widget.t.password,
                                    controller: _resetPassword,
                                    icon: Icons.lock_outline,
                                    obscure: true,
                                    showToggle: true,
                                    showText: _showResetPassword,
                                    onToggle: () => setState(
                                      () => _showResetPassword =
                                          !_showResetPassword,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  _inputField(
                                    label: widget.t.confirmPassword,
                                    controller: _resetConfirmPassword,
                                    icon: Icons.lock_outline,
                                    obscure: true,
                                    showToggle: true,
                                    showText: _showResetConfirmPassword,
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (_) => _handleSaveNewPassword(),
                                    onToggle: () => setState(
                                      () => _showResetConfirmPassword =
                                          !_showResetConfirmPassword,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  _ActionButton(
                                    label: widget.t.saveNewPassword,
                                    icon: actionIcon,
                                    onTap: () async => _handleSaveNewPassword(),
                                  ),
                                  const SizedBox(height: 10),
                                  _LoadingTextButton(
                                    label: widget.t.backToSignIn,
                                    onTap: () async => _goToStep(AuthStep.signIn),
                                    textStyle: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.75),
                                      fontSize: 12,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }
}
