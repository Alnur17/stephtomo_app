import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/video_model.dart';

class VideoController extends GetxController {
  VideoPlayerController? videoPlayerController;
  var isInitialized = false.obs;
  var showControls = true.obs;
  var isPlaying = false.obs;
  var isLoading = true.obs;
  var videos = <Datum>[].obs; // Observable list to hold videos

  @override
  void onInit() {
    super.onInit();
    fetchVideos(); // Fetch videos on initialization
  }

  void deleteVideo(String id, String title, String url) async {
    try {
      var body = {"title": title, "url": url};
      var response = await BaseClient.deleteRequest(
          api: Api.deleteVideo(id: id), body: body);
      var data = await BaseClient.handleResponse(response);
      if (data != null) {
        Get.snackbar("Success", "Video deleted successfully",
            backgroundColor: AppColors.green);
        fetchVideos(); // Refresh video list
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: AppColors.red);
    }
  }

  /// Fetch video data from API using BaseClient
  Future<void> fetchVideos() async {
    try {
      isLoading.value = true;
      debugPrint("Fetching videos...");

      // Fetch stored token
      String? token = LocalStorage.getData(key: AppConstant.token);
      if (token == null || token.isEmpty) {
        debugPrint("No token found! Redirecting to login.");
        return;
      }

      debugPrint("Using Token: $token");

      // Ensure correct token format
      var headers = {
        "Authorization": "Bearer, $token",
        "Content-Type": "application/json",
      };

      debugPrint("Request Headers: $headers");

      var response =
          await BaseClient.getRequest(api: Api.videoData, headers: headers);
      var jsonResponse = await BaseClient.handleResponse(response);

      debugPrint("API Response: $jsonResponse");

      if (jsonResponse['success'] == true) {
        videos.value = VideoModel.fromJson(jsonResponse)
            .data
            .where((video) => video.url != null && video.url!.isNotEmpty)
            .toList();

        debugPrint("Videos Loaded: ${videos.length} items");
      } else {
        debugPrint("API Error: ${jsonResponse['message']}");
      }
    } catch (e) {
      debugPrint("API Fetch Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Initializes video player with a URL
  void initializeVideo(String videoUrl) {
    if (videoUrl.isEmpty || !Uri.parse(videoUrl).isAbsolute) {
      debugPrint("Error: Invalid or empty video URL!");
      return;
    }

    if (videoPlayerController != null) {
      videoPlayerController!.dispose();
      videoPlayerController = null;
    }

    debugPrint("Initializing video: $videoUrl");

    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl));

    videoPlayerController!.initialize().then((_) {
      debugPrint("Video Initialized Successfully");
      isInitialized.value = true;
      isPlaying.value = true;
      videoPlayerController!.play();
      hideControlsAfterDelay();
    }).catchError((error) {
      debugPrint("Video initialization failed: $error");

      // Retry initialization after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        debugPrint("Retrying video initialization...");
        initializeVideo(videoUrl);
      });
    });

    videoPlayerController!.addListener(() {
      isPlaying.value = videoPlayerController!.value.isPlaying;
    });
  }

  /// Hide controls after 3 seconds
  void hideControlsAfterDelay() {
    Timer(const Duration(seconds: 3), () {
      if (isPlaying.value) {
        showControls.value = false;
      }
    });
  }

  /// Toggle controls visibility
  void toggleControls() {
    showControls.value = !showControls.value;
    if (showControls.value) {
      hideControlsAfterDelay();
    }
  }

  /// Toggle play/pause
  void togglePlayPause() {
    if (videoPlayerController == null) return;

    if (videoPlayerController!.value.isPlaying) {
      videoPlayerController!.pause();
      isPlaying.value = false;
    } else {
      videoPlayerController!.play();
      isPlaying.value = true;
    }
    hideControlsAfterDelay();
  }

  @override
  void onClose() {
    debugPrint("Disposing video player...");
    videoPlayerController?.pause();
    videoPlayerController?.dispose();
    videoPlayerController = null;
    isInitialized.value = false; // ✅ Reset initialization state
    super.onClose();
  }
}
