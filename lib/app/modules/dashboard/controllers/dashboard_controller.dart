import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../bookmarks/views/bookmarks_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../../video/views/video_view.dart';

class DashboardController extends GetxController {
  var currentIndex = 0.obs;

  final List<Widget> screens = [

    HomeView(),
    VideoView(),
    BookmarksView(),
    ProfileView(),
  ];
  void setBottomBarIndex(int index) {
    currentIndex.value = index;
  }
}
