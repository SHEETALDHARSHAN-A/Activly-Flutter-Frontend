part of 'package:activly/activly_app.dart';

class ActivlyShell extends StatefulWidget {
  const ActivlyShell({super.key, required this.enableVideos});

  final bool enableVideos;

  @override
  State<ActivlyShell> createState() => _ActivlyShellState();
}

class _ActivlyShellState extends State<ActivlyShell> {
  static const double _splitLayoutBreakpoint = 1100;

  AppLanguage _language = AppLanguage.en;
  bool _isLoaded = false;
  bool _isLoaderVisible = true;
  int _currentVideoIndex = 0;
  AppPage _activePage = AppPage.landing;

  final List<bool> _videoError = List<bool>.filled(kVideoAssets.length, false);
  final List<VideoPlayerController?> _videoControllers =
      List<VideoPlayerController?>.filled(kVideoAssets.length, null);

  Timer? _fallbackTimer;
  Timer? _carouselTimer;
  bool _hasRevealedPage = false;

  TranslationCopy get _t => kTranslations[_language]!;

  @override
  void initState() {
    super.initState();
    _startFallbackTimer();

    if (widget.enableVideos) {
      unawaited(_initializeVideos());
    } else {
      Future<void>.delayed(const Duration(milliseconds: 450), _revealPage);
    }
  }

  @override
  void dispose() {
    _fallbackTimer?.cancel();
    _carouselTimer?.cancel();
    for (final controller in _videoControllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  void _startFallbackTimer() {
    _fallbackTimer?.cancel();
    _fallbackTimer = Timer(const Duration(milliseconds: 6500), _revealPage);
  }

  Future<void> _initializeVideos() async {
    for (int i = 0; i < kVideoAssets.length; i++) {
      final controller = VideoPlayerController.asset(kVideoAssets[i]);
      _videoControllers[i] = controller;

      try {
        await controller.initialize();
        await controller.setVolume(0);
        await controller.setLooping(true);

        controller.addListener(() {
          if (!mounted) {
            return;
          }

          if (i == _currentVideoIndex &&
              controller.value.isInitialized &&
              controller.value.isPlaying) {
            _revealPage();
          }
        });
      } catch (_) {
        _handleVideoFailure(i);
      }
    }

    if (!mounted) {
      return;
    }

    await _playVideoSafely(_currentVideoIndex);
  }

  int _getNextPlayableIndex(int fromIndex, {int? skipIndex}) {
    for (int step = 1; step <= kVideoAssets.length; step++) {
      final candidate = (fromIndex + step) % kVideoAssets.length;
      if (skipIndex != null && candidate == skipIndex) {
        continue;
      }
      if (!_videoError[candidate]) {
        return candidate;
      }
    }

    return fromIndex;
  }

  Future<void> _playVideoSafely(int index) async {
    if (!widget.enableVideos) {
      return;
    }

    for (int i = 0; i < _videoControllers.length; i++) {
      if (i == index) {
        continue;
      }
      final other = _videoControllers[i];
      if (other?.value.isInitialized ?? false) {
        await other!.pause();
      }
    }

    final current = _videoControllers[index];
    if (current == null || !current.value.isInitialized || _videoError[index]) {
      return;
    }

    try {
      await current.play();
      if (index == _currentVideoIndex) {
        _revealPage();
      }
    } catch (_) {
      Future<void>.delayed(const Duration(milliseconds: 220), () async {
        if (!mounted || _currentVideoIndex != index) {
          return;
        }
        try {
          await current.play();
        } catch (_) {
          // fallback timer reveals page
        }
      });
    }
  }

  void _startCarouselTimer() {
    _carouselTimer?.cancel();
    if (!_isLoaded) {
      return;
    }

    _carouselTimer = Timer.periodic(const Duration(seconds: 6), (_) {
      final nextIndex = _getNextPlayableIndex(_currentVideoIndex);
      _setCurrentVideo(nextIndex);
    });
  }

  void _setCurrentVideo(int nextIndex) {
    if (_currentVideoIndex == nextIndex) {
      return;
    }

    setState(() {
      _currentVideoIndex = nextIndex;
    });
    unawaited(_playVideoSafely(nextIndex));
  }

  void _revealPage() {
    if (_hasRevealedPage || !mounted) {
      return;
    }

    _hasRevealedPage = true;
    setState(() {
      _isLoaderVisible = false;
      _isLoaded = true;
    });
    _startCarouselTimer();
  }

  void _handleVideoFailure(int index) {
    if (!mounted) {
      return;
    }

    setState(() {
      _videoError[index] = true;
    });

    if (_isLoaderVisible && index == _currentVideoIndex) {
      final fallbackIndex = _getNextPlayableIndex(index, skipIndex: index);
      if (fallbackIndex != index) {
        _setCurrentVideo(fallbackIndex);
      } else {
        _revealPage();
      }
    }
  }

  void _toggleLanguage() {
    setState(() {
      _language = _language == AppLanguage.en ? AppLanguage.ar : AppLanguage.en;
    });
  }

  Future<void> _goToLoginPage() async {
    if (!mounted) {
      return;
    }
    setState(() => _activePage = AppPage.login);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final useSplitLayout = screenWidth >= _splitLayoutBreakpoint;

    Widget pageContent() {
      if (_activePage == AppPage.landing) {
        return LandingScreen(
          language: _language,
          isLoaded: _isLoaded,
          t: _t,
          currentVideoIndex: _currentVideoIndex,
          totalVideos: kVideoAssets.length,
          onToggleLanguage: _toggleLanguage,
          onSelectVideo: _setCurrentVideo,
          onContinueEmail: _goToLoginPage,
          onContinuePhone: _goToLoginPage,
        );
      }

      return AuthScreen(
        language: _language,
        t: _t,
        onToggleLanguage: _toggleLanguage,
        onBackToLanding: () => setState(() => _activePage = AppPage.landing),
      );
    }

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.black),
        child: Stack(
          children: <Widget>[
            if (useSplitLayout)
              Row(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: _ShellVideoBackground(
                            currentVideoIndex: _currentVideoIndex,
                            videoControllers: _videoControllers,
                            videoError: _videoError,
                          ),
                        ),
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[
                                  Colors.black.withValues(alpha: 0.22),
                                  Colors.black.withValues(alpha: 0.34),
                                  Colors.black.withValues(alpha: 0.54),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0B0B0D),
                        border: Border(
                          left: BorderSide(
                            color: Colors.white.withValues(alpha: 0.10),
                          ),
                        ),
                      ),
                      child: pageContent(),
                    ),
                  ),
                ],
              )
            else
              Positioned.fill(
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: _ShellVideoBackground(
                        currentVideoIndex: _currentVideoIndex,
                        videoControllers: _videoControllers,
                        videoError: _videoError,
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Colors.black.withValues(alpha: 0.30),
                              Colors.black.withValues(alpha: 0.40),
                              Colors.black.withValues(alpha: 0.60),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(child: pageContent()),
                  ],
                ),
              ),
            LoadingOverlay(isVisible: _isLoaderVisible),
          ],
        ),
      ),
    );
  }
}

class _ShellVideoBackground extends StatelessWidget {
  const _ShellVideoBackground({
    required this.currentVideoIndex,
    required this.videoControllers,
    required this.videoError,
  });

  final int currentVideoIndex;
  final List<VideoPlayerController?> videoControllers;
  final List<bool> videoError;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List<Widget>.generate(kVideoAssets.length, (index) {
        final isActive = index == currentVideoIndex;
        final controller = videoControllers[index];

        return AnimatedOpacity(
          opacity: isActive ? 1 : 0,
          duration: const Duration(milliseconds: 1000),
          child: videoError[index]
              ? const _VideoFallback()
              : _VideoLayer(controller: controller),
        );
      }),
    );
  }
}
