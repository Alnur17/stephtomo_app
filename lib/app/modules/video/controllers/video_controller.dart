import 'dart:async';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  late VideoPlayerController videoPlayerController;
  var isInitialized = false.obs;
  var showControls = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void initializeVideo(String videoUrl) {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        isInitialized.value = true;
        videoPlayerController.play();
        hideControlsAfterDelay();
      });
  }

  void hideControlsAfterDelay() {
    Timer(const Duration(seconds: 3), () {
      showControls.value = false;
    });
  }

  void toggleControls() {
    showControls.value = !showControls.value;
    if (showControls.value) {
      hideControlsAfterDelay();
    }
  }

  void togglePlayPause() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
    } else {
      videoPlayerController.play();
    }
    hideControlsAfterDelay();
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    super.onClose();
  }
}
