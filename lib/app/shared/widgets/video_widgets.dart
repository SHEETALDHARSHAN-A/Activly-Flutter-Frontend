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

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: VideoPlayer(controller!),
      ),
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
