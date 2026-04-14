part of 'package:activly/activly_app.dart';

class _VideoLayer extends StatelessWidget {
  const _VideoLayer({required this.controller});

  final VideoPlayerController? controller;

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const _VideoFallback();
    }

    final size = controller!.value.size;
    if (size.width <= 0 || size.height <= 0) {
      return const _VideoFallback();
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final targetWidth = constraints.maxWidth;
        final targetHeight = constraints.maxHeight;

        if (!targetWidth.isFinite ||
            !targetHeight.isFinite ||
            targetWidth <= 0 ||
            targetHeight <= 0) {
          return FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: VideoPlayer(controller!),
            ),
          );
        }

        final sourceAspect = size.width / size.height;
        final targetAspect = targetWidth / targetHeight;

        double renderWidth;
        double renderHeight;
        if (sourceAspect > targetAspect) {
          renderHeight = targetHeight;
          renderWidth = targetHeight * sourceAspect;
        } else {
          renderWidth = targetWidth;
          renderHeight = targetWidth / sourceAspect;
        }

        return SizedBox.expand(
          child: ClipRect(
            child: OverflowBox(
              minWidth: renderWidth,
              maxWidth: renderWidth,
              minHeight: renderHeight,
              maxHeight: renderHeight,
              alignment: Alignment.center,
              child: SizedBox(
                width: renderWidth,
                height: renderHeight,
                child: VideoPlayer(controller!),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _VideoFallback extends StatelessWidget {
  const _VideoFallback();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0xFF2A2A2A), Color(0xFF101010)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
