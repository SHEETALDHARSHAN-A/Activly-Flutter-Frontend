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
  final bool _isLoaded = true;
  int _currentVideoIndex = 0;
  AppPage _activePage = AppPage.landing;

  final List<bool> _videoError = List<bool>.filled(kVideoAssets.length, false);
  final List<VideoPlayerController?> _videoControllers =
      List<VideoPlayerController?>.filled(kVideoAssets.length, null);

  Timer? _carouselTimer;

  TranslationCopy get _t => kTranslations[_language]!;

  bool get _allLandingVideosFailed => _videoError.every((hasError) => hasError);

  bool get _isCurrentLandingVideoRenderable {
    final current = _videoControllers[_currentVideoIndex];
    final isInitialized = current?.value.isInitialized ?? false;
    return isInitialized && !_videoError[_currentVideoIndex];
  }

  bool get _showLoader {
    if (_activePage != AppPage.landing || !widget.enableVideos) {
      return false;
    }

    if (_allLandingVideosFailed) {
      return false;
    }

    return !_isCurrentLandingVideoRenderable;
  }

  @override
  void initState() {
    super.initState();

    if (widget.enableVideos) {
      _startCarouselTimer();
      unawaited(_initializeVideos());
    }
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    for (final controller in _videoControllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  Future<void> _initializeVideos() async {
    for (int i = 0; i < kVideoAssets.length; i++) {
      final controller = VideoPlayerController.asset(kVideoAssets[i]);
      _videoControllers[i] = controller;

      try {
        await controller.initialize();
        await controller.setVolume(0);
        await controller.setLooping(true);

        if (mounted) {
          setState(() {});
        }

        controller.addListener(() {
          if (!mounted) {
            return;
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
    } catch (_) {
      Future<void>.delayed(const Duration(milliseconds: 220), () async {
        if (!mounted || _currentVideoIndex != index) {
          return;
        }
        try {
          await current.play();
        } catch (_) {
          // Keep current frame if playback fails.
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

  void _handleVideoFailure(int index) {
    if (!mounted) {
      return;
    }

    setState(() {
      _videoError[index] = true;
    });

    if (index == _currentVideoIndex) {
      final fallbackIndex = _getNextPlayableIndex(index, skipIndex: index);
      if (fallbackIndex != index) {
        _setCurrentVideo(fallbackIndex);
      }
    }
  }

  void _toggleLanguage() {
    setState(() {
      _language = _language == AppLanguage.en ? AppLanguage.ar : AppLanguage.en;
    });
  }

  Future<void> _goToAiMatchPage() async {
    if (!mounted) {
      return;
    }
    setState(() => _activePage = AppPage.aiMatch);
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
      if (_activePage == AppPage.main) {
        return MainScreen(
          language: _language,
          t: _t,
          onToggleLanguage: _toggleLanguage,
          onSeeAllFeatured: () => setState(() => _activePage = AppPage.featuredAll),
        );
      }

      if (_activePage == AppPage.featuredAll) {
        return FeaturedAllScreen(
          onBack: () => setState(() => _activePage = AppPage.main),
        );
      }

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
          onSkipForNow: () async {
            if (mounted) {
              setState(() => _activePage = AppPage.main);
            }
          },
        );
      }

      if (_activePage == AppPage.aiMatch) {
        return AiMatchOnboardingScreen(
          language: _language,
          t: _t,
          onToggleLanguage: _toggleLanguage,
          isInAppMode: true,
          showBottomNavInAppMode: true,
        );
      }

      return AuthScreen(
        language: _language,
        t: _t,
        onToggleLanguage: _toggleLanguage,
        onBackToLanding: () => setState(() => _activePage = AppPage.landing),
        onAuthSuccess: () => unawaited(_goToAiMatchPage()),
      );
    }

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(color: kColorBlack),
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
                                  kColorBlack.withValues(alpha: 0.22),
                                  kColorBlack.withValues(alpha: 0.34),
                                  kColorBlack.withValues(alpha: 0.54),
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
                        color: kColorPanelDark,
                        border: Border(
                          left: BorderSide(
                            color: kColorWhite.withValues(alpha: 0.10),
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
                              kColorBlack.withValues(alpha: 0.30),
                              kColorBlack.withValues(alpha: 0.40),
                              kColorBlack.withValues(alpha: 0.60),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(child: pageContent()),
                  ],
                ),
              ),
            Positioned.fill(child: LoadingOverlay(isVisible: _showLoader)),
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
